//
//  GroupsViewController.swift
//  vk_gvozd_client
//
//  Created by Anton Gvozdanov on 16/09/2019.
//  Copyright © 2019 Anton Gvozdanov. All rights reserved.
//

import UIKit

class GroupsViewController: UITableViewController {

    var vkGroup = [VKGroup]()
    let vkAPI = VkAPI()
    static var groupCellID = "groupCell"
        
    override func viewDidLoad() {
        super.viewDidLoad()
        
        vkAPI.getUsersGroup( completion: {(gropsArray) -> () in
            self.vkGroup = gropsArray
            self.vkGroup.sort{ $0.groupName < $1.groupName }
            self.tableView.reloadData()
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
        cell.groupImageView.image = vkGroup[indexPath.row].groupAvatar
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

   
}
