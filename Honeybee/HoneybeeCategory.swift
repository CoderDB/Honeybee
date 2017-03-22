//
//  HoneybeeCategory.swift
//  Honeybee
//
//  Created by Dongbing Hou on 06/03/2017.
//  Copyright © 2017 Dongbing Hou. All rights reserved.
//

import Foundation
import ObjectMapper
import RealmSwift


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
    private func json(at path: String) -> Any {
        let path = Bundle.main.path(forResource: path, ofType: "json")
        let data = try! Data(contentsOf: URL(fileURLWithPath: path!))
        let json = try! JSONSerialization.jsonObject(with: data, options: .mutableContainers)
        return json
    }
    func fetchAllKinds() {
        if let json = json(at: "category_color") as? [[String: Any]] {
            _ = json.map {
                if let model = Mapper<HoneybeeKind>().map(JSON: $0) {
                    DatabaseManager.manager.add(model: model)
                }
            }
        }
    }
}

class HoneybeeItem: RLMModel {
    
    dynamic var name: String = ""
    dynamic var icon: String = ""
    
    override func mapping(map: Map) {
        name <- map["name"]
        icon <- map["icon"]
    }
}

class HoneyBeeIcon: RLMModel {
    
    dynamic var name: String = ""
    
    override func mapping(map: Map) {
        name <- map["name"]
    }
    func json(at path: String) -> Any {
        let path = Bundle.main.path(forResource: path, ofType: "json")
        let data = try! Data(contentsOf: URL(fileURLWithPath: path!))
        let json = try! JSONSerialization.jsonObject(with: data, options: .mutableContainers)
        return json
    }
    func fetchAllIcons() {
        if let json = json(at: "icons") as? [[String: Any]] {
            _ = json.map {
                if let model = Mapper<HoneyBeeIcon>().map(JSON: $0) {
                    DatabaseManager.manager.add(model: model)
                }
            }
        }
    }
}


struct HoneyBeeColor {
    var name: String = ""
    var isUsed: Bool = false
    var link: String? = ""
    
    init?(dict: [String: Any]) {
        guard let name = dict["name"] as? String,
            let isUsed = dict["isUsed"] as? Bool
            else { return nil }
        self.name = name
        self.isUsed = isUsed
    }
}

class HBKindManager: NSObject {
    static let manager = HBKindManager()
    private override init() {}
    
    func allKinds() -> Results<HoneybeeKind> {
        return DatabaseManager.manager.all(HoneybeeKind.self)
    }
    
    func allIcons() -> Results<HoneyBeeIcon> {
        return DatabaseManager.manager.all(HoneyBeeIcon.self)
    }
    
    func json(at path: String) -> Any {
        let path = Bundle.main.path(forResource: path, ofType: "json")
        let data = try! Data(contentsOf: URL(fileURLWithPath: path!))
        let json = try! JSONSerialization.jsonObject(with: data, options: .mutableContainers)
        return json
    }
    
    func allColors() -> [HoneyBeeColor] {
        var result = [HoneyBeeColor]()
        if let json = json(at: "colors") as? [[String: Any]] {
            for item in json {
//                let model = Mapper<HoneyBeeColor>().map(JSON: item)
                let model = HoneyBeeColor(dict: item)!
                result.append(model)
            }
        }
        return result
    }
}
