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
            //ref.child("Chemicals").setValue(chemNameList)
//            guard let key = ref.child("Chemicals").childByAutoId().key else {return}
//            let addedChemical = [chemNameList.last : chemQuantityList.last]
//            let childUpdates = ["/Chemicals/\(key)": addedChemical]
//            ref.updateChildValues(childUpdates)
            
            ref.child("Chemicals").childByAutoId().setValue(chemNameList.last)
        }
    }
    var chemQuantityList: [Int] = [] {
        didSet {
            itemAdded = true
        }
    }
    
    
    func configure() {
        let chemicalRef = ref.child("Chemicals")
        databaseHandle = chemicalRef.observe(.childAdded) { (snap) in
            let chemical = snap.value as? String
            
            if let actualChemical = chemical {
                self.chemNameList.append(actualChemical)
            }
        }
        
        itemAdded = true
//        chemicalRef.observe(.value) { (snap) in
//
//            for child in snap.children {
//                print("this is a child: \(child)")
//
//            }
//        }
    }
}
