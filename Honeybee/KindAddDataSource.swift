//
//  KindAddDataSource.swift
//  Honeybee
//
//  Created by nvicky on 12/03/2017.
//  Copyright © 2017 Dongbing Hou. All rights reserved.
//

import UIKit

class KindAddDataSource: DataSource {
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "\(KindAddCell.self)", for: indexPath) as! KindAddCell
        cell.backgroundColor = UIColor.randomHSVColor
        return cell
    }
    
    
}
