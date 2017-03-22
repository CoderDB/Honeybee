//
//  DatabaseHelper.swift
//  Honeybee
//
//  Created by Dongbing Hou on 01/03/2017.
//  Copyright © 2017 Dongbing Hou. All rights reserved.
//

import Foundation
import RealmSwift

protocol DatabaseManagerProtocol {
    
}


class DatabaseManager: NSObject {
    
    private var realm: Realm
    static let manager = DatabaseManager()
    private override init() {
        var config = Realm.Configuration()
        config.fileURL = config.fileURL!.deletingLastPathComponent().appendingPathComponent("honeybee.realm")
        self.realm = try! Realm(configuration: config)
        
        print(realm.configuration.fileURL!)
        super.init()
    }
    
    func add<T: RLMModel>(model: T, update: Bool? = false) {
        try! realm.write {
            realm.add(model, update: update!)
        }
    }
    func delete<T: RLMModel>(model: T) {
        try! realm.write {
            realm.delete(model)
        }
    }
    func update() {
        // 1. 直接更新 model.name = "new name"
        // 2. 通过primaryKey更新
        // 3. KVO
    }
    func deleteAll() {
        realm.deleteAll()
    }
    func query(id: String) -> RLMRecorder? {
        return realm.object(ofType: RLMRecorder.self, forPrimaryKey: id)
    }
//    func allData() -> Results<RLMRecorderSuper> {
//        return realm.objects(RLMRecorderSuper.self)
//    }
    
    func all<T: RLMModel>(_: T.Type) -> Results<T> {
        return realm.objects(T.self)
    }
    
    
//    func allPayout() -> [RLMRecorderSuper] {
//        var results: [RLMRecorderSuper] = []
////        let all = allData()
//        
////        for data in all {
////            for model in data.recorders {
////                if !model.isPay {
////                    results.append(data)
////                }
////            }
////        }
//        
////        for model in all {
////            let m = model.recorders.filter("isPay == true")
////            
////        }
//        
//
//        
////        let allPay = all.map { $0.recorders.filter { $0.isPay == true } }
//        
//        
//        return results
//        
//    }
    
    
    
    func notification(_ block: @escaping () -> ()) {
        let _ = realm.addNotificationBlock { (noti, realm) in
            block()
        }
    }
    
    
    func isContain(date: String) -> Bool {
        return all(RLMRecorderSuper.self).contains { $0.yearMonthDay == date }
    }
}



