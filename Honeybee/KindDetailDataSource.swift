//
//  ArrayDataSource.swift
//  Honeybee
//
//  Created by Dongbing Hou on 09/03/2017.
//  Copyright © 2017 Dongbing Hou. All rights reserved.
//

import UIKit


class KindDetailDataSource: NSObject {
    var identifier: String
    var items: [Any] = []
    var config: (UICollectionViewCell, Any) -> Void
    
    init(identifier: String, items: [Any], config: @escaping (UICollectionViewCell, Any) -> Void) {
        self.identifier = identifier
        self.items = items
        self.config = config
    }
    
    
    func item(at index: IndexPath) -> Any {
        return items[index.row]
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
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: identifier, for: indexPath)
        
        config(cell, items[indexPath.row])
        return cell
    }
}
