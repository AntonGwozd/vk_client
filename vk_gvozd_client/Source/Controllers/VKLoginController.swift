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
        let token = params!["access_token"]
        Session.shared.token = token!
        decisionHandler(.cancel)
        performSegue(withIdentifier: "fromLoginController", sender: nil)
    }
}
