//
//  ATMCell.swift
//  ATMDiary
//
//  Created by  on 2/7/17.
//  Copyright © 2017 thanhnv. All rights reserved.
//

import UIKit

class ATMCell: UITableViewCell {

    @IBOutlet weak private var lbName: UILabel!
    @IBOutlet weak private var lbAddress: UILabel!
    
    
    static let identifier = "ATMCellIdentifier"
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    func updateCellWith(entity: ATMEntity) {
        lbName.text = entity.name
        lbAddress.text = entity.address
    }
    
}
