//
//  CardCell.swift
//  InventoryProject
//
//  Created by Cody Mudrack on 9/29/19.
//  Copyright © 2019 Cody Mudrack. All rights reserved.
//

import UIKit

class CardCell: UITableViewCell {

    @IBOutlet weak var cardLabel: UILabel!
    @IBOutlet weak var cardView: UIView!
    
    func configure(title: String) {
        cardLabel.text = title
    }
    
    
}
