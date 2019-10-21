//
//  DataStore.swift
//  InventoryProject
//
//  Created by Cody Mudrack on 10/20/19.
//  Copyright © 2019 Cody Mudrack. All rights reserved.
//

import Foundation

class DataStore {
    
    static let sharedInstance: DataStore = {
        let instance = DataStore()
        return instance
    }()
   
    // Variable to facilitate data transfer from ItemInputController to ViewController
    var itemAdded = false
    
    // Variable to hold data from QRCode Scanner
    var qrCodeInput: String = "" {
        didSet {
            print("\(qrCodeInput)")
        }
    }
    // Dictionary to hold keyvalue pares for QR Codes
    var qrDict: [Int: String] = [:]
    
    // Temporary list. Will be changed to Firebase 
    var chemNameList: [String] = [] {
        didSet {
            itemAdded = true
        }
    }
    var chemQuantityList: [Int] = [] {
        didSet {
            itemAdded = true
        }
    }
    
    
    
}
