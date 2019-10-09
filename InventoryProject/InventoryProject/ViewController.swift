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
    var dataSet: [String] = []
    
    
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
    
    private func tableView(_ tableView: UITableView, didSelectRowAt indexPath: NSIndexPath) {
        print(dataSet[indexPath.row])
    }

    @IBAction func LogoutTapped(_ sender: Any) {
         presentingViewController?.dismiss(animated: true, completion: nil)
    }
    
    
    @IBAction func AddItem(_ sender: Any) {
        dataSet.append("Hello")
        CardTableView.beginUpdates()
        CardTableView.insertRows(at: [NSIndexPath(row: dataSet.count-1, section: 0) as IndexPath]  , with: .automatic)
        CardTableView.endUpdates()
    }
}

