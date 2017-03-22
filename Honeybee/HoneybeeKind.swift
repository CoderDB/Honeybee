//
//  HoneybeeKind.swift
//  Honeybee
//
//  Created by Dongbing Hou on 22/03/2017.
//  Copyright © 2017 Dongbing Hou. All rights reserved.
//

import Foundation
import ObjectMapper
import RealmSwift

class HoneybeeItem: RLMModel {
    
    dynamic var name: String = ""
    dynamic var icon: String = ""
    
    override func mapping(map: Map) {
        name <- map["name"]
        icon <- map["icon"]
    }
}

class HoneybeeKind: RLMModel {
    
    dynamic var name: String = ""
    dynamic var color: String = ""
    //    var color: HoneyBeeColor
    //    var isEditable: Bool = true
    var items = List<HoneybeeItem>()
    
    
    override func mapping(map: Map) {
        name <- map["category"]
        color <- map["color"]
        if let json = map["items"].currentValue as? [[String: Any]] {
            for item in json {
                if let model = Mapper<HoneybeeItem>().map(JSON: item) {
                    items.append(model)
                    DatabaseManager.manager.add(model: model)
                }
            }
        }
    }
    class private func json(at path: String) -> Any {
        let path = Bundle.main.path(forResource: path, ofType: "json")
        let data = try! Data(contentsOf: URL(fileURLWithPath: path!))
        let json = try! JSONSerialization.jsonObject(with: data, options: .mutableContainers)
        return json
    }
    class func fetchAllKinds() {
        if let json = json(at: "category_color") as? [[String: Any]] {
            _ = json.map {
                if let model = Mapper<HoneybeeKind>().map(JSON: $0) {
                    DatabaseManager.manager.add(model: model)
                }
            }
        }
    }
}


