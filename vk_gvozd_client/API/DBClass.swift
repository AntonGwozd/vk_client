////
////  DBClass.swift
////  vk_gvozd_client
////
////  Created by Anton Gvozdanov on 16.11.2019.
////  Copyright © 2019 Anton Gvozdanov. All rights reserved.
////

import Foundation
import RealmSwift
import KeychainAccess

class DBClass {
    
    let keychain = Keychain()
        
    //Сохранение произвольного объекта в базу
    func saveObject<T: Object>(object: T) {
        let realm = try! Realm()
        try! realm.write {
            realm.add(object, update: .modified)
            //realm.add(object)
        }
    }
    
    //Получим массив объектов
    func getObjects<T: Object>(object: T, filter: String = "") -> Results<T> {
        let realm = try! Realm()
        if filter == "" {
            return realm.objects(T.self)
        } else {
            return realm.objects(T.self).filter(filter)
        }
    }
    
    //очистим таблицу
    func deleteObjects<T: Object>(objectType: T, filter: String = "") {
        let realm = try! Realm()
        try! realm.write {
            if filter == "" {
                realm.delete(realm.objects(T.self))
            } else {
                realm.delete(realm.objects(T.self).filter(filter))
            }
        }
    }
        
    // функция записи в KeyChain
    func setKeyChain(key: String, value: String) {
        do {
            try keychain.set(value, key: key)
        } catch let error {
            print(error)
        }
    }
    
    func getKeyChain(key: String) -> String {
        do {
            return try! (keychain.getString(key) ?? "")
        }
    }
    
    func realmFilePatch() -> URL {
        let realm = try! Realm()
        return(realm.configuration.fileURL!)
    }
    
}
