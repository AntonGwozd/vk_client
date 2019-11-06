//
//  VKGroup.swift
//  vk_gvozd_client
//
//  Created by Anton Gvozdanov on 18/09/2019.
//  Copyright © 2019 Anton Gvozdanov. All rights reserved.
//

import UIKit

struct GroupsJsData: Decodable {
    let response: GroupsJsResponse
}

struct GroupsJsResponse: Decodable {
    let count: Int
    let items: [VKGroupNotImage]
}

struct VKGroupNotImage: Decodable{
    let id: Int
    let name: String
    let photo_50: String
}

class VKGroup {
    let id: Int
    let groupName: String
    let groupAvatar: UIImage
    
    init (struckGroup: VKGroupNotImage, groupAvatar: UIImage) {
        self.id = struckGroup.id
        self.groupName = struckGroup.name
        self.groupAvatar = groupAvatar
    }
}
