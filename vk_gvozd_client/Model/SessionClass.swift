//
//  SessionClass.swift
//  vk_gvozd_client
//
//  Created by Anton Gvozdanov on 22.10.2019.
//  Copyright © 2019 Anton Gvozdanov. All rights reserved.
//

import UIKit

class Session {
    static let shared = Session()
    private init () { }
    
    var token = String()
    var userId = Int()
}

