//
//  RLMRecorderSuper.swift
//  Honeybee
//
//  Created by Dongbing Hou on 03/03/2017.
//  Copyright © 2017 Dongbing Hou. All rights reserved.
//

import RealmSwift

class RLMRecorderSuper: RLMModel {
    dynamic var style: String = "plain"
    var recorders = List<RLMRecorder>()
    
    convenience init(style: String, recorders: List<RLMRecorder>) {
        self.init()
        
        self.style = style
        self.recorders = recorders
    }
}
