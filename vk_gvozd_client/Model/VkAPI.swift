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
    
    //Возвращаем дефолтную строку с добавлением метода
    private func defaultVKUrlMethod (method: String) -> URL {
        var urlComposer = URLComponents()
        urlComposer.scheme = "https"
        urlComposer.host = "api.vk.com"
        urlComposer.path = "/method/"+method
        
        return urlComposer.url!
    }
    
    //Функция авторизации в VK
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
    
    //Функция типового обращения к серверу. возвращает response целиком
    func vkMethod<T: Decodable>(url: URL, params: [String: Any], complitionHandler: @escaping (T) -> () ) {
        Alamofire.request(url, method: .get, parameters: params).responseData { response in
            guard let data = response.value else { return }
            do {
                let result = try JSONDecoder().decode(T.self, from: data)
                complitionHandler(result)
            } catch {
                print("JSON decode error: \(error)")
            }
        }
    }
    
    //запрос списка друзей
    func getFriensList(completion: @escaping ((FriendsJsData)->())) {
        let url = defaultVKUrlMethod(method: "friends.get")
        let parameters = [
            "scope": "262150",
            "v": APIVersion,
            "fields": "nickname,photo_50",
            "access_token": token
        ]
        vkMethod(url: url, params: parameters, complitionHandler: completion)
    }
    
    //запрос групп пользователя
    func getUsersGroup(completion: @escaping ((GroupsJsData)->())){
        let url = defaultVKUrlMethod(method: "groups.get")
        let parameters = [
            "scope": "262150",
            "v": APIVersion,
            "extended": "1",
            "access_token": token
        ]
        vkMethod(url: url, params: parameters, complitionHandler: completion)
    }
    
    //запрос фотографий
    func getUserPhotos(owner_id: String, completion: @escaping ((FotosJsData)->())){
        let url = defaultVKUrlMethod(method: "photos.getAll")
        let parameters = [
            "scope": "262150",
            "owner_id": owner_id,
            "extended": "1",
            "count": "30",
            "v": APIVersion,
            "access_token": token
        ]
        vkMethod(url: url, params: parameters, complitionHandler: completion)
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
