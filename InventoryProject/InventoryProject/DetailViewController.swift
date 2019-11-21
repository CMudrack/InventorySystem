//
//  DetailViewController.swift
//  InventoryProject
//
//  Created by Cody Mudrack on 11/2/19.
//  Copyright © 2019 Cody Mudrack. All rights reserved.
//

import Foundation
import UIKit

class DetailViewController: UIViewController {
   
    var chemicalName: String? {
        didSet {
            navigationItem.title = chemicalName
        }
    }
    
    var chemicalQuantity: String?
    
    @IBOutlet var chemNameLabel: UILabel!
    @IBOutlet var chemQuantityLabel: UILabel!
    @IBOutlet var chemNameText: UITextField!
    @IBOutlet var chemQuantityText: UITextField!
    
    override func viewWillAppear(_ animated: Bool) {
        chemNameText.text = chemicalName
        chemQuantityText.text = chemicalQuantity
    }
    
}
