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
    
    dynamic var id: String = NSUUID().uuidString
    
    override class func primaryKey() -> String? {
        return "id"
    }
    
    dynamic var style: String = "plain"
    
    var recorders = List<RLMRecorder>()
    var yearMonthDay: String = ""
    
    override func mapping(map: Map) {
        style <- map["style"]
        
        if let json = map["recorders"].currentValue as? [[String: Any]] {
            for item in json {
                if let model = Mapper<RLMRecorder>().map(JSON: item) {
                    model.id = id
                    recorders.append(model)
                    DatabaseManager.manager.add(model: model)
                }
            }
            yearMonthDay = recorders[0].yearMonthDay
        }
        
    }
}
