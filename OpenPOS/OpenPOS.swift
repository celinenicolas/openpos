//
//  OpenPOS.swift
//  OpenPOS
//
//  Created by Celine Nicolas on 2017-02-15.
//  Copyright © 2017 WEAtone. All rights reserved.
//
//  Note: SDK initialization + cart methods
//  This is clearly just a shell that would need to be completed.

import Foundation



public class OpenPOS {
    
    static let sharedInstance = OpenPOS()
    var apiKey: String?
    var endpointUrl: String?
    
    var currentOrder:Order?
    var currentUserId:Int = 0
    
    public var dataManager:DataManager?

    
    public static func getInstance() -> OpenPOS {
        return sharedInstance
    }
    
    public static func config(apiKey: String, endpointURL: String? = nil) -> OpenPOS {
        sharedInstance.apiKey = apiKey
        
        // TODO: endpoint
        
        // Init data manager
        if ( sharedInstance.endpointUrl != nil ) {
            sharedInstance.dataManager = DataManager(baseURL: URL(string: sharedInstance.endpointUrl!)!)
        } else {
            sharedInstance.dataManager = DataManager()
        }
        
        return sharedInstance
    }
    
    public func getLatestOrCreateCart() -> Order {
        
        // Create a new cart
        if (currentOrder == nil) {
            currentOrder = Order(id: 1,orderId: 1, userId: currentUserId)
        }
        
        return currentOrder!
    }
    
    public func clearCart() {
        currentOrder = nil
    }
    
    public func getCartItems() -> [OrderItem] {
        getLatestOrCreateCart()
        return (currentOrder?.Items)!
    }
    
    public func addItemToCart(product: ProductItem) {
        getLatestOrCreateCart()
        currentOrder?.addItem(product: product)
    }
    
    public func removeFromCart(atIndex: Int) {
        currentOrder?.removeItem(at: atIndex)
    }
    
    public func checkout() {
        // dataManager.sendOrder()
    }
    
    
}
