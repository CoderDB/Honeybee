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
    dynamic var style: String = "plain"
    var recorders = List<RLMRecorder>()
    
    override func mapping(map: Map) {
        style <- map["style"]
        
        let json = map["recorders"].currentValue as! [[String: Any]]
        for item in json {
            let model = Mapper<RLMRecorder>().map(JSON: item)
            recorders.append(model!)
            DatabaseManager.manager.add(model: model!)
        }
    }
    
//    convenience init(style: String, recorders: List<RLMRecorder>) {
//        self.init()
//        self.style = style
//        self.recorders = recorders
//    }
}
