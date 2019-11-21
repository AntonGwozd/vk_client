//
//  JSONError.swift
//  vk_gvozd_client
//
//  Created by Anton Gvozdanov on 14.11.2019.
//  Copyright © 2019 Anton Gvozdanov. All rights reserved.
//

import Foundation

struct ErrorJSData: Decodable {
    let error: ErrorJS
}

struct ErrorJS: Decodable {
    var error_code: Int
    var error_msg: String
}
