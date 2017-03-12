//
//  KindAddDataSource.swift
//  Honeybee
//
//  Created by nvicky on 12/03/2017.
//  Copyright © 2017 Dongbing Hou. All rights reserved.
//

import UIKit

class KindAddDataSource: DataSource {
    
    var colors: [UIColor]
    init() {
        self.colors = HBKindManager.manager.allColors()
            .filter { !$0.isUsed }
            .map { UIColor(hex: $0.name) }
        super.init(items: colors)
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "\(KindAddCell.self)", for: indexPath) as! KindAddCell
        cell.backgroundColor = colors[indexPath.item]
        return cell
    }
    
    
}
