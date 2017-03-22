//
//  ArrayDataSource.swift
//  Honeybee
//
//  Created by Dongbing Hou on 09/03/2017.
//  Copyright © 2017 Dongbing Hou. All rights reserved.
//

import UIKit

import RealmSwift

class KindDetailDataSource: NSObject {
    
    var items: List<HoneybeeItem>
    var isEditing: Bool
    
    init(items: List<HoneybeeItem>, isEditing: Bool = false) {
        self.items = items
        self.isEditing = isEditing
    }
    func item(at indexPath: IndexPath) -> HoneybeeItem {
        return items[indexPath.item]
    }
}

extension KindDetailDataSource: UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return items.count
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "\(KindDetailCell.self)", for: indexPath)
        if let cell = cell as? KindDetailCell {
            cell.configWith(model: items[indexPath.item], isEditing: isEditing)
            
            cell.deleteBtnAction = { [unowned self] in
                
                if let idx = collectionView.indexPath(for: cell) {
                    
                    //self.items.remove(at: idx.item)
                    DatabaseManager.manager.delete(item: self.items[idx.item])
                    
                    collectionView.deselectItem(at: idx, animated: true)
                    collectionView.reloadData()
                }
            }
        }
        return cell
    }
}



