//
//  FriendsViewController.swift
//  vk_gvozd_client
//
//  Created by Anton Gvozdanov on 16/09/2019.
//  Copyright © 2019 Anton Gvozdanov. All rights reserved.
//

import UIKit

class FriendsViewController: UITableViewController {
    
    @IBOutlet weak var nameControll: NameControll!
    
    var allFriends = [VKUser(userName: "Berta", userAvatar: UIImage(named: "Berta")!),
                      VKUser(userName: "Bobby", userAvatar: UIImage(named: "Bobby")!),
                      VKUser(userName: "Jodie", userAvatar: UIImage(named: "Jodie")!),
                      VKUser(userName: "Mandy", userAvatar: UIImage(named: "Mandy")!),
                      VKUser(userName: "Nick", userAvatar: UIImage(named: "Nick")!),
                      VKUser(userName: "Walter", userAvatar: UIImage(named: "Walter")!)]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //Дозаполним профили дополнительными фотографиями
        allFriends[1].addFoto(UIImage(named: "group1")!)
        allFriends[3].addFoto(UIImage(named: "group2")!)
        allFriends[3].addFoto(UIImage(named: "group3")!)
        
        allFriends[5].addFoto(UIImage(named: "group4")!)
        allFriends[5].addFoto(UIImage(named: "group5")!)
        allFriends[5].addFoto(UIImage(named: "group6")!)
        
        //отдадим массив для заполнения массива алфавитки
        nameControll.createArray(inArray: allFriends)
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return allFriends.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "friendsCell", for: indexPath) as! FriendCell
        
        cell.friendNameLabel.text = allFriends[indexPath.row].userName
        cell.friendFotoQuantLabel.text = "Фотографий: \(allFriends[indexPath.row].userFoto.count)"
        cell.friendAvatar.image = allFriends[indexPath.row].userAvatar
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            allFriends.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "openFotoScreenSegue" {
            guard let fotoController = segue.destination as? FriendFotoViewController else {return}
            guard let indexPath = tableView.indexPathForSelectedRow else {return}
            fotoController.userFoto.removeAll()
            var numberFoto: Int = 1
            for image in allFriends[indexPath.row].userFoto {
                fotoController.userFoto.append((userImage: image.userFoto, userName: allFriends[indexPath.row].userName, numberFoto: String(numberFoto), likeCount: image.likeCount))
                numberFoto += 1
            }
        }
    }

}
