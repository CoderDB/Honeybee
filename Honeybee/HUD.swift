//
//  HUD.swift
//  Honeybee
//
//  Created by Dongbing Hou on 25/03/2017.
//  Copyright © 2017 Dongbing Hou. All rights reserved.
//


import PKHUD

struct Reminder {
    
    private static let delay: TimeInterval = 1.0
    
    static func waiting() {
        HUD.flash(.systemActivity, delay: delay)
    }
    
    static func error() {
        HUD.flash(.error, delay: delay)
    }
    static func error(msg: String) {
        HUD.flash(.labeledError(title: msg, subtitle: nil), delay: delay)
    }
    static func success() {
        HUD.flash(.success, delay: delay)
    }

}
