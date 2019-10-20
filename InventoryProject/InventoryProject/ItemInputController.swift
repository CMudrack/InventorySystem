//
//  ItemInputController.swift
//  InventoryProject
//
//  Created by Cody Mudrack on 10/9/19.
//  Copyright © 2019 Cody Mudrack. All rights reserved.
//

import UIKit

// Protocol to send data back to ViewController

class ItemInputController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBOutlet weak var ItemNameTextField: UITextField!
    @IBOutlet weak var ItemQuantityTextField: UITextField!
    
    
    // Function to check if ensure required textfields have been filled out and utilizes delegate to send data back to ViewController
    @IBAction func AddItemSubmit(_ sender: Any) {

        if ItemNameTextField.text != "" && ItemQuantityTextField.text != "" {
            let ItemQuantityAsInt = Int(ItemQuantityTextField.text!)!
            
            DataStore.sharedInstance.chemNameList.append(ItemNameTextField.text!)
            DataStore.sharedInstance.chemQuantityList.append(ItemQuantityAsInt)
            _ = navigationController?.popViewController(animated: true)
        }
    }
    
    // Tap to dismiss keyboard
    @IBAction func dismissKeyboard(_ sender: UITapGestureRecognizer) {
        ItemNameTextField.resignFirstResponder()
        ItemQuantityTextField.resignFirstResponder()
    }
    
}
