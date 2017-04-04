//
//  KindAddDataSource.swift
//  Honeybee
//
//  Created by nvicky on 12/03/2017.
//  Copyright © 2017 Dongbing Hou. All rights reserved.
//

import UIKit
import RealmSwift

class KindAddDataSource: NSObject {
    
    
    fileprivate let colors: [UIColor]
    fileprivate let items: Results<HoneybeeColor>
    
    override init() {
        self.items = Honeybee.default.allColors()
        self.colors = items.map { UIColor(hex: $0.name) }
        super.init()
    }
    
    func item(at indexPath: IndexPath) -> HoneybeeColor {
        return items[indexPath.item]
    }
}

extension KindAddDataSource: UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 2
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if section == 0 {
            return items.toArray.filter { !$0.isUsed } .count
        }
        return items.toArray.filter { $0.isUsed } .count
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "\(KindAddCell.self)", for: indexPath) as! KindAddCell
        cell.backgroundColor = colors[indexPath.item]
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "\(KindAddSectionHeader.self)", for: indexPath) as! KindAddSectionHeader
        if indexPath.section == 0 {
            header.titleLabel.text = "未使用"
        } else {
            header.titleLabel.text = "已使用"
        }
        return header
    }
}
