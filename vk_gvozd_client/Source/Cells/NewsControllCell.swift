//
//  NewsControllCell.swift
//  vk_gvozd_client
//
//  Created by Anton Gvozdanov on 10/10/2019.
//  Copyright © 2019 Anton Gvozdanov. All rights reserved.
//

import UIKit

class NewsControllCell: UITableViewCell {
    
    @IBOutlet weak var newsLikeCount: UILabel!
    @IBOutlet weak var newsLikeValue: HeartControll!
    @IBOutlet weak var newsSeeCount: UILabel!
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        newsLikeCount.text = nil
        newsSeeCount.text = nil
        newsLikeValue.likeValue = false
    }
}
