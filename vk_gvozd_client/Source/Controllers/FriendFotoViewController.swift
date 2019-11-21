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
    let dataBase = DBClass()
    let fm = FMClass()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //Грузим группы из базы
        reloadDataArray()
        
        vkAPI.getUserPhotos(owner_id: owner_id, completion: {(response) -> () in
            
            if response.response.items.count != 0 {
                self.dataBase.deleteObjects(objectType: VKUserFoto())
                for photo in response.response.items {
                    let vkFoto = VKUserFoto()
                    vkFoto.id = photo.id
                    vkFoto.owner_id = photo.owner_id
                    let photoData = try! Data(contentsOf: URL(string: photo.photo_75)!)
                    let photoName = self.owner_id + "-" + String(photo.id)
                    self.fm.saveData(fileData: photoData, fileName: photoName)
                    vkFoto.image = photoName
                    vkFoto.likes = photo.likes.count
                    vkFoto.myLike = photo.likes.user_likes != 0
                    self.dataBase.saveObject(object: vkFoto)
                }
                self.reloadDataArray()
            }
        } )
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return userFoto.count
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "friendsFotoCell", for: indexPath) as! FriendFotoCell
    
        //cell.friendNameLabel.text = userFoto[indexPath.row].userName
        //cell.friendNumberFotoLabel.text = userFoto[indexPath.row].numberFoto
        cell.friendFotoImage.image = UIImage(data: fm.getData(fileName: userFoto[indexPath.row].image))!
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
        userFoto = Array(dataBase.getObjects(object: VKUserFoto(), filter: "owner_id = \(owner_id)"))
        collectionView.reloadData()
    }

}

