//
//  RLMModel.swift
//  Honeybee
//
//  Created by Dongbing Hou on 03/03/2017.
//  Copyright © 2017 Dongbing Hou. All rights reserved.
//

import RealmSwift
import Realm
import ObjectMapper


class RLMModel: Object, Mappable {
    dynamic var id: String = NSUUID().uuidString
    
    override class func primaryKey() -> String? {
        return "id"
    }
    func mapping(map: Map) {
//        id <- map["id"]
    }
    
    func map<T: RLMModel>(type: T.Type, value: Any) -> T? {
        if let value = value as? [String: Any] {
           return Mapper<T>().map(JSON: value)
        }
        return nil
    }
    
    required init?(map: Map) {
        super.init()
    }
    required init() {
        super.init()
    }
    required init(value: Any, schema: RLMSchema) {
        super.init(value: value, schema: schema)
    }
    required init(realm: RLMRealm, schema: RLMObjectSchema) {
        super.init(realm: realm, schema: schema)
    }
}
