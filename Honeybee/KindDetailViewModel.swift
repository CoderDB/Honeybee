//
//  KindDetailViewModel.swift
//  Honeybee
//
//  Created by Dongbing Hou on 08/05/2017.
//  Copyright © 2017 Dongbing Hou. All rights reserved.
//

import UIKit

class KindDetailViewModel: NSObject {
    
    let kind: HoneybeeKind
    init(kind: HoneybeeKind) {
        self.kind = kind
    }
}

extension KindDetailViewModel: DataProvider {
    
    typealias ItemType = HoneybeeKind
    typealias AnotherItemType = HoneybeeKind
    
    func numberOfSections() -> Int {
        return 1
    }
    func numberOfItems(in section: Int) -> Int {
        return 1
    }
    func item(at indexPath: IndexPath) -> HoneybeeKind {
        return HoneybeeKind()
    }
    func identifier(at indexPath: IndexPath) -> String {
        return "\(KindDetailCell.self)"
    }
    func additions() -> HoneybeeKind {
        return HoneybeeKind()
    }
}
