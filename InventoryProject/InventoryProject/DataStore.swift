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
            guard let key = ref.child("Chemicals").childByAutoId().key else {return}
            let addedChemical = [chemNameList.last : chemQuantityList.last]
            let childUpdates = ["/Chemicals/\(key)": addedChemical]
            ref.updateChildValues(childUpdates)
        }
    }
    var chemQuantityList: [Int] = [] {
        didSet {
            itemAdded = true
        }
    }
    
    
    func configure() {
        let chemicalRef = ref.child("Chemicals")
        chemicalRef.observe(.value) { (snap) in
//            if let chemDict = snap.value {
//                print("App starting. Here's the Firebase value: \(chemDict)")
//            }
            for child in snap.children {
                print("this is a child: \(child)")
                guard let key = self.ref.child("Chemicals").childByAutoId().key else {return}
                
            }
        }
    }
}
