////
////  DBClass.swift
////  vk_gvozd_client
////
////  Created by Anton Gvozdanov on 16.11.2019.
////  Copyright © 2019 Anton Gvozdanov. All rights reserved.
////

import Foundation
import RealmSwift

class DBClass {
    
    let realm = try! Realm()
    let fileManager = FileManager.default
    let documentPatch: URL
    
    init() {
        self.documentPatch = try! fileManager.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: false)
    }
    
    //Функция возврата сохраненных настроек
    func getUserSetting() -> UserSettings {
        if self.existsUserSetting(){
            return realm.objects(UserSettings.self).first!
        } else {
            let userSetting = UserSettings()
            //userSetting.pk = 0
            userSetting.id = 0
            userSetting.token = ""
            return userSetting
        }
    }
    
//    //Функция проверки наличия сохраненных настроек
    func existsUserSetting() -> Bool {
        if let userSettings = realm.objects(UserSettings.self).first,
            userSettings.token != "" {
            return true
        } else {
            return false
        }
    }
    
    //Сохранение произвольного объекта в базу
    func saveObject<T: Object>(object: T) {
        try! realm.write {
            realm.add(object)
        }
    }
    
    //Получим массив объектов
    func getAllObjects<T: Object>(object: T, filter: String = "") -> [T] {
        if filter == "" {
            return Array(realm.objects(T.self))
        } else {
            return Array(realm.objects(T.self).filter(filter))
        }
    }
    
    //очистим таблицу
    func clearAllObjects<T: Object>(objectType: T, filter: String = "") {
        try! realm.write {
            if filter == "" {
                realm.delete(realm.objects(T.self))
            } else {
                realm.delete(realm.objects(T.self).filter(filter))
            }
        }
    }
    
    //Функция сохранения картинки
    func saveData(fileData: Data, fileName: String) {
        let fullName = self.documentPatch.appendingPathComponent(fileName)
        try! fileData.write(to: fullName)
    }
    
    //Функция чтения картинки
    func getData(fileName: String) -> Data {
        let fullName = self.documentPatch.appendingPathComponent(fileName)
        let fileData = try! Data(contentsOf: fullName)
        return fileData
    }
    
}
