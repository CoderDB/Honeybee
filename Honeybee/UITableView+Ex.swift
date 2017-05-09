//
//  UITableView+Ex.swift
//  Honeybee
//
//  Created by admin on 08/05/2017.
//  Copyright © 2017 Dongbing Hou. All rights reserved.
//

import UIKit
import RxRealm


extension UITableView {
    func applyChangeset(_ changes: RealmChangeset) {
        beginUpdates()
        deleteRows(at: changes.deleted.map { IndexPath(row: $0, section: 0)}, with: .automatic)
        insertRows(at: changes.inserted.map { IndexPath(row: $0, section: 0)}, with: .automatic)
        reloadRows(at: changes.updated.map { IndexPath(row: $0, section: 0) }, with: .automatic)
        endUpdates()
    }
}
