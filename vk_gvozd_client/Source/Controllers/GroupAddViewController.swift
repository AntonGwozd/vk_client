//
//  GroupAddViewController.swift
//  vk_gvozd_client
//
//  Created by Anton Gvozdanov on 16/09/2019.
//  Copyright © 2019 Anton Gvozdanov. All rights reserved.
//

import UIKit

class GroupAddViewController: UITableViewController {
    
    static var groupCellID = "groupCell"
    var allGroup = [VKGroup(groupName: "CalculateGroup", groupAvatar: UIImage(named: "group1")!),
                    VKGroup(groupName: "MoneyGroup", groupAvatar: UIImage(named: "group2")!),
                    VKGroup(groupName: "DollarGroup", groupAvatar: UIImage(named: "group3")!),
                    VKGroup(groupName: "PresentGroup", groupAvatar: UIImage(named: "group4")!),
                    VKGroup(groupName: "CloseGroup", groupAvatar: UIImage(named: "group5")!),
                    VKGroup(groupName: "OpenGroup", groupAvatar: UIImage(named: "group6")!)]

    override func viewDidLoad() {
        super.viewDidLoad()
        
        //регистрируем ксиб
        tableView.register(UINib(nibName: "GroupCell", bundle: nil), forCellReuseIdentifier: GroupAddViewController.groupCellID)
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return allGroup.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: GroupAddViewController.groupCellID, for: indexPath) as! GroupCell
        cell.groupNameLabel.text = allGroup[indexPath.row].groupName
        cell.groupImageView.image = allGroup[indexPath.row].groupAvatar
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        guard let groupViewController = self.navigationController?.viewControllers.first(where: {$0 is GroupsViewController}) as? GroupsViewController else {return}
        
        let newGroup = allGroup[indexPath.row]
        if !groupViewController.vkGroup.contains(where: { $0.groupName == newGroup.groupName}) {
            groupViewController.vkGroup.append(newGroup)
            groupViewController.tableView.insertRows(at: [IndexPath(row: groupViewController.vkGroup.count - 1, section: 0)], with: .automatic)
        }
        
        self.navigationController?.popViewController(animated: true)      
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            allGroup.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }
    
}
