//
//  CardDataSource.swift
//  Honeybee
//
//  Created by Dongbing Hou on 09/03/2017.
//  Copyright © 2017 Dongbing Hou. All rights reserved.
//

import UIKit
import RealmSwift

class CardDataSource: NSObject {
    
    var items: Results<HoneybeeKind>
    
    fileprivate var identifier: String = "\(CardCollectionCell.self)"
    
    init(items: Results<HoneybeeKind>) {
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
        return items[section].items.count
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: identifier, for: indexPath)
        if let cell = cell as? CardCollectionCell {
            cell.model = items[indexPath.section].items[indexPath.item]
        }
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "\(CardSectionHeader.self)", for: indexPath) as! CardSectionHeader
        header.titleLabel.text = items[indexPath.section].name
        return header
    }
}
