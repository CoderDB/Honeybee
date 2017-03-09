//
//  HoneybeeCategory.swift
//  Honeybee
//
//  Created by Dongbing Hou on 06/03/2017.
//  Copyright © 2017 Dongbing Hou. All rights reserved.
//

import Foundation

/*
 {
 "category": "衣",
 "color": "FF7256",
 "editable": 0,
 "items": [
 {
 "name": "裙子",
 "icon": "qunzi"
 }
 ]
 },
 */

struct HoneybeeKind {
    var name: String
    var color: String
    var isEditable: Bool = true
    var items: [HoneybeeItem]?
    
    init(category: String, color: String, items: [HoneybeeItem]?) {
        self.name = category
        self.color = color
        self.items = items
    }
    init?(dict: [String: Any]) {
        guard let category = dict["category"] as? String,
            let color = dict["color"] as? String,
            let items = dict["items"] as? [[String: Any]]
            else { return nil }
        self.name = category
        self.color = color
        var results = [HoneybeeItem]()
        for item in items {
            let model = HoneybeeItem(dict: item)
            results.append(model!)
        }
        self.items = results
    }
}

struct HoneybeeItem {
    var name: String
    var icon: String
    
    init(name: String, icon: String) {
        self.name = name
        self.icon = icon
    }
    
    init?(dict: [String: Any]) {
        guard let name = dict["name"] as? String,
            let icon = dict["icon"] as? String
            else { return nil }
        self.name = name
        self.icon = icon
    }
}

class HBKindManager: NSObject {
    static let manager = HBKindManager()
    private override init() {}
    func allKinds() -> [HoneybeeKind] {
        let path = Bundle.main.path(forResource: "category_color", ofType: "json")
        let data = try! Data(contentsOf: URL(fileURLWithPath: path!))
        let json = try! JSONSerialization.jsonObject(with: data, options: .mutableContainers) as! [[String: Any]]
        var result = [HoneybeeKind]()
        for item in json {
            let model = HoneybeeKind(dict: item)
            result.append(model!)
        }
        return result
    }
}
