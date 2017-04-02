//
//  HoneybeeColor.swift
//  Honeybee
//
//  Created by Dongbing Hou on 22/03/2017.
//  Copyright © 2017 Dongbing Hou. All rights reserved.
//

import Foundation
import ObjectMapper
import RealmSwift

class HoneybeeColor: RLMModel {
    dynamic var name: String = ""
    dynamic var isUsed: Bool = false
    dynamic var linkTo: String = ""
    
    override func mapping(map: Map) {
        name <- map["name"]
        isUsed <- map["isUsed"]
    }
    
    class func json(at path: String) -> Any {
        let path = Bundle.main.path(forResource: path, ofType: "json")
        let data = try! Data(contentsOf: URL(fileURLWithPath: path!))
        let json = try! JSONSerialization.jsonObject(with: data, options: .mutableContainers)
        return json
    }
    
    class func fetchAllColors() {
        if let json = json(at: "colors") as? [[String: Any]] {
            _ = json.map {
                if let model = Mapper<HoneybeeColor>().map(JSON: $0) {
                    try! Database.default.add(model: model)
                }
            }
        }
    }
}

