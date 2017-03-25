//
//  HUD.swift
//  Honeybee
//
//  Created by Dongbing Hou on 25/03/2017.
//  Copyright © 2017 Dongbing Hou. All rights reserved.
//


import PKHUD

class Reminder {
    static let delay: TimeInterval = 1.0
    
    class func waiting() {
        HUD.flash(.systemActivity, delay: delay)
    }

}
