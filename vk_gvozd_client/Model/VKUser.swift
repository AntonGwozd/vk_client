//
//  VKUser.swift
//  vk_gvozd_client
//
//  Created by Anton Gvozdanov on 18/09/2019.
//  Copyright © 2019 Anton Gvozdanov. All rights reserved.
//

import UIKit

class VKUser {
    var userName: String
    var userAvatar: UIImage
    var userFoto: [UIImage]
    
    init (userName: String, userAvatar: UIImage) {
        self.userName = userName
        self.userAvatar = userAvatar
        self.userFoto = []
        addFoto(userAvatar)
    }
    
    func addFoto(_ newFoto: UIImage) {
        self.userFoto.append(newFoto)
    }
}
