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
//    var recorders = List<YearRecorder>()
        var recorders = List<RLMRecorder>()
    
//    dynamic var year: UInt = 2017
//    dynamic var month: UInt8 = 12
    
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
        
//        if let json = map["recorders"].currentValue as? [[String: Any]] {
//            _ = json.map {
//                if let model = Mapper<YearRecorder>().map(JSON: $0) {
//                    recorders.append(model)
//                    
//                    try! Database.default.add(model: model)
//                }
//            }
//        }
        
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
    
    
    
    private class func json(at path: String) -> Any {
        let path = Bundle.main.path(forResource: path, ofType: "json")
        let data = try! Data(contentsOf: URL(fileURLWithPath: path!))
        let json = try! JSONSerialization.jsonObject(with: data, options: .mutableContainers)
        return json
    }
    class func fetchRecorders() {
        if let json = json(at: "recorders_year_month") as? [[String: Any]] {
            _ = json.map {
                if let model = Mapper<RLMRecorderSuper>().map(JSON: $0) {
                    try! Database.default.add(model: model)
                }
            }
        }
    }
    
}





//class YearRecorder: RLMModel {
//    dynamic var year: Int = 2017
//    var recorders = List<MonthRecorder>()
//    
//    override func mapping(map: Map) {
//        year <- map["year"]
//        if let json = map["recorders"].currentValue as? [[String: Any]] {
//            _ = json.map {
//                if let model = Mapper<MonthRecorder>().map(JSON: $0) {
//                    recorders.append(model)
//                    
//                    try! Database.default.add(model: model)
//                }
//            }
//        }
//    }
//}
//
//class MonthRecorder: RLMModel {
//    
//    dynamic var month: Int = 1
//    var recorders = List<RLMRecorder>()
//    
//    override func mapping(map: Map) {
//        month <- map["month"]
//        if let json = map["recorders"].currentValue as? [[String: Any]] {
//            _ = json.map {
//                if let model = Mapper<RLMRecorder>().map(JSON: $0) {
//                    recorders.append(model)
//                    
//                    try! Database.default.add(model: model)
//                }
//            }
//        }
//    }
//}
