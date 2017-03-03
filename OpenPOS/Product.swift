//
//  Product.swift
//  OpenPOS
//
//  Created by Celine Nicolas on 2017-02-15.
//  Copyright © 2017 WEAtone. All rights reserved.
//

import UIKit

public class ProductItem {
    
    public let Id: Int
    public var CategoryId: Int
    public var ProductId: String    // ProductId would be the Client's ProductId > Link with its current system
    public var Title: String
    public var Summary: String?
    public var Price: Float = 0
    public var BasePrice: Float = 0
    public var TaxPrice: Float = 0
    
    public init(id: Int, title: String) {
        self.Id = id
        self.CategoryId = -1
        self.ProductId = "product_" + String(id)
        self.Title = title
        
        self.Summary = nil
        
        self.Price = 0
        self.BasePrice = 0
        self.TaxPrice = 0
    }
    
}
