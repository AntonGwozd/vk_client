//
//  NewsFotoCell.swift
//  vk_gvozd_client
//
//  Created by Anton Gvozdanov on 09/10/2019.
//  Copyright © 2019 Anton Gvozdanov. All rights reserved.
//

import UIKit

class NewsFotoCell: UITableViewCell {
    
    @IBOutlet weak var newsFoto: UIImageView!
    
    override func prepareForReuse() {
        super.prepareForReuse()
    
        newsFoto.image = nil
    }
}
