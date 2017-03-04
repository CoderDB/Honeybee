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
    dynamic var date: String = ""
    dynamic var superCategory: String = ""
    dynamic var category: String = ""
    dynamic var money: String = ""
    dynamic var remark: String = "未填写\n"
    dynamic var color: String = ""
    dynamic var isPay: Bool = true
    dynamic var imageName: String = "meal"
    
    var weekday: String = ""
    var yearMonthDay: String = ""
    var hourMinute:String = ""
    
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
//        self.isPayOut <- (map[isPayOut], TransformOf<String, Int>(fromJSON: {Int($0)}, toJSON: {$0.map{String($0)}}))
        self.imageName <- map["imageName"]
        
//        let transform = TransformOf(fromJSON: { (value: Int) -> Bool in
//            return Bool(value)
//        }) { (value: Bool) -> Int in
//            Int(value)
//        }
        
        let currentDate = Date.date(from: date).localDate
        self.date = currentDate.monthDay
        self.weekday = currentDate.weekday
        self.yearMonthDay = currentDate.yearMonthDay
        self.hourMinute = currentDate.hourMinute
    }
}
