//
//  Order.swift
//  OpenPOS
//
//  Created by Celine Nicolas on 2017-02-23.
//
//

import Foundation

public class Order {
    
    public let Id: Int
    public let OrderId: Int
    public let UserId: Int
    
    public var DateTimeStarted: Int
    public var DateTimeFinalised: Int
    
    public var TotalPrice: Float = 0
    public var BasePrice: Float = 0
    public var TaxPrice: Float = 0
    
    public var Items: [OrderItem]
    
    public init(id: Int, orderId: Int, userId: Int) {
        self.Id = id
        self.OrderId = orderId
        self.UserId = userId
        
        var now = NSDate()
        self.DateTimeStarted = Int(now.timeIntervalSince1970)
        self.DateTimeFinalised = -1
        
        self.TotalPrice = 0
        self.BasePrice = 0
        self.TaxPrice = 0
        
        self.Items = [OrderItem]()
    }

    
    func addItem(product: ProductItem) {
        
        let itemId = self.Items.count + 1
        let item = OrderItem(id: itemId, orderId: self.OrderId, userId: self.UserId, product: product)
        
        self.TotalPrice += item.Price
        self.BasePrice  += item.BasePrice
        self.TaxPrice   += item.TaxPrice
        
        self.Items.append(item)
    }
    
    func removeItem(at: Int) {
        let item = self.Items[at]
        
        self.TotalPrice -= item.Price
        self.BasePrice  -= item.BasePrice
        self.TaxPrice   -= item.TaxPrice
        
        self.Items.remove(at: at)
    }
    
    
}
