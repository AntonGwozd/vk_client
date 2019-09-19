//
//  GroupAddViewController.swift
//  vk_gvozd_client
//
//  Created by Anton Gvozdanov on 16/09/2019.
//  Copyright © 2019 Anton Gvozdanov. All rights reserved.
//

import UIKit

class GroupAddViewController: UITableViewController {
    
    var allGroup = [VKGroup(groupName: "CalculateGroup", groupAvatar: UIImage(named: "group1")!),
                    VKGroup(groupName: "MoneyGroup", groupAvatar: UIImage(named: "group2")!),
                    VKGroup(groupName: "DollarGroup", groupAvatar: UIImage(named: "group3")!),
                    VKGroup(groupName: "PresentGroup", groupAvatar: UIImage(named: "group4")!),
                    VKGroup(groupName: "CloseGroup", groupAvatar: UIImage(named: "group5")!),
                    VKGroup(groupName: "OpenGroup", groupAvatar: UIImage(named: "group6")!)]

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return allGroup.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "groupCell", for: indexPath) as! GroupCell
        cell.groupNameLabel.text = allGroup[indexPath.row].groupName
        cell.groupImageView.image = allGroup[indexPath.row].groupAvatar
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            allGroup.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }
    
}
