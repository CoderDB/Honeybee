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
    
    private var realm: Realm
    static let manager = DatabaseManager()
    private override init() {
        var config = Realm.Configuration()
        config.fileURL = config.fileURL!.deletingLastPathComponent().appendingPathComponent("honeybee.realm")
        self.realm = try! Realm(configuration: config)
        
        print(realm.configuration.fileURL!)
        super.init()
    }
//    func insertHead<T: RLMModel>(item: T, to: List<T>) throws {
//        do {
//            try insert(item: item, to: to, at: 0)
//        } catch let error {
//            throw error
//        }
//    }
    func create<T: RLMModel>(_: T.Type, value: Any) {
        do {
            try realm.write {
                realm.create(T.self, value: value, update: false)
            }
        } catch let error {
            print(error)
        }
    }
    
    /// default insert to head
    func insert<T: RLMModel>(item: T, to: List<T>, at: Int? = 0) throws {
        do {
            try realm.write {
                to.insert(item, at: at!)
            }
        } catch let error {
            throw error
        }
    }
    func append<T: RLMModel>(item: T, to: List<T>) throws {
        do {
            try realm.write {
                to.append(item)
            }
        } catch let error {
            throw(error)
        }
    }
    
    func add<T: RLMModel>(model: T, update: Bool? = false) {
        do {
            try realm.write {
                realm.add(model, update: update!)
            }
        } catch let error {
            print(error.localizedDescription)
        }
    }

    func delete<T: RLMModel, U: RLMModel>(item: T, children: List<U>) {
        do {
            try realm.write {
                realm.delete(children)
                realm.delete(item)
            }
        } catch let error {
            print(error.localizedDescription)
        }
    }
    func delete<T: RLMModel>(item: T) {
        do {
            try realm.write {
                realm.delete(item)
            }
        } catch let error {
            print(error.localizedDescription)
        }
    }
    func deleteAll() {
        do {
            try realm.write {
                realm.deleteAll()
            }
        } catch let err {
            print(err.localizedDescription)
        }
    }
    func update<T: HoneybeeKind>(item: T, name: String) throws {
        do {
            try realm.write {
                item.name = name
            }
        } catch let error {
            throw error
        }
    }
    
//    func update<T: RLMModel>(item: T, properties: Any...) {
//        // 1. 直接更新 model.name = "new name"
//        // 2. 通过primaryKey更新
//        // 3. KVO
//        
//        add(model: item, update: true)
//    }
    
    func query<T: RLMModel>(_ type: T.Type, id: String) -> T? {
        return realm.object(ofType: T.self, forPrimaryKey: id)
    }
    func all<T: RLMModel>(_: T.Type) -> Results<T> {
        return realm.objects(T.self)
    }
    
    func notification(_ block: @escaping (Realm.Notification, Realm) -> Void) -> NotificationToken {
        return realm.addNotificationBlock { (noti, realm) in
            block(noti, realm)
        }
    }
    
//    func isContain(date: String) -> Bool {
//        return all(RLMRecorderSuper.self).contains { $0.yearMonthDay == date }
//    }
    
//    func allData() -> Results<RLMRecorderSuper> {
//        return realm.objects(RLMRecorderSuper.self)
//    }
    
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
}



