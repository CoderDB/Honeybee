//
//  HoneyBeeIncome.swift
//  Honeybee
//
//  Created by Dongbing Hou on 23/04/2017.
//  Copyright © 2017 Dongbing Hou. All rights reserved.
//
import Foundation
import RealmSwift
import ObjectMapper

class HoneybeeIncome: RLMModel {
    dynamic var name: String = ""
    dynamic var color: String = ""
    
    override func mapping(map: Map) {
        name <- map["name"]
        color <- map["color"]
    }
    
    
    class func json(at path: String) -> Any {
        let path = Bundle.main.path(forResource: path, ofType: "json")
        let data = try! Data(contentsOf: URL(fileURLWithPath: path!))
        let json = try! JSONSerialization.jsonObject(with: data, options: .mutableContainers)
        return json
    }
    class func fetchAllIncomes() {
        if let json = json(at: "incomes") as? [[String: Any]] {
            _ = json.map {
                if let model = Mapper<HoneybeeIncome>().map(JSON: $0) {
                    try! Database.default.add(model: model)
                }
            }
        }
    }
}
