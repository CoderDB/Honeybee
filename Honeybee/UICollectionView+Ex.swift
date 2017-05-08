//
//  UICollectionView+Ex.swift
//  Honeybee
//
//  Created by admin on 08/05/2017.
//  Copyright © 2017 Dongbing Hou. All rights reserved.
//

import UIKit
import RxRealm

extension UICollectionView {
    func applyChangeset(_ changes: RealmChangeset) {
        self.performBatchUpdates({ [unowned self] in
            self.deleteItems(at: changes.deleted.map { IndexPath(item: $0, section: 0) })
            self.insertItems(at: changes.inserted.map { IndexPath(item: $0, section: 0) })
            self.reloadItems(at: changes.updated.map { IndexPath(item: $0, section: 0) })
            }, completion: nil)
        
        //        self.performBatchUpdates(<#T##updates: (() -> Void)?##(() -> Void)?##() -> Void#>, completion: <#T##((Bool) -> Void)?##((Bool) -> Void)?##(Bool) -> Void#>)
        //        deleteItems(at: changes.deleted.map { IndexPath(item: $0, section: 0) })
        //        insertItems(at: changes.inserted.map { IndexPath(item: $0, section: 0) })
        //        reloadItems(at: changes.updated.map { IndexPath(item: $0, section: 0) })
    }
}

