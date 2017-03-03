//
//  DatabaseHelper.swift
//  Honeybee
//
//  Created by Dongbing Hou on 01/03/2017.
//  Copyright © 2017 Dongbing Hou. All rights reserved.
//

import Foundation
import RealmSwift

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
    
    
    func add(model: Recorder, update: Bool? = false) {
        let recorder = RLMRecorder(model: model)
        try! realm.write {
            realm.add(recorder, update: update!)
        }
    }
    func delete(model: Recorder) {
        let recorder = RLMRecorder(model: model)
        try! realm.write {
            realm.delete(recorder)
        }
    }
    func deleteAll() {
        realm.deleteAll()
    }
    func query(id: String) -> RLMRecorder? {
        return realm.object(ofType: RLMRecorder.self, forPrimaryKey: id)
    }
    func query() -> Results<RLMRecorderSuper> {
        return realm.objects(RLMRecorderSuper.self)
        
//        var recorders = [Recorder]()
//        
//        for obj in objects {
//            let recorder = Recorder(
//                date: obj.date,
//                superCategory: obj.superCategory,
//                category: obj.category,
//                money: obj.money,
//                remark: obj.remark,
//                color: obj.color)
//            recorders.append(recorder)
//        }
//        return [RecorderSuper(style: "plain", recorders: recorders)]
    }
}


