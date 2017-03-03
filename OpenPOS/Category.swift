//
//  Category.swift
//  OpenPOS
//
//  Created by Celine Nicolas on 2017-02-15.
//  Copyright © 2017 WEAtone. All rights reserved.
//

import UIKit

public class CategoryItem {
    
    public let Id: Int
    public let Title: String
    public let CategoryId: Int
    
    public var Products: [ProductItem] = [ProductItem]()
    
    public init(id: Int, title: String, categoryId: Int) {
        self.Id = id
        self.Title = title
        self.CategoryId = categoryId
    }
    
}
