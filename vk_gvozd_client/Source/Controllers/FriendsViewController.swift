//
//  FriendsViewController.swift
//  vk_gvozd_client
//
//  Created by Anton Gvozdanov on 16/09/2019.
//  Copyright © 2019 Anton Gvozdanov. All rights reserved.
//

import UIKit

struct UserStruct {
    var letter: String
    var users: [VKUser]
}

class FriendsViewController: UITableViewController {

    static var friendCellID = "friendsCell"
    
    @IBOutlet weak var searchTextFiled: UITextField!
    
    @IBAction func cancelButtonAction(sender: UIButton) {
        searchTextFiled.text = ""
        searchTextFunc(searchTextFiled)
    }
    
    var allFriends: [VKUser] = []
    var allFriendsMaster: [VKUser] = []
    var sectionName: [String] = []
    var allFriendsStruct: [UserStruct] = []
    let vkAPI = VkAPI()
    let dataBase = DBClass()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //Загрузим данные из кэша
        reloadDataArray()
        
        //Запросим и заполним базу актуальными данными
        vkAPI.getFriensList( completion: {(response) -> () in
            
            // если ответ с друзьями то чистим базу пользователй
            if response.response.items.count != 0 {
                self.dataBase.clearAllObjects(objectType: VKUser())
                
                //Строим новый массив и пишем в базу
                for user in response.response.items {
                    let vkUser = VKUser()
                    vkUser.userName = user.last_name + " " + user.first_name
                    vkUser.id = user.id
                    vkUser.online = String(user.online)
                    let avatarData = try? Data(contentsOf: URL(string: user.photo_50)!)
                    let avatarName = String(user.id) + "_avatar"
                    self.dataBase.saveData(fileData: avatarData!, fileName: avatarName)
                    vkUser.userAvatar = avatarName
                    self.dataBase.saveObject(object: vkUser)
                }
            }
            
            //Обновим форму
            self.reloadDataArray()
        } )

        //регистрируем ксиб ячейки
        tableView.register(UINib(nibName: "FriendCell", bundle: nil), forCellReuseIdentifier: FriendsViewController.friendCellID)
        
        //
        searchTextFiled.addTarget(self, action: #selector(searchTextFunc(_ :)), for: .editingChanged)
    }
    
    @objc func searchTextFunc(_ textfield:UITextField) {
        let searchText = searchTextFiled.text ?? ""
        if searchText == "" {
            allFriends = allFriendsMaster
        } else {
            allFriends = allFriendsMaster.filter { $0.userName.range(of: searchText) != nil}
        }
        createSectionArray()
        createDict()
        tableView.reloadData()
    }
    
    //Имена секций
    override func sectionIndexTitles(for tableView: UITableView) -> [String]? {
        return sectionName
    }
    
    //Количество Секций
    override func numberOfSections(in tableView: UITableView) -> Int {
        return sectionName.count
    }
    
    // индексы имен секций
    override func tableView(_ tableView: UITableView, sectionForSectionIndexTitle title: String, at index: Int) -> Int {
        return index
    }
    
    //имена секций
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return sectionName[section]
    }
    
    // цвет секции
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        let headerView = UIView()
        headerView.backgroundColor = UIColor.blue
        headerView.alpha = 0.2
        
        let headerLabel = UILabel(frame: CGRect(x: 30, y: 0, width:
            tableView.bounds.size.width, height: tableView.bounds.size.height))
        //headerLabel.font = UIFont(name: "Verdana", size: 20)
        headerLabel.textColor = UIColor.white
        headerLabel.text = sectionName[section]
        headerLabel.sizeToFit()
        headerView.addSubview(headerLabel)
        
        return headerView
    }
    
    // ячейка будет показана
    override func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        let aniCell = cell as! FriendCell
        aniCell.animationWillDisplay()
    }
    
    //Количество строк в секции по размеру массива
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return allFriendsStruct[section].users.count
    }
    
    //Заполнение ячейки по данным масива
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: FriendsViewController.friendCellID, for: indexPath) as! FriendCell
        
        cell.friendNameLabel.text = allFriendsStruct[indexPath.section].users[indexPath.row].userName
        cell.friendFotoQuantLabel.text = "Фотографий: "
        cell.friendAvatar.image = UIImage(data: self.dataBase.getData(fileName: allFriendsStruct[indexPath.section].users[indexPath.row].userAvatar))!
        
        return cell
    }
    
    //Селект десселкт строки
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "openFotoScreenSegue", sender: nil)
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    //Свайп строки обработка удаления
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            allFriendsStruct[indexPath.section].users.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }
    
    //Обработка сеги переключения на фотографии
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "openFotoScreenSegue" {
            guard let fotoController = segue.destination as? FriendFotoViewController else {return}
            guard let indexPath = tableView.indexPathForSelectedRow else {return}
            fotoController.owner_id = String(allFriendsStruct[indexPath.section].users[indexPath.row].id)
        }
    }
    
    //MARK: Обработка словарей
    func reloadDataArray() {
        allFriendsMaster = dataBase.getAllObjects(object: VKUser())
        allFriendsMaster.sort{ $0.userName < $1.userName }
        allFriends = self.allFriendsMaster
        createSectionArray()
        createDict()
        tableView.reloadData()
    }
    
    //Протащим первую букву имени через множество и вернем ее массивом букв для имен секций
    func createSectionArray(){
        sectionName = []
        var tempSet = Set<Character>()
        for user in allFriends {
            tempSet.insert(user.userName[user.userName.startIndex])
        }
        for tempLet in tempSet {
            sectionName.append(String(tempLet))
        }
        sectionName.sort{ $0 < $1 }
    }
    
    //Получим массив стуктур
    func createDict() {
        allFriendsStruct = []
        for letter in sectionName {
            var tempUser: [VKUser] = []
            for user in allFriends {
                if String(user.userName[user.userName.startIndex]) == letter {
                    tempUser.append(user)
                }
            }
            allFriendsStruct.append(UserStruct(letter: letter, users: tempUser))
        }
    }
}

