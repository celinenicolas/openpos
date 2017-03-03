//
//  DataManagerDelegate.swift
//  OpenPOS
//
//  Created by Celine Nicolas on 2017-02-20.
//
//  Note: Using a delegate (protocol) allows for asynchronous methods 
//  to send results back to our controller
//

public protocol DataManagerDelegate: class {
    
    func didReceiveData(data: [AnyObject])
    
}
