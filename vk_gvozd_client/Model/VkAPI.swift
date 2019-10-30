//
//  VkAPI.swift
//  vk_gvozd_client
//
//  Created by Anton Gvozdanov on 30.10.2019.
//  Copyright © 2019 Anton Gvozdanov. All rights reserved.
//

import UIKit
import Alamofire
import WebKit

class VkAPI {
    
    func authorize (webView: WKWebView, viewController: VKLoginController) {
        var urlComposer = URLComponents()
        urlComposer.scheme = "https"
        urlComposer.host = "oauth.vk.com"
        urlComposer.path = "/authorize"
        urlComposer.queryItems = [
            URLQueryItem(name: "client_id", value: Session.shared.vkClientID),
            URLQueryItem(name: "display", value: "mobile"),
            URLQueryItem(name: "redirect_uri", value: "https://oauth.vk.com/blank.html"),
            URLQueryItem(name: "scope", value: "262150"),
            URLQueryItem(name: "response_type", value: "token"),
            URLQueryItem(name: "v", value: Session.shared.vkAPIVersion)
        ]
        
        webView.load(URLRequest(url: urlComposer.url!))
        
        webView.navigationDelegate = viewController
    }
    
    //Возвращает массив друзей типа VKUser
    func getFriensList(){
        // Заготовка для заполнения интерфейса
        //var userArray = [VKUser]()
        let url = "https://api.vk.com/method/friends.get"
        let parameters = [
            "scope": "262150",
            "fields": "nickname, photo_50",
            "v": Session.shared.vkAPIVersion,
            "access_token": Session.shared.token
        ]

        Alamofire.request(url, method: .get, parameters: parameters).responseJSON { repsonse in
            guard let json = repsonse.value else { return }
            print(json)
        }
    }
    
    //Возвращает массив фото пользоваетля
    func getUserPhotos(){
        let url = "https://api.vk.com/method/photos.getAll"
        let parameters = [
            "scope": "262150",
            "owner_id": "7763148",
            "extended": "1", //лайки же нам пригодятся!
            "v": Session.shared.vkAPIVersion,
            "access_token": Session.shared.token
        ]
        
        Alamofire.request(url, method: .get, parameters: parameters).responseJSON { repsonse in
            guard let json = repsonse.value else { return }
            print(json)
        }
    }
    
    //Возвращает массив групп пользователя
    func getUsersGroup(){
        let url = "https://api.vk.com/method/groups.get"
        let parameters = [
            "scope": "262150",
            "v": Session.shared.vkAPIVersion,
            "access_token": Session.shared.token
        ]
        
        Alamofire.request(url, method: .get, parameters: parameters).responseJSON { repsonse in
            guard let json = repsonse.value else { return }
            print(json)
        }
    }
    
    //Возвращает массив групп по поиску
    func getUsersGroupFilter(){
        let url = "https://api.vk.com/method/groups.search"
        let parameters = [
            "scope": "262150",
            "q": "search text",
            "type": "group",
            "v": Session.shared.vkAPIVersion,
            "access_token": Session.shared.token
        ]
        
        Alamofire.request(url, method: .get, parameters: parameters).responseJSON { repsonse in
            guard let json = repsonse.value else { return }
            print(json)
        }
    }
    
}
