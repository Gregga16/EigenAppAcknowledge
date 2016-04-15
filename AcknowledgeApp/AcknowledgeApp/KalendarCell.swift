//
//  KalendarCell.swift
//  AcknowledgeApp
//
//  Created by Fhict on 15/04/16.
//  Copyright © 2016 Gregory Lammers. All rights reserved.
//

import UIKit

class KalendarCell: UITableViewCell {

    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var lblStart: UILabel!
    @IBOutlet weak var lblEnd: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
