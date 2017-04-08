//
//  RecorderViewModel.swift
//  Honeybee
//
//  Created by Dongbing Hou on 26/02/2017.
//  Copyright © 2017 Dongbing Hou. All rights reserved.
//

import UIKit

struct RecorderViewModel {
    
    
    let date: String
    let category: String
    var money: String = "0"
    let weekday: String
    
    
    init(model: RLMRecorder) {
        self.date = model.monthDay
        self.weekday = model.weekday
        self.category = model.category
        self.money = formatter(num: model.money)
    }
    func formatter(num: Double) -> String {
        let formatter = NumberFormatter()
        formatter.minimumFractionDigits = 0
        formatter.maximumFractionDigits = 2
        return formatter.string(from: NSNumber(value: num)) ?? "0"
    }
}
