//
//  FriendFotoViewController.swift
//  vk_gvozd_client
//
//  Created by Anton Gvozdanov on 16/09/2019.
//  Copyright © 2019 Anton Gvozdanov. All rights reserved.
//

import UIKit
import RealmSwift

class FriendFotoViewController: UICollectionViewController {
    
    var userFoto: [VKUserFoto] = []
    var owner_id = ""
    let vkAPI = VkAPI()
    let realm = try! Realm()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //Грузим группы из базы
        reloadDataArray()
        
        vkAPI.getUserPhotos(owner_id: owner_id, completion: {(response) -> () in
            try! self.realm.write {
                self.realm.delete(self.realm.objects(VKUserFoto.self))
            }
            for photo in response.response.items {
                let vkFoto = VKUserFoto()
                vkFoto.id = photo.id
                vkFoto.image = try? Data(contentsOf: URL(string: photo.photo_75)!)
                vkFoto.likes = photo.likes.count
                vkFoto.myLike = photo.likes.user_likes != 0
                try! self.realm.write {
                    self.realm.add(vkFoto)
                }
            }
            self.reloadDataArray()
        } )
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return userFoto.count
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "friendsFotoCell", for: indexPath) as! FriendFotoCell
    
        //cell.friendNameLabel.text = userFoto[indexPath.row].userName
        //cell.friendNumberFotoLabel.text = userFoto[indexPath.row].numberFoto
        cell.friendFotoImage.image = UIImage(data: userFoto[indexPath.row].image!)!
        if userFoto[indexPath.row].myLike {
            cell.friendLikeValue.likeValue = false
        } else {
            cell.friendLikeValue.likeValue = true
        }
        cell.friendLikeValue.likeCount.text = String(userFoto[indexPath.row].likes)
        
        return cell
    }
    
    //MARK: Обработка словарей
    func reloadDataArray() {
        userFoto = Array(realm.objects(VKUserFoto.self))
        collectionView.reloadData()
    }

}

