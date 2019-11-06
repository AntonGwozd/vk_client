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
    let token = Session.shared.token
    let APIVersion = Session.shared.vkAPIVersion
    
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
            URLQueryItem(name: "v", value: APIVersion)
        ]
        
        webView.load(URLRequest(url: urlComposer.url!))
        
        webView.navigationDelegate = viewController
    }
    
    //Возвращает массив друзей типа VKUser
    func getFriensList(completion: @escaping (([VKUser])->())) {
        var friendArray = [VKUser]()
        var urlComposer = URLComponents()
        urlComposer.scheme = "https"
        urlComposer.host = "api.vk.com"
        urlComposer.path = "/method/friends.get"
        
        let parameters = [
            "scope": "262150",
            "v": APIVersion,
            "fields": "nickname,photo_50",
            "access_token": token
        ]

        Alamofire.request(urlComposer.url!, method: .get, parameters: parameters).responseData { response in
            guard let data = response.value else { return }

            do {
                let json = try JSONDecoder().decode(FriendsJsData.self, from: data)
                for user in json.response.items {
                    let url = URL(string: user.photo_50)
                    let data = try? Data(contentsOf: url!)
                    let image = UIImage(data: data!)
                    friendArray.append(VKUser(structUser: user, userAvatar: image!))
                }
                completion(friendArray)
            } catch {
                print(error)
            }
        }
    }
    
    //Возвращает массив фото пользоваетля
    func getUserPhotos(owner_id: String, completion: @escaping (([VKUserFoto])->())){
        var userFotoArray = [VKUserFoto]()
        var urlComposer = URLComponents()
        urlComposer.scheme = "https"
        urlComposer.host = "api.vk.com"
        urlComposer.path = "/method/photos.getAll"
        let parameters = [
            "scope": "262150",
            "owner_id": owner_id,
            "extended": "1",
            "count": "30",
            "v": APIVersion,
            "access_token": token
        ]
        
        Alamofire.request(urlComposer.url!, method: .get, parameters: parameters).responseData { repsonse in
            guard let data = repsonse.value else { return }
            
            do {
                let json = try JSONDecoder().decode(FotosJsData.self, from: data)
                for foto in json.response.items {
                    let url = URL(string: foto.photo_75)
                    let data = try? Data(contentsOf: url!)
                    let image = UIImage(data: data!)
                    userFotoArray.append(VKUserFoto(struckFoto: foto, image: image!))
                }
                completion(userFotoArray)
            } catch {
                print(error)
            }
            
        }
    }
    
    //Возвращает массив групп пользователя
    func getUsersGroup(completion: @escaping (([VKGroup])->())){
        var groupsArray = [VKGroup]()
        var urlComposer = URLComponents()
        urlComposer.scheme = "https"
        urlComposer.host = "api.vk.com"
        urlComposer.path = "/method/groups.get"
        let parameters = [
            "scope": "262150",
            "v": APIVersion,
            "extended": "1",
            "access_token": token
        ]
        
        Alamofire.request(urlComposer.url!, method: .get, parameters: parameters).responseData { repsonse in
            guard let data = repsonse.value else { return }
            
            do {
                let json = try JSONDecoder().decode(GroupsJsData.self, from: data)
                for group in json.response.items {
                    let url = URL(string: group.photo_50)
                    let data = try? Data(contentsOf: url!)
                    let image = UIImage(data: data!)
                    groupsArray.append(VKGroup(struckGroup: group, groupAvatar: image!))
                }
                completion(groupsArray)
            } catch {
                print(error)
            }
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
            "v": APIVersion,
            "access_token": token
        ]
        
        Alamofire.request(urlComposer.url!, method: .get, parameters: parameters).responseJSON { repsonse in
            guard let json = repsonse.value else { return }
            print(json)
        }
    }
    
}
