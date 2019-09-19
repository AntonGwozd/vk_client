//
//  VKGroup.swift
//  vk_gvozd_client
//
//  Created by Anton Gvozdanov on 18/09/2019.
//  Copyright © 2019 Anton Gvozdanov. All rights reserved.
//

import UIKit

class VKGroup {
    var groupName: String
    var groupAvatar: UIImage
    
    init (groupName: String, groupAvatar: UIImage) {
        self.groupName = groupName
        self.groupAvatar = groupAvatar
    }
}
