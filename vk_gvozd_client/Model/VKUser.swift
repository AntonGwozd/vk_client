//
//  VKUser.swift
//  vk_gvozd_client
//
//  Created by Anton Gvozdanov on 18/09/2019.
//  Copyright © 2019 Anton Gvozdanov. All rights reserved.
//

import UIKit
import RealmSwift

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
    let photo_50: String
    let online: Int
}

class VKUser: Object {
    @objc dynamic var id = 0
    @objc dynamic var online = ""
    @objc dynamic var userName = ""
    @objc dynamic var userAvatar: Data? = nil
}
