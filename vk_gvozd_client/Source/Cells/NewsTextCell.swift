//
//  NewsTextCell.swift
//  vk_gvozd_client
//
//  Created by Anton Gvozdanov on 09/10/2019.
//  Copyright © 2019 Anton Gvozdanov. All rights reserved.
//

import UIKit

class NewsTextCell: UITableViewCell {
    
    @IBOutlet weak var newsText: UILabel!
    
    override func prepareForReuse() {
        super.prepareForReuse()
    
        newsText.text = nil
    }
}
