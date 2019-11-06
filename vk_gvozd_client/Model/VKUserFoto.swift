//
//  VKUserFoto.swift
//  vk_gvozd_client
//
//  Created by Anton Gvozdanov on 06.11.2019.
//  Copyright © 2019 Anton Gvozdanov. All rights reserved.
//

import UIKit

struct FotosJsData: Decodable {
    let response: FotosJsResponse
}

struct FotosJsResponse: Decodable {
    let count: Int
    let items: [VKFotosNotImage]
}

struct VKFotosNotImage: Decodable{
    let id: Int
    let photo_75: String
    let likes: VKUserFotoLikes
}

struct VKUserFotoLikes: Decodable {
    let user_likes: Int
    let count: Int
}

class VKUserFoto {
    let id: Int
    let image: UIImage
    var likes: Int
    var myLike: Int
    
    init (struckFoto: VKFotosNotImage, image: UIImage) {
        self.id = struckFoto.id
        self.image = image
        self.likes = struckFoto.likes.count
        self.myLike = struckFoto.likes.user_likes
    }
}
