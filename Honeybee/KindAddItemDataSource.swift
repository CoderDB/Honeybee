//
//  KindAddItemDataSource.swift
//  Honeybee
//
//  Created by Dongbing Hou on 10/03/2017.
//  Copyright © 2017 Dongbing Hou. All rights reserved.
//

import UIKit

class KindAddItemDataSource: NSObject {
    
    var items: [Any]
    fileprivate let identifier = "\(KindAddItemCell.self)"
    
    init(items: [Any]) {
        self.items = items
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
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: identifier, for: indexPath)
        if let cell = cell as? KindAddItemCell, let model = items[indexPath.item] as? HoneyBeeIcon {
            cell.imgView.image = UIImage(named: model.name)
        }
        return cell
    }
}
