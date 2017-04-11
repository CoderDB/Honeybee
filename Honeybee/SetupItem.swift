//
//  SetupItem.swift
//  Honeybee
//
//  Created by Dongbing Hou on 13/02/2017.
//  Copyright © 2017 Dongbing Hou. All rights reserved.
//

import UIKit

class SetupItem: NSObject {
    
    var title, subTitle: String
    
    init(title: String, subTitle: String) {
        self.title = title
        self.subTitle = subTitle
    }
}

class SetupArrowItem: SetupItem {
  
}

class SetupSwitchItem: SetupItem {
    
}

class SetupImageItem: SetupItem {
    
}
