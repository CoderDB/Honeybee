//
//  RecorderDetailDataSource.swift
//  Honeybee
//
//  Created by Dongbing Hou on 11/03/2017.
//  Copyright © 2017 Dongbing Hou. All rights reserved.
//

import UIKit

//class RecorderDetailDataSource: DataSource {
//    
//    var model: RLMRecorder
//    
//    init(model: RLMRecorder) {
//        self.model = model
//        super.init(items: ["金额", "记录时间", "分类", "备注"])
//    }
//    
//    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        let cell = tableView.dequeueReusableCell(withIdentifier: "\(RecordDetailCell.self)") as! RecordDetailCell
//        cell.mainTitleLabel.text = items[indexPath.row] as? String
//        cell.setSubTitleAttributes(indexPath: indexPath, model: model)
//        return cell
//    }
//}



protocol DataProvider: class {
    associatedtype ItemType
    associatedtype AnotherItemType
    
    func numberOfSections() -> Int
    func numberOfItems(in section: Int) -> Int
    func item(at indexPath: IndexPath) -> ItemType
    func identifier(at indexPath: IndexPath) -> String
    
    //    var any: [Any] { get }
    
    func additions() -> AnotherItemType
    
}

protocol ConfigurableCell: class {
    associatedtype ItemType
    func config(item: ItemType)
    
    func configAdditional(at index: IndexPath, model: RLMRecorder)
}

class ConfigurableDataSource<DataProvider>: NSObject {
    let model: DataProvider
    required init(model: DataProvider) {
        self.model = model
    }
}


// ----------------------------------------------------------------------
// MARK: ConfigurableDataSourceTableViewDataSource
// ----------------------------------------------------------------------
class ConfigurableDataSourceTableViewDataSource<Model: DataProvider, Cell: ConfigurableCell>: ConfigurableDataSource<Model>, UITableViewDataSource where Model.ItemType == Cell.ItemType, Cell: UITableViewCell {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return model.numberOfSections()
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return model.numberOfItems(in: section)
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: model.identifier(at: indexPath), for: indexPath) as? Cell else {
            fatalError("Cell should be config")
        }
        cell.config(item: model.item(at: indexPath))
        if let recorder = model.additions() as? RLMRecorder {
            cell.configAdditional(at: indexPath, model: recorder)
        }
        return cell
    }
}



class ConfigurableDataSourceCollectionViewDataSource<Model: DataProvider, Cell: ConfigurableCell>: ConfigurableDataSource<Model>, UICollectionViewDataSource where Model.ItemType == Cell.ItemType, Cell: UICollectionViewCell {
    
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return model.numberOfSections()
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return model.numberOfItems(in: section)
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
//        guard let collectionView.dequeueReusableCell(withReuseIdentifier: model.identifier(at: indexPath), for: indexPath) as? Cell else {
//            return UICollectionViewCell()
//        }
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: model.identifier(at: indexPath), for: indexPath) as! Cell
        cell.config(item: model.item(at: indexPath))
        return cell
        
        
    }
}
