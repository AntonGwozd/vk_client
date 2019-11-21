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
    @IBOutlet weak var friendAvatar: AvatarView!
    @IBOutlet weak var avatarConstrain: NSLayoutConstraint!
    
    override func prepareForReuse() {
        super.prepareForReuse()
        friendNameLabel.text = nil
//        friendAvatar.image = nil
        friendFotoQuantLabel.text = nil
    }
    
    func animationWillDisplay() {
        self.layoutIfNeeded()
        UIView.animate(withDuration: 0.1, delay: 0, options: .curveEaseOut, animations: {
            self.avatarConstrain.constant = 80
            self.layoutIfNeeded()
        }) { _ in
            UIView.animate(withDuration: 0.2, delay: 0, usingSpringWithDamping: 0.4, initialSpringVelocity: 20, options: .curveEaseOut, animations: {
                self.avatarConstrain.constant = 16
                self.layoutIfNeeded()
            })
        }
    }
}
