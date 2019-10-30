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
    static var groupCellID = "groupCell"
    
//    @IBAction func unwindListGroups(unwindSegue: UIStoryboardSegue) {
//        if unwindSegue.identifier == "addGroupSegue" {
//            guard let allGroupController = unwindSegue.source as? GroupAddViewController else {return}
//            guard let indexPath = allGroupController.tableView.indexPathForSelectedRow else {return}
//            
//            let newGroup = allGroupController.allGroup[indexPath.row]
//            if !vkGroup.contains(where: { $0.groupName == newGroup.groupName}) {
//                vkGroup.append(newGroup)
//                tableView.insertRows(at: [IndexPath(row: vkGroup.count - 1, section: 0)], with: .fade)
//            }
//        }
//    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
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
