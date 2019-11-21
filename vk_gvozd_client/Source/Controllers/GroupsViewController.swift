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

    var vkGroup: Results<VKGroup>?
    let vkAPI = VkAPI()
    let dataBase = DBClass()
    let fm = FMClass()
    static var groupCellID = "groupCell"
    var token: NotificationToken?

        
    override func viewDidLoad() {
        super.viewDidLoad()
        //работа с базой
        reloadDataArray()
        // запрос обновления с сервера
        vkAPI.getUsersGroup()
        
        //регистрируем ксиб
        tableView.register(UINib(nibName: "GroupCell", bundle: nil), forCellReuseIdentifier: GroupsViewController.groupCellID)
    }

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return vkGroup?.count ?? 0
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: GroupsViewController.groupCellID, for: indexPath) as! GroupCell
        cell.groupNameLabel.text = vkGroup?[indexPath.row].groupName
        cell.groupImageView.image = UIImage(data: fm.getData(fileName: (vkGroup?[indexPath.row].groupAvatar)!))!
        return cell
    }
    
    // MARK: - Table View delegate
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        let group = (vkGroup?[indexPath.row])!
        if editingStyle == .delete {
            dataBase.deleteObjects(objectType: VKGroup(), filter: "id = \(group.id)")
        }
    }

    //MARK: Обработка словарей
    func reloadDataArray() {
        vkGroup = dataBase.getObjects(object: VKGroup())
        token = vkGroup?.observe { [weak self] (changes: RealmCollectionChange) in
            guard let tableView = self?.tableView else { return }
            
            switch changes {
            case .initial:      //Первичная инициализация, полная загрузка даных
                tableView.reloadData()
            case .update(_, let deletions, let insertions, let modifications):      //Обновление данных
                tableView.beginUpdates()
                tableView.insertRows(at: insertions.map({ IndexPath(row: $0, section: 0) }),
                                     with: .automatic)
                tableView.deleteRows(at: deletions.map({ IndexPath(row: $0, section: 0)}),
                                     with: .automatic)
                tableView.reloadRows(at: modifications.map({ IndexPath(row: $0, section: 0) }),
                                     with: .automatic)
                tableView.endUpdates()
            case .error(let error):
                fatalError("\(error)")
            }
        }
    }
   
}
