//
//  AppDelegate.swift
//  vk_gvozd_client
//
//  Created by Anton Gvozdanov on 10/09/2019.
//  Copyright © 2019 Anton Gvozdanov. All rights reserved.
//

import UIKit
import RealmSwift

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        let dataBase = DBClass()
        //print(dataBase.realmFilePatch())
        
        //конфигурация сессии. нужна в realm для подписки на действительный токен.
        
        if dataBase.getObjects(object: SessionClass()).count == 0 {
            let session = SessionClass()
            dataBase.saveObject(object: session)
        } else {
            print (dataBase.getObjects(object: SessionClass()).first)
        }
        
        //Конфигурация Realm
        //let realmConfig = Realm.Configuration(schemaVersion: 0)
        
        //Конфигурация Realm для тестов
        let realmConfig = Realm.Configuration(deleteRealmIfMigrationNeeded: true)
        
        //Применние конфигурации Realm
        Realm.Configuration.defaultConfiguration = realmConfig
        
        let storyBoard = UIStoryboard(name: "Main", bundle: nil)

        //Проверка наличия токена в keychain
        if dataBase.getKeyChain(key: "tokenVK") != "" && dataBase.getObjects(object: SessionClass()).first!.tokenIsCorrect == true {
            let contenScreen = storyBoard.instantiateViewController(withIdentifier: "ContentController")
            window?.rootViewController = contenScreen
            window?.makeKeyAndVisible()
        }
        return true
    }

    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }


}

