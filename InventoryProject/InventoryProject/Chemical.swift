//
//  Chemical.swift
//  InventoryProject
//
//  Created by Cody Mudrack on 11/26/19.
//  Copyright © 2019 Cody Mudrack. All rights reserved.
//

import Foundation

class Chemical: Equatable, Comparable {
    
    // This site helped me with this: https://www.hackingwithswift.com/example-code/language/how-to-conform-to-the-comparable-protocol
    static func < (lhs: Chemical, rhs: Chemical) -> Bool {
        return lhs.name < rhs.name
    }
    
    
    // This site helped me with this: https://www.hackingwithswift.com/example-code/language/how-to-conform-to-the-equatable-protocol
    static func == (lhs: Chemical, rhs: Chemical) -> Bool {
           return lhs.name == rhs.name && lhs.quantity == rhs.quantity
    }
    
    var name: String
    var quantity: Int
    var location: String
    
    init(name: String, quantity: Int, location: String) {
        self.name = name
        self.quantity = quantity
        self.location = location
    }
}
