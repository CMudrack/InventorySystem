//
//  ViewController.swift
//  InventoryProject
//
//  Created by Cody Mudrack on 9/29/19.
//  Copyright © 2019 Cody Mudrack. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var CardTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.

    }
    
    
    override func viewDidAppear(_ animated: Bool) {
        if DataStore.sharedInstance.itemAdded == true {
            CardTableView.beginUpdates()
            CardTableView.insertRows(at: [NSIndexPath(row: DataStore.sharedInstance.chemNameList.count-1, section: 0) as IndexPath]  , with: .automatic)
            CardTableView.insertRows(at: [NSIndexPath(row: DataStore.sharedInstance.chemQuantityList.count-1, section: 0) as IndexPath]  , with: .automatic)
            CardTableView.endUpdates()
        }
        DataStore.sharedInstance.itemAdded = false
    }
    
    //Function to set number of cells in TableView
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return DataStore.sharedInstance.chemNameList.count
    }
    
    //Funtion to add CardCell to TableView
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ChemCell", for: indexPath)
        cell.textLabel?.text = DataStore.sharedInstance.chemNameList[indexPath.row]
        return cell
    }

    // Function to go back to LoginViewController if Logout is tapped
    @IBAction func LogoutTapped(_ sender: Any) {
         presentingViewController?.dismiss(animated: true, completion: nil)
    }
    
    // Segue to send information to DetailViewController
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let identifier = segue.identifier else {
            return
        }
        
        guard identifier == "showDetail" else {
            return
        }
        
        let detailViewController = segue.destination as! DetailViewController
        
        guard let indexPath = CardTableView.indexPathForSelectedRow else {
            return
        }
        
        let name = DataStore.sharedInstance.chemNameList[indexPath.row]
        let quantity = DataStore.sharedInstance.chemQuantityList[indexPath.row]
        
        detailViewController.chemicalName = name
        detailViewController.chemicalQuantity = "\(quantity)"
    }
}

