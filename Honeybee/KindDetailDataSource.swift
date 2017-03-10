//
//  ArrayDataSource.swift
//  Honeybee
//
//  Created by Dongbing Hou on 09/03/2017.
//  Copyright © 2017 Dongbing Hou. All rights reserved.
//

import UIKit


class KindDetailDataSource: DataSource {
    var config: (UICollectionViewCell, Any) -> Void
    
    init(items: [Any], config: @escaping (UICollectionViewCell, Any) -> Void) {
        self.config = config
        super.init(items: items)
    }
}

extension KindDetailDataSource {
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "\(KindDetailCell.self)", for: indexPath)
        config(cell, items[indexPath.row])
        return cell
    }
}
