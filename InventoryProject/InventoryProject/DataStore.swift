//
//  DataStore.swift
//  InventoryProject
//
//  Created by Cody Mudrack on 10/20/19.
//  Copyright © 2019 Cody Mudrack. All rights reserved.
//

import Foundation
import Firebase

class DataStore {
    
    static let sharedInstance: DataStore = {
        let instance = DataStore()
        return instance
    }()
    
    // FireBase Realtime Database reference
    var ref: DatabaseReference! = Database.database().reference()
    var databaseHandle: DatabaseHandle?
   
    // Variable to facilitate data transfer from ItemInputController to ViewController
    var itemAdded = false
    
    // Dictionary to hold keyvalue pares for QR Codes
    var qrDict: [Int: String] = [:]
    
    // Temporary list. Will be changed to Firebase 
    var chemNameList: [String] = [] {
        didSet {
            itemAdded = true            
            //chemNameList.sort()
        }
    }
    var chemQuantityList: [Int] = [] {
        didSet {
            itemAdded = true
        }
    }
    
    func configure() {
        let chemicalRef = ref.child("Chemicals")
        
        let connectedRef = Database.database().reference(withPath: ".info/connected")
        connectedRef.observe(.value, with: { snapshot in
          if snapshot.value as? Bool ?? false {
            print("Connected")
          } else {
            print("Not connected")
          }
        })
        
        // This site helped with this https://stackoverflow.com/questions/47115273/getting-list-of-items-from-firebase-swift
        chemicalRef.observeSingleEvent(of: .value,  with: { snap in
            for child in snap.children{
                let snap = child as! DataSnapshot
                let snapInfo = snap.value as! [String : Any]
                let name = snapInfo["name"] as! String
                let quantity = snapInfo["quantity"]
                print("name is \(name)")
            
                self.chemNameList.append(name)
            
                if let unwrappedQuantity = quantity {
                    self.chemQuantityList.append(unwrappedQuantity as! Int)
                }
            }
        })
    }
}
