//
//  IncomeDataSource.swift
//  Honeybee
//
//  Created by Dongbing Hou on 22/04/2017.
//  Copyright © 2017 Dongbing Hou. All rights reserved.
//

import UIKit

class IncomeDataSource: NSObject, DataSourceProvider {

    typealias ItemType = HoneybeeIncome
    var items: [HoneybeeIncome]
    required init(items: [ItemType]) {
        self.items = items
    }
}

extension IncomeDataSource: UICollectionViewDataSource {

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return items.count
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "\(IncomeCell.self)", for: indexPath)
        if let cell = cell as? IncomeCell {
            cell.config(model: items[indexPath.item])
            
        }
        return cell
    }

}
