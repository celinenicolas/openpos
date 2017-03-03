//
//  OrderItem.swift
//  OpenPOS
//
//  Created by Celine Nicolas on 2017-02-23.
//
//

import Foundation

public class OrderItem {
    
    public let Id: Int
    public let OrderId: Int
    public let UserId: Int
    public let ProductId: String
    public var DateTime: Int
    
    public var Price: Float = 0           // We make sure to get the price now as the Product price could later change !
    public var BasePrice: Float = 0
    public var TaxPrice: Float = 0
    
    public var TotalPrice: Float = 0
    public var TotalBasePrice: Float = 0
    public var TotalTaxPrice: Float = 0
    
    public var Title: String?             // Cosmetic only, required to print / view receipts etc
    
    public var Options: [OptionItem]
    //public var ExtraOptions: String?    // Not implemented. Free text in case the user has special requests (allergies, ...)
    
    public init(id: Int, orderId: Int, userId: Int, product: ProductItem) {
        self.Id = id
        self.OrderId = orderId
        self.UserId = userId
        self.ProductId = product.ProductId
        
        var now = NSDate()
        self.DateTime = Int(now.timeIntervalSince1970)
        
        self.Price = product.Price
        self.BasePrice = product.BasePrice
        self.TaxPrice = product.TaxPrice
        
        self.TotalPrice = product.Price
        self.TotalBasePrice = product.BasePrice
        self.TotalTaxPrice = product.TaxPrice
        
        self.Title = product.Title
        
        self.Options = [OptionItem]()
    }
    
    func addOption(option: OptionItem) {
        self.TotalPrice += option.Price
        self.BasePrice  += option.BasePrice
        self.TaxPrice   += option.TaxPrice
        
        self.Options.append(option)
    }
    
    func removeOption(at: Int) {
        let option = self.Options[at]
        
        self.TotalPrice -= option.Price
        self.BasePrice  -= option.BasePrice
        self.TaxPrice   -= option.TaxPrice
        
        self.Options.remove(at: at)
    }
    
}
