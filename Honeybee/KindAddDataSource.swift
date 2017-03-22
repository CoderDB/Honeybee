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
    fileprivate let items: Results<HoneyBeeColor>
    
    override init() {
        self.items = HBKindManager.manager.allColors()
        self.colors = items.map { UIColor(hex: $0.name) }
        super.init()
    }
    
    func item(at indexPath: IndexPath) -> HoneyBeeColor {
        return items[indexPath.item]
    }
}

extension KindAddDataSource: UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return items.count
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "\(KindAddCell.self)", for: indexPath) as! KindAddCell
        cell.backgroundColor = colors[indexPath.item]
        return cell
    }
}
