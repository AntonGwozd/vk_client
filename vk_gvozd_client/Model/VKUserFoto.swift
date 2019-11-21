//
//  VKUserFoto.swift
//  vk_gvozd_client
//
//  Created by Anton Gvozdanov on 06.11.2019.
//  Copyright © 2019 Anton Gvozdanov. All rights reserved.
//

import UIKit
import RealmSwift

struct FotosJsData: Decodable {
    let response: FotosJsResponse
    let error: ErrorJS?
}

struct FotosJsResponse: Decodable {
    let count: Int
    let items: [VKFotosNotImage]
}

struct VKFotosNotImage: Decodable{
    let id: Int
    let owner_id: Int
    let photo_75: String
    let likes: VKUserFotoLikes
}

struct VKUserFotoLikes: Decodable {
    let user_likes: Int
    let count: Int
}

class VKUserFoto: Object {
    @objc dynamic var id = 0
    @objc dynamic var owner_id = 0
    @objc dynamic var image = ""
    @objc dynamic var likes = 0
    @objc dynamic var myLike = false
}
