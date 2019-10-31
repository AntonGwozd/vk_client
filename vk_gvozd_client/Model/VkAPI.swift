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
    func getFriensList(viewController: FriendsViewController){
        var urlComposer = URLComponents()
        urlComposer.scheme = "https"
        urlComposer.host = "api.vk.com"
        urlComposer.path = "/method/friends.get"
        
        let parameters = [
            "scope": "262150",
            "v": Session.shared.vkAPIVersion,
            "fields": "nickname,photo_50",
            "access_token": Session.shared.token
        ]

        Alamofire.request(urlComposer.url!, method: .get, parameters: parameters).responseJSON { response in
            switch response.result {
            case .success:
                if let objJson = response.result.value as! [String: Any]? {
                    let responseJson = objJson["response"] as! [String: Any]?
                    let itemsArray = responseJson!["items"] as! [[String: Any]]
//                    print(itemsArray)
                    for userItem in itemsArray {
                        let userName = userItem["last_name"] as! String //+ " " + userItem["first_name"] as! String
                        viewController.allFriendsMaster.append(VKUser(userName: userName, userAvatar: UIImage(named: "BlueMonster")!))
                    }
                }
            case .failure(let error):
                print("Error: \(error)")
            }
        }
        
    }
    
    //Возвращает массив фото пользоваетля
    func getUserPhotos(){
        var urlComposer = URLComponents()
        urlComposer.scheme = "https"
        urlComposer.host = "api.vk.com"
        urlComposer.path = "/method/photos.getAll"
        let parameters = [
            "scope": "262150",
            "owner_id": "7763148",
            "extended": "1", //лайки же нам пригодятся!
            "v": Session.shared.vkAPIVersion,
            "access_token": Session.shared.token
        ]
        
        Alamofire.request(urlComposer.url!, method: .get, parameters: parameters).responseJSON { repsonse in
            guard let json = repsonse.value else { return }
            print(json)
        }
    }
    
    //Возвращает массив групп пользователя
    func getUsersGroup(){
        var urlComposer = URLComponents()
        urlComposer.scheme = "https"
        urlComposer.host = "api.vk.com"
        urlComposer.path = "/method/groups.get"
        let parameters = [
            "scope": "262150",
            "v": Session.shared.vkAPIVersion,
            "access_token": Session.shared.token
        ]
        
        Alamofire.request(urlComposer.url!, method: .get, parameters: parameters).responseJSON { repsonse in
            guard let json = repsonse.value else { return }
            print(json)
        }
    }
    
    //Возвращает массив групп по поиску
    func getUsersGroupFilter(){
        var urlComposer = URLComponents()
        urlComposer.scheme = "https"
        urlComposer.host = "api.vk.com"
        urlComposer.path = "/method/groups.search"
        let parameters = [
            "scope": "262150",
            "q": "search text",
            "type": "group",
            "v": Session.shared.vkAPIVersion,
            "access_token": Session.shared.token
        ]
        
        Alamofire.request(urlComposer.url!, method: .get, parameters: parameters).responseJSON { repsonse in
            guard let json = repsonse.value else { return }
            print(json)
        }
    }
    
}
