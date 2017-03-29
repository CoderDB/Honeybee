//
//  RLMRecorderSuper.swift
//  Honeybee
//
//  Created by Dongbing Hou on 03/03/2017.
//  Copyright © 2017 Dongbing Hou. All rights reserved.
//

import RealmSwift
import ObjectMapper

class RLMRecorderSuper: RLMModel {
    
//    dynamic var id: String = NSUUID().uuidString
    
//    override class func primaryKey() -> String? {
//        return "id"
//    }
    
    dynamic var style: String = "plain"
    dynamic var color: String = ""
    dynamic var name: String = ""
    dynamic var totalPay: Int = 0
    
    var recorders = List<RLMRecorder>()
    var yearMonthDay: String = ""
    
    override func mapping(map: Map) {
        style <- map["style"]
        color <- map["color"]
        name <- map["name"]
        totalPay <- map["totalPay"]
        
        if let json = map["recorders"].currentValue as? [[String: Any]] {
            for item in json {
                if let model = Mapper<RLMRecorder>().map(JSON: item) {
//                    totalPay += model.money
                    recorders.append(model)
                    try! DatabaseManager.manager.add(model: model)
                }
            }
            yearMonthDay = recorders[0].yearMonthDay
            
        }
        
    }
    
    func append(_ model: RLMRecorder) {
        try! self.realm?.write {
            recorders.append(model)
        }
        try! DatabaseManager.manager.add(model: model)
    }
}
