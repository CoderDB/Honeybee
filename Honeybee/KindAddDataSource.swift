//
//  KindAddDataSource.swift
//  Honeybee
//
//  Created by nvicky on 12/03/2017.
//  Copyright © 2017 Dongbing Hou. All rights reserved.
//

import UIKit
import RealmSwift

class KindAddDataSource: NSObject, DataSourceProvider {
    
    typealias ItemType = [HoneybeeColor]
    var items: [[HoneybeeColor]]
    required init(items: [ItemType]) {
        
        let all = Honeybee.default.allColors().toArray
        let used = all.filter { $0.isUsed }
        let unused = all.filter { !$0.isUsed }
        self.items = [unused, used]
    }
    
    func item(at indexPath: IndexPath) -> HoneybeeColor {
        return items[indexPath.section][indexPath.item]
    }
    
//    fileprivate let items: [[HoneybeeColor]]
//    override init() {
//        let all = Honeybee.default.allColors().toArray
//        let used = all.filter { $0.isUsed }
//        let unused = all.filter { !$0.isUsed }
//        self.items = [unused, used]
//        
//        super.init()
//    }
//    func item(at indexPath: IndexPath) -> HoneybeeColor {
//        return items[indexPath.section][indexPath.item]
//    }
}

extension KindAddDataSource: UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return items.count
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return items[section].count
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "\(KindAddCell.self)", for: indexPath) as! KindAddCell
        cell.backgroundColor = UIColor(hex: item(at: indexPath).name)
        if indexPath.section == 1 {
            cell.selectedImg.isHidden = false
            cell.isUserInteractionEnabled = false
        } else {
            cell.selectedImg.isHidden = true
            cell.isUserInteractionEnabled = true
        }
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
