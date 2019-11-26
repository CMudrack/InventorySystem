//
//  DetailViewController.swift
//  InventoryProject
//
//  Created by Cody Mudrack on 11/2/19.
//  Copyright © 2019 Cody Mudrack. All rights reserved.
//

import Foundation
import Firebase
import UIKit

class DetailViewController: UIViewController {
    
    let storage = Storage.storage(url: "gs://chemreserve-d952f.appspot.com").reference()
    var ref: DatabaseReference! = Database.database().reference()

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
    
    
    @IBAction func deleteButtonPressed(_ sender: Any) {
        
        let noPDFAlert = UIAlertController(title: "Delete Item?", message: "Are you sure you want to delete this item?", preferredStyle: .alert)
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel)
        let deleteAction = UIAlertAction(title: "Delete", style: .destructive) { (action) in
            self.ref.child("Chemicals").child(self.chemNameLabel.text!).setValue(nil)
            DataStore.sharedInstance.itemAdded == true
            self.navigationController?.popViewController(animated: true)
        }
        noPDFAlert.addAction(cancelAction)
        noPDFAlert.addAction(deleteAction)
        self.present(noPDFAlert, animated: true, completion: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let identifier = segue.identifier else {
            return
        }
        
        guard identifier == "PDFDetailsSeque" else {
            return
        }
        
        let QRCodeDetails = segue.destination as! QRCodeDetails
        QRCodeDetails.chemicalName = navigationItem.title
    }
}
