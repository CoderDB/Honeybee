//
//  RecorderViewModel.swift
//  Honeybee
//
//  Created by Dongbing Hou on 26/02/2017.
//  Copyright © 2017 Dongbing Hou. All rights reserved.
//

import UIKit

struct RecorderViewModel: BaseViewModel {
    
    
    let date: String
    let category: String
    let money: String
    
    init(model: Recorder) {
        self.date = model.date
        self.category = model.category[0]
        self.money = model.money
    }
    
}