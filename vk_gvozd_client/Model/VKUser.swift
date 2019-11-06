//
//  VKUser.swift
//  vk_gvozd_client
//
//  Created by Anton Gvozdanov on 18/09/2019.
//  Copyright © 2019 Anton Gvozdanov. All rights reserved.
//

import UIKit

struct FriendsJsData: Decodable {
    let response: FriensJsResponse
}

struct FriensJsResponse: Decodable {
    let count: Int
    let items: [VKUserNotImage]
}

struct VKUserNotImage: Decodable{
    let id: Int
    let first_name: String
    let last_name: String
    //let nickname: String
    let photo_50: String
    let online: Int
    //let track_code: String
}

class VKUser {
    let id: Int
    let first_name: String
    let last_name: String
    let online: Int
    var userName: String {last_name + " " + first_name}
    var userAvatar: UIImage
    
    init(structUser: VKUserNotImage, userAvatar: UIImage) {
        self.id = structUser.id
        self.first_name = structUser.first_name
        self.last_name = structUser.last_name
        self.online = structUser.online
        self.userAvatar = userAvatar
    }
}
