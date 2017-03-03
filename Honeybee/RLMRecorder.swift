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
    dynamic var id: String = ""
    dynamic var date: String = ""
    dynamic var superCategory: String = ""
    dynamic var category: String = ""
    dynamic var money: String = ""
    dynamic var remark: String = "未填写\n"
    dynamic var color: String = ""
    dynamic var isPay: Bool = true
    dynamic var imageName: String = "meal"
    
    dynamic var weekday: String = ""
    dynamic var yearMonthDay: String = ""
    dynamic var hourMinute:String = ""
    
    override func mapping(map: Map) {
        super.mapping(map: map)
        
        self.id <- map[id]
        self.date <- map[category]
        self.superCategory <- map[superCategory]
        self.money <- map[money]
        self.remark <- map[remark]
        self.color <- map[color]
        //        self.isPay <- map[isPay]
        self.imageName <- map[imageName]
    }
    
    convenience init(model: Recorder) {
        self.init()
        
        self.id = model.id
        self.category = model.category
        self.superCategory = model.superCategory
        self.color = model.color
        self.date = model.date
        self.imageName = model.date
        self.isPay = model.isPay
        self.money = model.money
        self.remark = model.remark
    }
}
