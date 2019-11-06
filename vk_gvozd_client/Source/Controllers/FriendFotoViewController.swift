//
//  FriendFotoViewController.swift
//  vk_gvozd_client
//
//  Created by Anton Gvozdanov on 16/09/2019.
//  Copyright © 2019 Anton Gvozdanov. All rights reserved.
//

import UIKit



class FriendFotoViewController: UICollectionViewController {
    
    var userFoto: [VKUserFoto] = []
    var owner_id = ""
    let vkAPI = VkAPI()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        vkAPI.getUserPhotos(owner_id: owner_id, completion: {(userFotoArray) -> () in
            self.userFoto = userFotoArray
            self.collectionView.reloadData()
        } )
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return userFoto.count
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "friendsFotoCell", for: indexPath) as! FriendFotoCell
    
        //cell.friendNameLabel.text = userFoto[indexPath.row].userName
        //cell.friendNumberFotoLabel.text = userFoto[indexPath.row].numberFoto
        cell.friendFotoImage.image = userFoto[indexPath.row].image
        if userFoto[indexPath.row].myLike == 0 {
            cell.friendLikeValue.likeValue = false
        } else {
            cell.friendLikeValue.likeValue = true
        }
        cell.friendLikeValue.likeCount.text = String(userFoto[indexPath.row].likes)
        
        return cell
    }

}

