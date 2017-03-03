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
    override class func primaryKey() -> String? {
        return "id"
    }
    func mapping(map: Map) {}
    
    required init?(map: Map) {
        super.init()
    }
    required init() {
        fatalError("init() has not been implemented")
    }
    required init(value: Any, schema: RLMSchema) {
        fatalError("init(value:schema:) has not been implemented")
    }
    required init(realm: RLMRealm, schema: RLMObjectSchema) {
        fatalError("init(realm:schema:) has not been implemented")
    }
}
