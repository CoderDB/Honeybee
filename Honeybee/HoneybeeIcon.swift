//
//  HoneyBeeIcon.swift
//  Honeybee
//
//  Created by Dongbing Hou on 22/03/2017.
//  Copyright © 2017 Dongbing Hou. All rights reserved.
//

import Foundation
import ObjectMapper
import RealmSwift

class HoneybeeIcon: RLMModel {
    
    dynamic var name: String = ""
    
    override func mapping(map: Map) {
        name <- map["name"]
    }
    class func json(at path: String) -> Any {
        let path = Bundle.main.path(forResource: path, ofType: "json")
        let data = try! Data(contentsOf: URL(fileURLWithPath: path!))
        let json = try! JSONSerialization.jsonObject(with: data, options: .mutableContainers)
        return json
    }
    class func fetchAllIcons() {
        if let json = json(at: "icons") as? [[String: Any]] {
            _ = json.map {
                if let model = Mapper<HoneybeeIcon>().map(JSON: $0) {
                    DatabaseManager.manager.add(model: model)
                }
            }
        }
    }
}
