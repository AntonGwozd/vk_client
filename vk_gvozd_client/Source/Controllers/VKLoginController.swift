//
//  VKLoginController.swift
//  vk_gvozd_client
//
//  Created by Anton Gvozdanov on 29.10.2019.
//  Copyright © 2019 Anton Gvozdanov. All rights reserved.
//

import UIKit
import Alamofire
import WebKit

class VKLoginController: UIViewController {
    @IBOutlet weak var webView: WKWebView!
    var vkAPI = VkAPI()
    let dataBase = DBClass()
    
    override func viewDidLoad() {
        vkAPI.authorize(webView: webView, viewController: self)
    }
    
    override func shouldPerformSegue(withIdentifier identifier: String, sender: Any?) -> Bool {
        if identifier == "fromLoginController" {
            return true
        }
        return false
    }
}

extension VKLoginController: WKNavigationDelegate {
    func webView(_ webView: WKWebView, decidePolicyFor navigationResponse: WKNavigationResponse, decisionHandler: @escaping (WKNavigationResponsePolicy) -> Void) {
        guard let url = navigationResponse.response.url,
        url.path == "/blank.html" else {
                decisionHandler(.allow)
                return
        }
        
        let params = url.fragment?
            .components(separatedBy: "&")
            .map{ $0.components(separatedBy: "=") }
            .reduce([String: String](), {(result, params) in
                var dict = result
                let key = params[0]
                let value = params[1]
                dict[key] = value
                return dict
            })
        let tokenVK = params?["access_token"]
        let userIdVK = params?["user_id"]
        
        //выведем токен в консоль, что бы забирать в постман
        print(tokenVK)
        
        Session.shared.token = tokenVK ?? ""
        Session.shared.userId = Int(userIdVK ?? "") ?? 0
        
        let userSetting = dataBase.getUserSetting()
        userSetting.pk = 0
        userSetting.token = tokenVK ?? ""
        userSetting.id = Int(userIdVK ?? "") ?? 0
        dataBase.saveObject(object: userSetting)
        
        decisionHandler(.cancel)
        
        performSegue(withIdentifier: "fromLoginController", sender: nil)
    }
}
