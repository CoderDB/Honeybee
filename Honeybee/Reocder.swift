//
//  Reocder.swift
//  Honeybee
//
//  Created by Dongbing Hou on 10/02/2017.
//  Copyright © 2017 Dongbing Hou. All rights reserved.
//

import UIKit

class Reocder: NSObject {
    
    var id: String
    
    var date: String
    var category: String
    var money: String
    var remark: String
    
    init(date: String, category: String, money: String, remark: String) {
        self.id = date
        self.date = date
        self.category = category
        self.money = money
        self.remark = remark
    }
    
    
}
