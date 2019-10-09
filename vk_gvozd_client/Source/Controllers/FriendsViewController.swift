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
    
    @IBOutlet weak var searchBarView: UISearchBar!

    
    var allFriends: [VKUser] = []
    var allFriendsMaster: [VKUser] = []
    var sectionName: [String] = []
    var allFriendsStruct: [UserStruct] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //Заполним массив именами
        createArray()
                
        //регистрируем ксиб
        tableView.register(UINib(nibName: "FriendCell", bundle: nil), forCellReuseIdentifier: FriendsViewController.friendCellID)
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

    
    //Количество строк в секции по размеру массива
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return allFriendsStruct[section].users.count
    }
    
    //Заполнение ячейки по данным масива
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: FriendsViewController.friendCellID, for: indexPath) as! FriendCell
        
        cell.friendNameLabel.text = allFriendsStruct[indexPath.section].users[indexPath.row].userName
        cell.friendFotoQuantLabel.text = "Фотографий: \(allFriendsStruct[indexPath.section].users[indexPath.row].userFoto.count)"
        cell.friendAvatar.image = allFriendsStruct[indexPath.section].users[indexPath.row].userAvatar
        
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
            fotoController.userFoto.removeAll()
            var numberFoto: Int = 1
            for image in allFriendsStruct[indexPath.section].users[indexPath.row].userFoto {
                fotoController.userFoto.append((userImage: image.userFoto, userName: allFriendsStruct[indexPath.section].users[indexPath.row].userName, numberFoto: String(numberFoto), likeCount: image.likeCount))
                numberFoto += 1
            }	
        }
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
    
    //Массив сделал большой для наглядности
    // поэтому процедуру внизу, что бы код не листать
    func createArray(){
        allFriendsMaster = []
        allFriendsMaster = [VKUser(userName: "Berta", userAvatar: UIImage(named: "Berta")!),
                          VKUser(userName: "Bobby", userAvatar: UIImage(named: "Bobby")!),
                          VKUser(userName: "Jodie", userAvatar: UIImage(named: "Jodie")!),
                          VKUser(userName: "Mandy", userAvatar: UIImage(named: "Mandy")!),
                          VKUser(userName: "Nick", userAvatar: UIImage(named: "Nick")!),
                          VKUser(userName: "Walter", userAvatar: UIImage(named: "Walter")!),
                          VKUser(userName: "Aleksandr", userAvatar: UIImage(named: "BlueMonster")!),
                          VKUser(userName: "Aleksey", userAvatar: UIImage(named: "BlueMonster")!),
                          VKUser(userName: "Anatoly", userAvatar: UIImage(named: "BlueMonster")!),
                          VKUser(userName: "Andrey", userAvatar: UIImage(named: "BlueMonster")!),
                          VKUser(userName: "Anton", userAvatar: UIImage(named: "BlueMonster")!),
                          VKUser(userName: "Arkady", userAvatar: UIImage(named: "BlueMonster")!),
                          VKUser(userName: "Artem", userAvatar: UIImage(named: "BlueMonster")!),
                          VKUser(userName: "Artur", userAvatar: UIImage(named: "BlueMonster")!),
                          VKUser(userName: "Boris", userAvatar: UIImage(named: "BlueMonster")!),
                          VKUser(userName: "Vadim", userAvatar: UIImage(named: "BlueMonster")!),
                          VKUser(userName: "Valentin", userAvatar: UIImage(named: "BlueMonster")!),
                          VKUser(userName: "Valeriy", userAvatar: UIImage(named: "BlueMonster")!),
                          VKUser(userName: "Vasily", userAvatar: UIImage(named: "BlueMonster")!),
                          VKUser(userName: "Viktor", userAvatar: UIImage(named: "BlueMonster")!),
                          VKUser(userName: "Vitaly", userAvatar: UIImage(named: "BlueMonster")!),
                          VKUser(userName: "Vladimir", userAvatar: UIImage(named: "BlueMonster")!),
                          VKUser(userName: "Vladislav", userAvatar: UIImage(named: "BlueMonster")!),
                          VKUser(userName: "Vyacheslav", userAvatar: UIImage(named: "BlueMonster")!),
                          VKUser(userName: "Gennady", userAvatar: UIImage(named: "BlueMonster")!),
                          VKUser(userName: "Georgy", userAvatar: UIImage(named: "BlueMonster")!),
                          VKUser(userName: "Gleb", userAvatar: UIImage(named: "BlueMonster")!),
                          VKUser(userName: "Grigory", userAvatar: UIImage(named: "BlueMonster")!),
                          VKUser(userName: "Daniil", userAvatar: UIImage(named: "BlueMonster")!),
                          VKUser(userName: "Denis", userAvatar: UIImage(named: "BlueMonster")!),
                          VKUser(userName: "Dmitry", userAvatar: UIImage(named: "BlueMonster")!),
                          VKUser(userName: "Yevgeny", userAvatar: UIImage(named: "BlueMonster")!),
                          VKUser(userName: "Yegor", userAvatar: UIImage(named: "BlueMonster")!),
                          VKUser(userName: "Zakhar", userAvatar: UIImage(named: "BlueMonster")!),
                          VKUser(userName: "Ivan", userAvatar: UIImage(named: "BlueMonster")!),
                          VKUser(userName: "Igor", userAvatar: UIImage(named: "BlueMonster")!),
                          VKUser(userName: "Ilya", userAvatar: UIImage(named: "BlueMonster")!),
                          VKUser(userName: "Innokenty", userAvatar: UIImage(named: "BlueMonster")!),
                          VKUser(userName: "Iosif", userAvatar: UIImage(named: "BlueMonster")!),
                          VKUser(userName: "Kirill", userAvatar: UIImage(named: "BlueMonster")!),
                          VKUser(userName: "Konstantin", userAvatar: UIImage(named: "BlueMonster")!),
                          VKUser(userName: "Lev", userAvatar: UIImage(named: "BlueMonster")!),
                          VKUser(userName: "Leonid", userAvatar: UIImage(named: "BlueMonster")!),
                          VKUser(userName: "Maksim", userAvatar: UIImage(named: "BlueMonster")!),
                          VKUser(userName: "Matvey", userAvatar: UIImage(named: "BlueMonster")!),
                          VKUser(userName: "Mikhail", userAvatar: UIImage(named: "BlueMonster")!),
                          VKUser(userName: "Moisey", userAvatar: UIImage(named: "BlueMonster")!),
                          VKUser(userName: "Nikita", userAvatar: UIImage(named: "BlueMonster")!),
                          VKUser(userName: "Nikolay", userAvatar: UIImage(named: "BlueMonster")!),
                          VKUser(userName: "Oleg", userAvatar: UIImage(named: "BlueMonster")!),
                          VKUser(userName: "Pavel", userAvatar: UIImage(named: "BlueMonster")!),
                          VKUser(userName: "Pyotr", userAvatar: UIImage(named: "BlueMonster")!),
                          VKUser(userName: "Roman", userAvatar: UIImage(named: "BlueMonster")!),
                          VKUser(userName: "Ruslan", userAvatar: UIImage(named: "BlueMonster")!),
                          VKUser(userName: "Svyatoslav", userAvatar: UIImage(named: "BlueMonster")!),
                          VKUser(userName: "Semyon", userAvatar: UIImage(named: "BlueMonster")!),
                          VKUser(userName: "Sergey", userAvatar: UIImage(named: "BlueMonster")!),
                          VKUser(userName: "Stanislav", userAvatar: UIImage(named: "BlueMonster")!),
                          VKUser(userName: "Stepan", userAvatar: UIImage(named: "BlueMonster")!),
                          VKUser(userName: "Timofey", userAvatar: UIImage(named: "BlueMonster")!),
                          VKUser(userName: "Timur", userAvatar: UIImage(named: "BlueMonster")!),
                          VKUser(userName: "Fedor", userAvatar: UIImage(named: "BlueMonster")!),
                          VKUser(userName: "Filipp", userAvatar: UIImage(named: "BlueMonster")!),
                          VKUser(userName: "Eduard", userAvatar: UIImage(named: "BlueMonster")!),
                          VKUser(userName: "Yuri", userAvatar: UIImage(named: "BlueMonster")!),
                          VKUser(userName: "Yakov", userAvatar: UIImage(named: "BlueMonster")!),
                          VKUser(userName: "Yan", userAvatar: UIImage(named: "BlueMonster")!),
                          VKUser(userName: "Yaroslav", userAvatar: UIImage(named: "BlueMonster")!),
                          VKUser(userName: "Aleksandra", userAvatar: UIImage(named: "PurpleMonster")!),
                          VKUser(userName: "Alisa", userAvatar: UIImage(named: "PurpleMonster")!),
                          VKUser(userName: "Alina", userAvatar: UIImage(named: "PurpleMonster")!),
                          VKUser(userName: "Alla", userAvatar: UIImage(named: "PurpleMonster")!),
                          VKUser(userName: "Albina", userAvatar: UIImage(named: "PurpleMonster")!),
                          VKUser(userName: "Anastasia", userAvatar: UIImage(named: "PurpleMonster")!),
                          VKUser(userName: "Angelina", userAvatar: UIImage(named: "PurpleMonster")!),
                          VKUser(userName: "Anzhela", userAvatar: UIImage(named: "PurpleMonster")!),
                          VKUser(userName: "Anna", userAvatar: UIImage(named: "PurpleMonster")!),
                          VKUser(userName: "Antonina", userAvatar: UIImage(named: "PurpleMonster")!),
                          VKUser(userName: "Valentina", userAvatar: UIImage(named: "PurpleMonster")!),
                          VKUser(userName: "Valeria", userAvatar: UIImage(named: "PurpleMonster")!),
                          VKUser(userName: "Varvara", userAvatar: UIImage(named: "PurpleMonster")!),
                          VKUser(userName: "Vera", userAvatar: UIImage(named: "PurpleMonster")!),
                          VKUser(userName: "Veronika", userAvatar: UIImage(named: "PurpleMonster")!),
                          VKUser(userName: "Viktoria", userAvatar: UIImage(named: "PurpleMonster")!),
                          VKUser(userName: "Galina", userAvatar: UIImage(named: "PurpleMonster")!),
                          VKUser(userName: "Darina", userAvatar: UIImage(named: "PurpleMonster")!),
                          VKUser(userName: "Darya", userAvatar: UIImage(named: "PurpleMonster")!),
                          VKUser(userName: "Diana", userAvatar: UIImage(named: "PurpleMonster")!),
                          VKUser(userName: "Dina", userAvatar: UIImage(named: "PurpleMonster")!),
                          VKUser(userName: "Yevgenia", userAvatar: UIImage(named: "PurpleMonster")!),
                          VKUser(userName: "Yekaterina", userAvatar: UIImage(named: "PurpleMonster")!),
                          VKUser(userName: "Yelena", userAvatar: UIImage(named: "PurpleMonster")!),
                          VKUser(userName: "Yelizaveta", userAvatar: UIImage(named: "PurpleMonster")!),
                          VKUser(userName: "Zhanna", userAvatar: UIImage(named: "PurpleMonster")!),
                          VKUser(userName: "Zinaida", userAvatar: UIImage(named: "PurpleMonster")!),
                          VKUser(userName: "Zoya", userAvatar: UIImage(named: "PurpleMonster")!),
                          VKUser(userName: "Inna", userAvatar: UIImage(named: "PurpleMonster")!),
                          VKUser(userName: "Irina", userAvatar: UIImage(named: "PurpleMonster")!),
                          VKUser(userName: "Kamilla", userAvatar: UIImage(named: "PurpleMonster")!),
                          VKUser(userName: "Karina", userAvatar: UIImage(named: "PurpleMonster")!),
                          VKUser(userName: "Kira", userAvatar: UIImage(named: "PurpleMonster")!),
                          VKUser(userName: "Klara", userAvatar: UIImage(named: "PurpleMonster")!),
                          VKUser(userName: "Kristina", userAvatar: UIImage(named: "PurpleMonster")!),
                          VKUser(userName: "Ksenia", userAvatar: UIImage(named: "PurpleMonster")!),
                          VKUser(userName: "Larisa", userAvatar: UIImage(named: "PurpleMonster")!),
                          VKUser(userName: "Lidia", userAvatar: UIImage(named: "PurpleMonster")!),
                          VKUser(userName: "Lilia", userAvatar: UIImage(named: "PurpleMonster")!),
                          VKUser(userName: "Lia", userAvatar: UIImage(named: "PurpleMonster")!),
                          VKUser(userName: "Lyubov", userAvatar: UIImage(named: "PurpleMonster")!),
                          VKUser(userName: "Lyudmila", userAvatar: UIImage(named: "PurpleMonster")!),
                          VKUser(userName: "Maya", userAvatar: UIImage(named: "PurpleMonster")!),
                          VKUser(userName: "Margarita", userAvatar: UIImage(named: "PurpleMonster")!),
                          VKUser(userName: "Marina", userAvatar: UIImage(named: "PurpleMonster")!),
                          VKUser(userName: "Maria", userAvatar: UIImage(named: "PurpleMonster")!),
                          VKUser(userName: "Nadezhda", userAvatar: UIImage(named: "PurpleMonster")!),
                          VKUser(userName: "Natalya", userAvatar: UIImage(named: "PurpleMonster")!),
                          VKUser(userName: "Nina", userAvatar: UIImage(named: "PurpleMonster")!),
                          VKUser(userName: "Oksana", userAvatar: UIImage(named: "PurpleMonster")!),
                          VKUser(userName: "Olesya", userAvatar: UIImage(named: "PurpleMonster")!),
                          VKUser(userName: "Olga", userAvatar: UIImage(named: "PurpleMonster")!),
                          VKUser(userName: "Polina", userAvatar: UIImage(named: "PurpleMonster")!),
                          VKUser(userName: "Raisa", userAvatar: UIImage(named: "PurpleMonster")!),
                          VKUser(userName: "Regina", userAvatar: UIImage(named: "PurpleMonster")!),
                          VKUser(userName: "Rosa", userAvatar: UIImage(named: "PurpleMonster")!),
                          VKUser(userName: "Svetlana", userAvatar: UIImage(named: "PurpleMonster")!),
                          VKUser(userName: "Snezhana", userAvatar: UIImage(named: "PurpleMonster")!),
                          VKUser(userName: "Sofya", userAvatar: UIImage(named: "PurpleMonster")!),
                          VKUser(userName: "Tamara", userAvatar: UIImage(named: "PurpleMonster")!),
                          VKUser(userName: "Tatyana", userAvatar: UIImage(named: "PurpleMonster")!),
                          VKUser(userName: "Ulyana", userAvatar: UIImage(named: "PurpleMonster")!),
                          VKUser(userName: "Elina", userAvatar: UIImage(named: "PurpleMonster")!),
                          VKUser(userName: "Yulia", userAvatar: UIImage(named: "PurpleMonster")!),
                          VKUser(userName: "Yana", userAvatar: UIImage(named: "PurpleMonster")!)]
        
        //Дозаполним профили дополнительными фотографиями
        allFriendsMaster[1].addFoto(UIImage(named: "group1")!)
        allFriendsMaster[3].addFoto(UIImage(named: "group2")!)
        allFriendsMaster[3].addFoto(UIImage(named: "group3")!)
        
        allFriendsMaster[5].addFoto(UIImage(named: "group4")!)
        allFriendsMaster[5].addFoto(UIImage(named: "group5")!)
        allFriendsMaster[5].addFoto(UIImage(named: "group6")!)
        
        allFriendsMaster.sort{ $0.userName < $1.userName }
        allFriends = allFriendsMaster
        createSectionArray()
        createDict()
    }
}

extension FriendsViewController: UISearchBarDelegate {
    public func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchText == "" {
            allFriends = allFriendsMaster
        } else {
            allFriends = allFriendsMaster.filter { $0.userName.range(of: searchText) != nil}
        }
        createSectionArray()
        createDict()
        tableView.reloadData()
    }
}

