//
//  RecorderSuper.swift
//  Honeybee
//
//  Created by Dongbing Hou on 03/03/2017.
//  Copyright © 2017 Dongbing Hou. All rights reserved.
//

struct RecorderSuper {
    
    var style: RecorderStyle
    var recorders: [Recorder]? = []
    
    init(style: String, recorders: [Recorder]? = []) {
        self.style = RecorderStyle(rawValue: style)!
        self.recorders = recorders
    }
    
    init?(dict: [String: Any]) {
        guard let style = dict["style"] as? String else { return nil }
        self.style = RecorderStyle(rawValue: style)!
        if let recorders = dict["recorders"] as? [[String: Any]] {
            for item in recorders {
                let model = Recorder(dict: item)
                self.recorders?.append(model!)
//                DatabaseManager.manager.add(model: model!)
            }
        }
    }
}
