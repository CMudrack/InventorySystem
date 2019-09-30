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
    let dataSet: [String] = ["Test", "Test 2", "Test 3", "Test 4"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataSet.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cardCell") as! CardCell
        cell.configure(title: dataSet[indexPath.row])
        return cell
    }

}

