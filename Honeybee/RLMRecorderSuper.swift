//
//  RLMRecorderSuper.swift
//  Honeybee
//
//  Created by Dongbing Hou on 03/03/2017.
//  Copyright © 2017 Dongbing Hou. All rights reserved.
//


//class ShowRecorder {
//    let recorders: [RLMRecorder]
//    init(recorders: [RLMRecorder]) {
//        self.recorders = recorders
//    }
//    
//}



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
    
    dynamic var yearMonthDay: String = ""
    
    var recorders = List<RLMRecorder>()
    var year: String {
        return yearMonthDay.components(separatedBy: "-")[0]
    }
    var month: String {
        return yearMonthDay.components(separatedBy: "-")[1]
    }
    var yearMonth: String {
        return year + "-" + month
    }
    
    
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
                    try! Database.default.add(model: model)
                }
            }
            yearMonthDay = recorders[0].yearMonthDay
        }
        
    }
    override static func ignoredProperties() -> [String] {
        return ["year", "month"]
    }
//    func append(_ model: RLMRecorder) {
//        try! self.realm?.write {
//            recorders.append(model)
//        }
//        try! Database.manager.add(model: model)
//    }
}
