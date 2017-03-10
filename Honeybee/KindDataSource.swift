//
//  KindDataSource.swift
//  Honeybee
//
//  Created by Dongbing Hou on 09/03/2017.
//  Copyright © 2017 Dongbing Hou. All rights reserved.
//

import UIKit

class KindDataSource: DataSource {
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "\(KindCell.self)", for: indexPath)
        if let cell = cell as? KindCell, let model = items[indexPath.item] as? HoneybeeKind {
            cell.config(model: model)
        }
        return cell
    }
}
