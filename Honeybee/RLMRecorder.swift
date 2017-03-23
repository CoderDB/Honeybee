//
//  RLMRecorder.swift
//  Honeybee
//
//  Created by Dongbing Hou on 03/03/2017.
//  Copyright © 2017 Dongbing Hou. All rights reserved.
//

import RealmSwift
import ObjectMapper

class RLMRecorder: RLMModel {
    
//    dynamic var id: String = ""
    
    dynamic var date: String = ""
    dynamic var superCategory: String = ""
    dynamic var category: String = ""
    dynamic var money: String = ""
    dynamic var remark: String = "未填写\n"
    dynamic var color: String = ""
    dynamic var isPay: Bool = true
    dynamic var imageName: String = "meal"
    
    var monthDay: String {
        get {
            return Date.date(from: date).localDate.monthDay
        }
    }
    var weekday: String {
        return Date.date(from: date).localDate.weekday
    }
    var yearMonthDay: String {
        return Date.date(from: date).localDate.yearMonthDay
    }
    var hourMinute:String {
        return Date.date(from: date).localDate.hourMinute
    }
    
    
    override static func ignoredProperties() -> [String] {
        return ["weekday", "yearMonthDay", "hourMinute", "monthDay"]
    }
    
    
    override func mapping(map: Map) {
        super.mapping(map: map)
        
//        self.id <- map[id]
        self.date <- map["date"]
        self.category <- map["category"]
        self.superCategory <- map["superCategory"]
        self.money <- map["money"]
        self.remark <- map["remark"]
        self.color <- map["color"]
        self.isPay <- map["isPay"]
        self.imageName <- map["imageName"]
        
//        let currentDate = Date.date(from: date).localDate
//        self.monthDay = currentDate.monthDay
//        self.weekday = currentDate.weekday
//        self.yearMonthDay = currentDate.yearMonthDay
//        self.hourMinute = currentDate.hourMinute
    }
}
