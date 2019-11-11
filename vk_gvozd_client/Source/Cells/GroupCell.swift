//
//  GroupCell.swift
//  vk_gvozd_client
//
//  Created by Anton Gvozdanov on 17/09/2019.
//  Copyright © 2019 Anton Gvozdanov. All rights reserved.
//

import UIKit

class GroupCell: UITableViewCell {
    @IBOutlet weak var groupNameLabel: UILabel!
    @IBOutlet weak var groupImageView: UIImageView!
    
    override func prepareForReuse() {
        super.prepareForReuse()
        groupImageView.image = nil
        groupNameLabel.text = nil
    }
    
    
}
