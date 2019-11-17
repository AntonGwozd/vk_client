//
//  UserSetting.swift
//  vk_gvozd_client
//
//  Created by Anton Gvozdanov on 13.11.2019.
//  Copyright © 2019 Anton Gvozdanov. All rights reserved.
//

import RealmSwift

class UserSettings: Object {
    @objc dynamic var pk = 0
    @objc dynamic var id = 0
    @objc dynamic var token = ""
    
    override class func primaryKey() -> String? {
        return "pk"
    }
} 
