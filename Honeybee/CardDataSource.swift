//
//  CardDataSource.swift
//  Honeybee
//
//  Created by Dongbing Hou on 09/03/2017.
//  Copyright © 2017 Dongbing Hou. All rights reserved.
//

import UIKit

class CardDataSource: NSObject {
    
    var items: [HoneybeeKind]
    fileprivate var identifier: String = "\(CardCollectionCell.self)"
    
    init(items: [HoneybeeKind]) {
        self.items = items
    }
    
    func item(at indexPath: IndexPath) -> HoneybeeKind {
        return items[indexPath.section]
    }
}

// MARK: UICollectionViewDataSource

extension CardDataSource: UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return items.count
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        guard let items = items[section].items else {
            return 0
        }
        return items.count
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: identifier, for: indexPath)
        if let cell = cell as? CardCollectionCell, let items = items[indexPath.section].items {
            cell.model = items[indexPath.item]
        }
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "\(CardSectionHeader.self)", for: indexPath) as! CardSectionHeader
        header.titleLabel.text = items[indexPath.section].name
        return header
    }
}
