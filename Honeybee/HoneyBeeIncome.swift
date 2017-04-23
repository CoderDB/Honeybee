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
}
