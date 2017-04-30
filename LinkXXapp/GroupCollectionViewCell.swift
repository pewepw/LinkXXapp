//
//  GroupCollectionViewCell.swift
//  LinkXXapp
//
//  Created by Harry Ng on 01/05/2017.
//  Copyright © 2017 devconcept. All rights reserved.
//

import UIKit
import SDWebImage

class GroupCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var groupImageView: UIImageView!
    @IBOutlet weak var groupLabel: UILabel!
    
    var group: Group? {
        didSet {
            updateView()
        }
    }
    
    func updateView() {
        if let photoUrlString = group?.photoUrl {
            let photoUrl = URL(string: photoUrlString)
            groupImageView.sd_setImage(with: photoUrl)
        }
        
        groupLabel.text = group?.groupName
        
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        groupLabel.text = ""
        
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()

        groupImageView.image = UIImage(named: "ava")

    }


}
