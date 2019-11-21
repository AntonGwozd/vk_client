//
//  SessionClass.swift
//  vk_gvozd_client
//
//  Created by Anton Gvozdanov on 22.10.2019.
//  Copyright © 2019 Anton Gvozdanov. All rights reserved.
//

import UIKit
import RealmSwift

class SessionClass: Object {
    @objc dynamic var id = 0
    @objc dynamic var userId = 0
    @objc dynamic let vkAPIVersion = "5.68"
    @objc dynamic let vkClientID = "7188698"
    @objc dynamic var tokenIsCorrect = false
    
    override class func primaryKey() -> String? {
        return "id"
    }
}

