//
//  KindDataSource.swift
//  Honeybee
//
//  Created by Dongbing Hou on 09/03/2017.
//  Copyright © 2017 Dongbing Hou. All rights reserved.
//

import UIKit
import RealmSwift

class KindDataSource: NSObject, DataSourceProvider {
    
    typealias ItemType = HoneybeeKind
    var items: [HoneybeeKind]
    required init(items: [ItemType]) {
        self.items = items
    }
    
//    var items: Results<HoneybeeKind>
//    
//    init(items: Results<HoneybeeKind>) {
//        self.items = items
//    }
//    func item(at indexPath: IndexPath) -> HoneybeeKind {
//        return items[indexPath.item]
//    }
    
   
}


extension KindDataSource: UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return items.count
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "\(KindCell.self)", for: indexPath)
        if let cell = cell as? KindCell {
            cell.config(model: items[indexPath.item])
            
//            cell.deleteBtnAction = { [unowned self] in
//                if let idx = collectionView.indexPath(for: cell) {
//                    
//                    Database.manager.delete(item: self.items[idx.item])
//                    
//                    collectionView.deselectItem(at: idx, animated: true)
//                    collectionView.reloadData()
//                }
//            }

        }
        return cell
    }
}
