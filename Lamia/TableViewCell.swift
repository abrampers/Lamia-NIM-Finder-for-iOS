//
//  TableViewCell.swift
//  Lamia
//
//  Created by Abram Situmorang on 8/21/17.
//  Copyright © 2017 abrampers. All rights reserved.
//

import UIKit

class TableViewCell: UITableViewCell {
    
    @IBOutlet weak var myName: UILabel!
    @IBOutlet weak var myDetails: UILabel!
    @IBOutlet weak var myEmail: UILabel!
    

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
