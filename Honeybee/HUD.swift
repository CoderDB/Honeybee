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
        error(msg: msg, description: nil)
    }
    static func error(msg: String?, description: String?, delay: TimeInterval = delay) {
        HUD.flash(.labeledError(title: msg, subtitle: description), delay: delay)
    }
    static func success() {
        HUD.flash(.success, delay: delay)
    }
    static func success(msg: String?, description: String? = nil, delay: TimeInterval = delay) {
        HUD.flash(.labeledSuccess(title: msg, subtitle: description), delay: delay)
    }

}
