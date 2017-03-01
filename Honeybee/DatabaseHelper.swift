//
//  DatabaseHelper.swift
//  Honeybee
//
//  Created by Dongbing Hou on 01/03/2017.
//  Copyright © 2017 Dongbing Hou. All rights reserved.
//

import Foundation

class DatabaseHelper: NSObject {
    private override init() {}
    static func helper() {
        
    }

}

import RealmSwift

class RecorderModel: Object {
    dynamic var id = NSUUID().uuidString
    dynamic var date: String = ""
    dynamic var superCategory: String = ""
    dynamic var category: String = ""
    dynamic var money: String = ""
    dynamic var remark: String = "未填写\n"
    dynamic var color: String = ""
    dynamic var isPay: Bool = true
    dynamic var imageName: String = "meal"
}
