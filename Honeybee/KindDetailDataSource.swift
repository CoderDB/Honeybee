//
//  ArrayDataSource.swift
//  Honeybee
//
//  Created by Dongbing Hou on 09/03/2017.
//  Copyright © 2017 Dongbing Hou. All rights reserved.
//

import UIKit


class KindDetailDataSource: DataSource {
    
    var isEditing: Bool
    
    init(items: [Any], isEditing: Bool = false) {
        
        self.isEditing = isEditing
        super.init(items: items)
    }
    
}

extension KindDetailDataSource {
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "\(KindDetailCell.self)", for: indexPath)
        if let cell = cell as? KindDetailCell, let model = items[indexPath.item] as? HoneybeeItem {
            cell.configWith(model: model, isEditing: isEditing)
            
            cell.deleteBtnAction = { [unowned self] in
                
                if let idx = collectionView.indexPath(for: cell) {
                    self.items.remove(at: idx.item)
                    collectionView.deselectItem(at: idx, animated: true)
                    collectionView.reloadData()
                }
            }
        }
        return cell
    }
}
