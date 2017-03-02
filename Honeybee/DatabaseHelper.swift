//
//  DatabaseHelper.swift
//  Honeybee
//
//  Created by Dongbing Hou on 01/03/2017.
//  Copyright © 2017 Dongbing Hou. All rights reserved.
//

import Foundation

class DatabaseManager: NSObject {
    static let manager = DatabaseManager()
    private var realm: Realm
    private override init() {
        var config = Realm.Configuration()
        config.fileURL = config.fileURL!.deletingLastPathComponent().appendingPathComponent("honeybee.realm")
        self.realm = try! Realm(configuration: config)
        
        print(realm.configuration.fileURL!)
        super.init()
    }
    
    
    func insert(model: Recorder) {
        let recorder = RecorderModel(model: model)
        try! realm.write {
            realm.add(recorder)
        }
    }

}

import RealmSwift

class RecorderModel: Object {
    dynamic var id: String = ""
    dynamic var date: String = ""
    dynamic var superCategory: String = ""
    dynamic var category: String = ""
    dynamic var money: String = ""
    dynamic var remark: String = "未填写\n"
    dynamic var color: String = ""
    dynamic var isPay: Bool = true
    dynamic var imageName: String = "meal"
    
    convenience init(model: Recorder) {
        self.init()
        
        self.id = model.id
        self.category = model.category
        self.superCategory = model.superCategory
        self.color = model.color
        self.date = model.date
        self.imageName = model.date
        self.isPay = model.isPay
        self.money = model.money
        self.remark = model.remark
    }
}
