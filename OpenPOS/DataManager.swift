//
//  DataManager.swift
//  OpenPOS
//
//  Created by Celine Nicolas on 2017-02-17.
//  Copyright © 2017 WEAtone. All rights reserved.
//
//  Note: This class is to manage all the data. Some methods are private (internal), some public for app usage
//  Ideally, all the data should be persistent, using either SQLite or Core Data, and use cache...
//  But this is just a simple test !
//  A few todos...

import Foundation

enum DataManagerError: Error {
    
    case Unknown
    case FailedRequest
    case InvalidResponse
    case InvalidFile
    
}

public class DataManager {
    
    typealias DataCompletion = (Any?, DataManagerError?) -> ()
    weak var delegate:DataManagerDelegate?

    
    let baseURL: URL?
    
    init(baseURL: URL? = nil) {
        self.baseURL = baseURL
    }
    
    public func setDelegate(delegate: DataManagerDelegate ) {
        self.delegate = delegate
    }
    
    // Note: TODO: should test for http allowed and request didn't fail. Later
    func getAPIDataForURL(_ path: String, _ query:String?, completion: @escaping DataCompletion) {
        if ( self.baseURL == nil ) {
            getLocalDataForFile( path, query, completion: completion)
            return
        }
        
        // Create URL
        var URL = baseURL?.appendingPathComponent(path)
        if ( query != nil ) {
            URL?.appendPathComponent("/?")
            URL?.appendPathComponent(query!)
        }
        
        
        // Create Data Task
        URLSession.shared.dataTask(with: URL!) { (data, response, error) in
            self.didFetchData(data: data, response: response, error: error, completion: completion)
        }.resume()
    }
    
    func getLocalDataForFile(_ path: String, _ query:String?, completion: @escaping DataCompletion) {
        if let filepath = Bundle.main.path(forResource: path , ofType: "json") {
            do {
                let data = try Data(contentsOf: URL(fileURLWithPath: filepath), options: .alwaysMapped)
                processData(data: data, completion: completion)
            } catch {
                completion(nil, .InvalidFile)
            }
        } else {
            print("invalid file")
            completion(nil, .InvalidFile)
        }
    }
    
    
    
    public func retrieveCategories(forCategory: Int, withProducts: Bool? = false) {
        var items = [CategoryItem]()
        
        // load JSON/REST data
        self.getAPIDataForURL("categories", "categoryId=" + String(forCategory)) { (response, error) in
            if response != nil {
                for item in response as! Array<AnyObject> {
                    
                    let categoryId = item["CategoryId"] as! Int
                    if ( categoryId == forCategory ) { // Filter
                        let newItem:CategoryItem = CategoryItem(id: item["Id"] as! Int, title: item["Title"] as! String, categoryId: 0)
                        items.append(newItem)
                    }
                    
                }
                
                // Obviously this should have it's own method... but I'll keep it simple for now.
                if ( withProducts == true ) {
                    
                    self.getAPIDataForURL("products", nil) { (response, error) in
                        if response != nil {
                            
                            var allProducts = [ProductItem]()

                            for item in response as! Array<AnyObject> {
                                
                                    let newItem:ProductItem = ProductItem(id: item["Id"] as! Int, title: item["Title"] as! String)
                                    newItem.CategoryId  = item["CategoryId"] as! Int
                                    newItem.Summary     = item["Summary"] as! String
                                    newItem.Price       = item["Price"] as! Float
                                    newItem.BasePrice   = item["BasePrice"] as! Float
                                    newItem.TaxPrice    = item["TaxPrice"] as! Float
                                
                                    let index = items.index(where: {$0.Id == newItem.CategoryId}) // index of category object
                                    items[index!].Products.append(newItem)
                            }
                        
                            self.delegate?.didReceiveData(data: items as Array<AnyObject>)
                            return
                        }
                        
                    }
                    
                    
                } else {
                    
                    // send back the data to the delegate (view controller or else)
                    self.delegate?.didReceiveData(data: items as Array<AnyObject>)
                    return
                    
                }
            }
        }
        
        // if we do no get any results, make sure we still return an empty array
        self.delegate?.didReceiveData(data: items as Array<AnyObject>)
    }
    
    public func retrieveOptions(forProduct: Int) {
        // TODO: retrieve optionslist, than options (same way as retrieveCategories)
    }
    
    public func verifyPayment() {
    }
    
    public func sendOrder() {
        
        // check order, prepare
        
        // place order (API)
        
        // verifyPayment (3rd party) -> User Interface
        
        // ok. receipt (order closed)
        
        // error -> action (clean? try again? etc.)
        
    }
    
    
    private func didFetchData(data: Data?, response: URLResponse?, error: Error?, completion: DataCompletion) {
        if let _ = error {
            completion(nil, .FailedRequest)
            
        } else if let data = data, let response = response as? HTTPURLResponse {
            if response.statusCode == 200 {
                processData(data: data, completion: completion)
            } else {
                completion(nil, .FailedRequest)
            }
            
        } else {
            completion(nil, .Unknown)
        }
    }
    
    // Note: as of now, there is a bug with accents. Sorry. Will fix it later.
    private func processData(data: Data, completion: DataCompletion) {
        if let JSON = try? JSONSerialization.jsonObject(with: data, options: .mutableContainers) as Any {
            completion(JSON, nil)
        } else {
            completion(nil, .InvalidResponse)
            print("Oops, sth went wrong with your JSON...")

        }
    }
    
}
