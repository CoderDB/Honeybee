//
//  HoneybeeCategory.swift
//  Honeybee
//
//  Created by Dongbing Hou on 06/03/2017.
//  Copyright © 2017 Dongbing Hou. All rights reserved.
//

import Foundation
import RealmSwift


class HoneybeeManager {
    
    static let manager = HoneybeeManager()
    private init() {}
    
    func allKinds() -> Results<HoneybeeKind> {
        return DatabaseManager.manager.all(HoneybeeKind.self)
    }
    
    func allIcons() -> Results<HoneybeeIcon> {
        return DatabaseManager.manager.all(HoneybeeIcon.self)
    }

    func allColors() -> Results<HoneybeeColor> {
        return DatabaseManager.manager.all(HoneybeeColor.self)
    }
}
