//
//  KindDataSource.swift
//  Honeybee
//
//  Created by Dongbing Hou on 09/03/2017.
//  Copyright © 2017 Dongbing Hou. All rights reserved.
//

import UIKit

class KindDataSource: NSObject {
    
    var identifier: String
    var items: [Any] = []
//    var config: (UICollectionViewCell, Any) -> Void
    
    init(id: String, items: [Any]) {
        self.identifier = id
        self.items = items
//        self.config = config
    }
    
    func item(at idx: IndexPath) -> Any {
        return items[idx.item]
    }
}

extension KindDataSource: UICollectionViewDataSource {

    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return items.count
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: identifier, for: indexPath)
//        config(cell, items[indexPath.item])
        if let cell = cell as? KindCell, let model = items[indexPath.item] as? HoneybeeKind {
            cell.config(model: model)
        }
        return cell
    }
}
