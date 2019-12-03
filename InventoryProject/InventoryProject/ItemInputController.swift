//
//  ItemInputController.swift
//  InventoryProject
//
//  Created by Cody Mudrack on 10/9/19.
//  Copyright © 2019 Cody Mudrack. All rights reserved.
//

import UIKit
import Firebase

// Protocol to send data back to ViewController

class ItemInputController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBOutlet weak var ItemNameTextField: UITextField!
    @IBOutlet weak var ItemQuantityTextField: UITextField!
    @IBOutlet var ItemLocationTextField: UITextField!
    var ref: DatabaseReference! = Database.database().reference()
    
    
    // Function to check if ensure required textfields have been filled out and utilizes delegate to send data back to ViewController
    @IBAction func AddItemSubmit(_ sender: Any) {

        if ItemNameTextField.text != "" && ItemQuantityTextField.text != "" && ItemLocationTextField.text != "" {
            let ItemQuantityAsInt = Int(ItemQuantityTextField.text!)!
            
            let chemicalObject = Chemical(name: ItemNameTextField.text!, quantity: ItemQuantityAsInt, location: ItemLocationTextField.text!)
            
            DataStore.sharedInstance.chemicalList.append(chemicalObject)
            
            let chemical = ["name": chemicalObject.name as Any, "quantity": chemicalObject.quantity, "location": chemicalObject.location] as [String : Any]
            
            // Save name and quantity to Firebase Database
            ref.child("Chemicals").child(ItemNameTextField.text!).setValue(chemical)
            
            _ = navigationController?.popViewController(animated: true)
        }
    }
    
    // Tap to dismiss keyboard
    @IBAction func dismissKeyboard(_ sender: UITapGestureRecognizer) {
        ItemNameTextField.resignFirstResponder()
        ItemQuantityTextField.resignFirstResponder()
    }
    
}
