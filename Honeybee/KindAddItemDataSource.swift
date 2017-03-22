//
//  KindAddItemDataSource.swift
//  Honeybee
//
//  Created by Dongbing Hou on 10/03/2017.
//  Copyright © 2017 Dongbing Hou. All rights reserved.
//

import UIKit
import RealmSwift

class KindAddItemDataSource: NSObject {
    
    
    let items: Results<HoneybeeIcon>
    
    override init() {
        self.items = HoneybeeManager.manager.allIcons()
        super.init()
    }
    func item(at indexPath: IndexPath) -> Any {
        return items[indexPath.item]
    }
    
}


extension KindAddItemDataSource: UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return items.count
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "\(KindAddItemCell.self)", for: indexPath)
        if let cell = cell as? KindAddItemCell {
            cell.imgView.image = UIImage(named: items[indexPath.item].name)
        }
        return cell
    }
}
