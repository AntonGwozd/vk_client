//
//  FMClass.swift
//  vk_gvozd_client
//
//  Created by Anton Gvozdanov on 20.11.2019.
//  Copyright © 2019 Anton Gvozdanov. All rights reserved.
//

import Foundation

class FMClass {
    
    let fileManager = FileManager.default
    let documentPatch: URL
    
    init() {
        self.documentPatch = try! fileManager.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: false)
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
