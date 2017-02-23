//
//  Reocder.swift
//  Honeybee
//
//  Created by Dongbing Hou on 10/02/2017.
//  Copyright © 2017 Dongbing Hou. All rights reserved.
//


import UIKit

enum MoneyType {
    case `in`, out
}

class Recorder: NSObject {
    var id: String
    
    var date: String
    var category: String
    var money: String
    var remark: String
    var color: UIColor
    var type: MoneyType
    //    var parent:
    
    init(type: MoneyType = .out, date: String, category: String, money: String, remark: String, color: UIColor) {
        self.id = date
        self.date = date
        self.category = category
        self.money = money
        self.remark = remark
        self.color = color
        self.type = type
    }
}
