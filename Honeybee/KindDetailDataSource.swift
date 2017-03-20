//
//  ArrayDataSource.swift
//  Honeybee
//
//  Created by Dongbing Hou on 09/03/2017.
//  Copyright © 2017 Dongbing Hou. All rights reserved.
//

import UIKit


class KindDetailDataSource: DataSource {
    
    override init(items: [Any]) {
        super.init(items: items)
    }
}

extension KindDetailDataSource {
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "\(KindDetailCell.self)", for: indexPath)
        if let cell = cell as? KindDetailCell, let model = items[indexPath.row] as? HoneybeeItem {
            cell.configWith(model: model)
        }
        return cell
    }
}
