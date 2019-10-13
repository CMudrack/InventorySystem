//
//  ItemInputController.swift
//  InventoryProject
//
//  Created by Cody Mudrack on 10/9/19.
//  Copyright © 2019 Cody Mudrack. All rights reserved.
//

import UIKit

protocol DataDelegateProtocol {
    func sendDataToViewController(myData: String)
}

class ItemInputController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
     var delegate: DataDelegateProtocol? = nil
    
    @IBOutlet weak var ItemNameTextField: UITextField!
    @IBOutlet weak var ItemQuantityTextField: UITextField!
    
    
    @IBAction func AddItemSubmit(_ sender: Any) {
        
        // Got this code from https://medium.com/@astitv96/passing-data-between-view-controllers-using-delegate-and-protocol-ios-swift-4-beginners-e32828862d3f
        if self.delegate != nil && self.ItemNameTextField.text != nil {
            print("Add Item Button pressed")
            let dataToBeSent = self.ItemNameTextField.text
            self.delegate?.sendDataToViewController(myData: dataToBeSent!)
            _ = navigationController?.popViewController(animated: true)
        }

    }
    
    
    @IBAction func dismissKeyboard(_ sender: UITapGestureRecognizer) {
        ItemNameTextField.resignFirstResponder()
        ItemQuantityTextField.resignFirstResponder()
    }
    
}
