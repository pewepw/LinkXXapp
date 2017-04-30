//
//  AddressBookTableViewCell.swift
//  LinkXXapp
//
//  Created by Harry Ng on 29/04/2017.
//  Copyright © 2017 devconcept. All rights reserved.
//

import UIKit


class AddressBookTableViewCell: UITableViewCell {

    @IBOutlet weak var iconImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
