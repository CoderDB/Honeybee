//
//  HoneybeeCategory.swift
//  Honeybee
//
//  Created by Dongbing Hou on 06/03/2017.
//  Copyright © 2017 Dongbing Hou. All rights reserved.
//

import Foundation
import RealmSwift


class Honeybee {
    
    static let `default` = Honeybee()
    private init() {}
    
    func allKinds() -> Results<HoneybeeKind> {
        return Database.default.all(HoneybeeKind.self)
    }
    
    func allIcons() -> Results<HoneybeeIcon> {
        return Database.default.all(HoneybeeIcon.self)
    }

    func allColors() -> Results<HoneybeeColor> {
        return Database.default.all(HoneybeeColor.self)
    }
    func addIncomes() -> Results<HoneybeeIncome> {
        return Database.default.all(HoneybeeIncome.self)
    }
    
    
    ///
    func all<T: RLMModel>(_: T.Type) -> Results<T> {
        return Database.default.all(T.self)
    }
}
