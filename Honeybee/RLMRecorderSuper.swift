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
    
    
    dynamic var color: String = ""
    dynamic var name: String = ""
    var recorders = List<RLMRecorder>()
    
//    dynamic var totalPay: Int = 0
    
//    dynamic var yearMonthDay: String = ""
    
//    var year: String {
//        return yearMonthDay.components(separatedBy: "-")[0]
//    }
//    var month: String {
//        return yearMonthDay.components(separatedBy: "-")[1]
//    }
//    var yearMonth: String {
//        return year + "-" + month
//    }
    
    
    override func mapping(map: Map) {
        color <- map["color"]
        name <- map["name"]
//        totalPay <- map["totalPay"]
        
        if let json = map["recorders"].currentValue as? [[String: Any]] {
            for item in json {
                if let model = Mapper<RLMRecorder>().map(JSON: item) {
                    recorders.append(model)
                    try! Database.default.add(model: model)
                }
            }
        }
        
    }
    override static func ignoredProperties() -> [String] {
        return ["totalPay"]
    }
//    func append(_ model: RLMRecorder) {
//        try! self.realm?.write {
//            recorders.append(model)
//        }
//        try! Database.manager.add(model: model)
//    }
    
    var totalPay: Int {
        return self.recorders.reduce(0, { $0.0 + Int($0.1.money) })
    }
    
}
