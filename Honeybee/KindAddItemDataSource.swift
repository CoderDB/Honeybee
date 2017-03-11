//
//  KindAddItemDataSource.swift
//  Honeybee
//
//  Created by Dongbing Hou on 10/03/2017.
//  Copyright © 2017 Dongbing Hou. All rights reserved.
//

import UIKit

class KindAddItemDataSource: DataSource {
    
    init() {
        super.init(items:  HBKindManager.manager.allIcons())
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "\(KindAddItemCell.self)", for: indexPath)
        if let cell = cell as? KindAddItemCell, let model = items[indexPath.item] as? HoneyBeeIcon {
            cell.imgView.image = UIImage(named: model.name)
        }
        return cell
    }
}
