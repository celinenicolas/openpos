//
//  OptionItem.swift
//  OpenPOS
//
//  Created by Celine Nicolas on 2017-02-23.
//  Copyright © 2017 WEAtone. All rights reserved.
//

import Foundation

public class OptionItem {
    
    public let Id: Int
    public let Name: String
    public let Title: String
    
    public let UnitName: String
    
    public var Price: Float = 0
    public var BasePrice: Float = 0
    public var TaxPrice: Float = 0
    
    public init(id: Int, name: String, title: String, unitName: String) {
        self.Id = id
        self.Name = name
        self.Title = title
        self.UnitName = unitName
        
        self.Price = 0
        self.BasePrice = 0
        self.TaxPrice = 0
    }
    
}

