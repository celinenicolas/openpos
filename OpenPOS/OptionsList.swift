//
//  OptionsList.swift
//  OpenPOS
//
//  Created by Celine Nicolas on 2017-02-23.
//  Copyright © 2017 WEAtone. All rights reserved.
//

import Foundation

public class OptionsList {
    
    public let Id: Int
    public let Name: String
    public let Title: String
    
    public var Options: [OptionItem]
    
    public init(id: Int, name: String, title: String) {
        self.Id = id
        self.Name = name
        self.Title = title
        
        self.Options = [OptionItem]()
    }
}
