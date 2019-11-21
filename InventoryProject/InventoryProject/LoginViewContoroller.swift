//
//  LoginViewContoroller.swift
//  InventoryProject
//
//  Created by Cody Mudrack on 10/8/19.
//  Copyright © 2019 Cody Mudrack. All rights reserved.
//

import UIKit
import Firebase

class LoginViewController: UIViewController {
    
    // Function to clear Username and Password fields should user Logout
    override func viewWillAppear(_ animated: Bool) {
        UserNameTextfield.text = ""
        PasswordTextField.text = ""
    }
    
    //Login Credentials
    // TEMPORARY!! Replace with call to Firebase
    let userDict = [
    "username": "kcardum",
    "password": "12345"
    ]
    
    @IBOutlet weak var UserNameLabel: UILabel!
    @IBOutlet weak var PasswordLabel: UILabel!
    @IBOutlet weak var UserNameTextfield: UITextField!
    @IBOutlet weak var PasswordTextField: UITextField!
    
    // Validate credentials and advance to ViewController
    @IBAction func SubmitTapped(_ sender: Any) {
        if UserNameTextfield.text == userDict["username"] && PasswordTextField.text == userDict["password"] {
            let MainNavigationController = storyboard?.instantiateViewController(withIdentifier: "MainNavigationController") as! MainNavigationController
            
            present(MainNavigationController, animated: true, completion: nil)
        }
    }
    
    // Tap to dismiss keyboard
    @IBAction func dismissKeyboard(_ sender: UITapGestureRecognizer) {
        UserNameTextfield.resignFirstResponder()
        PasswordTextField.resignFirstResponder()
    }
}

