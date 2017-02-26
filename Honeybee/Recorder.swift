//
//  Reocder.swift
//  Honeybee
//
//  Created by Dongbing Hou on 10/02/2017.
//  Copyright © 2017 Dongbing Hou. All rights reserved.
//


import UIKit

struct Recorder {
    var id: String = UUID().uuidString
    
    var date: String
    var category: [String]
    var money: String
    var remark: String?
    var color: String
    var isPay: Bool = true
    //    var parent:
    var weekday: String = ""
    
    
    init(date: String, category: [String], money: String, remark: String? = nil, color: String) {
        self.id = date
        self.date = date
        self.category = category
        self.money = money
        self.remark = remark
        self.color = color
    }
    
    
    init?(dict: [String: Any]) {
        guard let date = dict["date"] as? String,
            let category = dict["category"] as? [String],
            let money = dict["money"] as? String,
            let color = dict["color"] as? String
            else { return nil }
        
//        self.id = id
        let currentDate = Date.currentTimeZoneDateFrom(aDate: Date.date(str: date))
        self.date = Date.monthDay(date: currentDate)
        self.weekday = Date.weekday(date: currentDate)
        self.category = category
        self.money = money
        self.color = color
        self.remark = dict["remark"] as? String
        self.isPay = dict["isPay"] as? Bool ?? true
    }
}



