//
//  FriendCell.swift
//  vk_gvozd_client
//
//  Created by Anton Gvozdanov on 19/09/2019.
//  Copyright © 2019 Anton Gvozdanov. All rights reserved.
//

import UIKit

class FriendCell: UITableViewCell {
    @IBOutlet weak var friendNameLabel: UILabel!
    @IBOutlet weak var friendFotoQuantLabel: UILabel!
    @IBOutlet weak var friendAvatarImage: UIImageView!
    
    override func prepareForReuse() {
        super.prepareForReuse()
        friendNameLabel.text = nil
        friendAvatarImage.image = nil
        friendFotoQuantLabel.text = nil
    }
}
