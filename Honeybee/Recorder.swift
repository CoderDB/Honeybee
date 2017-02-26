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
        self.date = Date.monthDay(date: Date.currentTimeZoneDateFrom(aDate: Date.date(str: date)))
        self.category = category
        self.money = money
        self.color = color
        self.remark = dict["remark"] as? String
        self.isPay = dict["isPay"] as? Bool ?? true
    }
}



