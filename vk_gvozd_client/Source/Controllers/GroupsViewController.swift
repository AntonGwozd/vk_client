//
//  GroupsViewController.swift
//  vk_gvozd_client
//
//  Created by Anton Gvozdanov on 16/09/2019.
//  Copyright © 2019 Anton Gvozdanov. All rights reserved.
//

import UIKit
import RealmSwift

class GroupsViewController: UITableViewController {

    var vkGroup = [VKGroup]()
    let vkAPI = VkAPI()
    let dataBase = DBClass()
    static var groupCellID = "groupCell"
        
    override func viewDidLoad() {
        super.viewDidLoad()
        //Грузим группы из базы
        reloadDataArray()
        
        //просим группы с сервера
        vkAPI.getUsersGroup( completion: {(response) -> () in
            if response.response.items.count != 0 {     //Если в ответе есть итемы
                //почистим локальную базу перед записью
                self.dataBase.clearAllObjects(objectType: VKGroup())
                
                for group in response.response.items {
                    let vkGroup = VKGroup()
                    vkGroup.id = group.id
                    vkGroup.groupName = group.name
                    let avatarData = try? Data(contentsOf: URL(string: group.photo_50)!)
                    let avatarName = String(group.id) + "_group_avatar"
                    self.dataBase.saveData(fileData: avatarData!, fileName: avatarName)
                    vkGroup.groupAvatar = avatarName
                    self.dataBase.saveObject(object: vkGroup)
                }
                self.reloadDataArray()
            }
        })
        
        //регистрируем ксиб
        tableView.register(UINib(nibName: "GroupCell", bundle: nil), forCellReuseIdentifier: GroupsViewController.groupCellID)
    }

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return vkGroup.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: GroupsViewController.groupCellID, for: indexPath) as! GroupCell
        cell.groupNameLabel.text = vkGroup[indexPath.row].groupName
        cell.groupImageView.image = UIImage(data: dataBase.getData(fileName: vkGroup[indexPath.row].groupAvatar))!
        return cell
    }
    
    // MARK: - Table View delegate
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            vkGroup.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }

    //MARK: Обработка словарей
    func reloadDataArray() {
        vkGroup = dataBase.getAllObjects(object: VKGroup())
        vkGroup.sort{ $0.groupName < $1.groupName }
        tableView.reloadData()
    }
   
}
