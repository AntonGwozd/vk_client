//
//  FriendFotoCell.swift
//  vk_gvozd_client
//
//  Created by Anton Gvozdanov on 19/09/2019.
//  Copyright © 2019 Anton Gvozdanov. All rights reserved.
//

import UIKit

class FriendFotoCell: UICollectionViewCell {
    
    @IBOutlet weak var friendNameLabel: UILabel!
    @IBOutlet weak var friendNumberFotoLabel: UILabel!
    @IBOutlet weak var friendFotoImage: UIImageView!
    @IBOutlet weak var friendLikeValue: HeartControll!
    
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        friendNameLabel.text = nil
        friendNumberFotoLabel.text = nil
        friendFotoImage.image = nil
        friendLikeValue.likeValue = false
        
    }
    
}
