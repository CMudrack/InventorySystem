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
    
    var chemical: Chemical?
    
    @IBOutlet var chemNameLabel: UILabel!
    @IBOutlet var chemQuantityLabel: UILabel!
    @IBOutlet var chemNameText: UITextField!
    @IBOutlet var chemQuantityText: UITextField!
    @IBOutlet var chemLocationText: UITextField!
    @IBOutlet var chemLocationLabel: UILabel!
    
    override func viewWillAppear(_ animated: Bool) {
        chemNameText.text = chemical?.name
        
        if let chemicalQuantity = chemical?.quantity {
             chemQuantityText.text = "\(chemicalQuantity)"
        }
    
        chemLocationText.text = chemical?.location
       
        navigationItem.title = chemical?.name
    }
    
    
    @IBAction func deleteButtonPressed(_ sender: Any) {
        
        let noPDFAlert = UIAlertController(title: "Delete Item?", message: "Are you sure you want to delete this item?", preferredStyle: .alert)
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel)
        let deleteAction = UIAlertAction(title: "Delete", style: .destructive) { (action) in
            self.ref.child("Chemicals").child(self.navigationItem.title!).removeValue()
            DataStore.sharedInstance.itemAdded = true
            if let index = DataStore.sharedInstance.chemicalList.firstIndex(of: self.chemical!) {
                DataStore.sharedInstance.chemicalList.remove(at: index)
            }
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
