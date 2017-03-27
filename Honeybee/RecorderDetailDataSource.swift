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
    
    func numberOfSections() -> Int
    func numberOfItems(in section: Int) -> Int
    func item(at indexPath: IndexPath) -> ItemType
    func identifier(at indexPath: IndexPath) -> String
}

class RecorderDetailViewModel: NSObject {
    let titles = ["金额", "记录时间", "分类", "备注"]
    
    var model: RLMRecorder?
    
    init(model: RLMRecorder) {
        self.model = model
    }
}



// ----------------------------------------------------------------------
// MARK: DataProvider
// ----------------------------------------------------------------------

extension RecorderDetailViewModel: DataProvider {
    typealias ItemType = String
    
    func identifier(at indexPath: IndexPath) -> String {
        return "\(RecordDetailCell.self)"
    }
    internal func numberOfSections() -> Int {
        return 1
    }
    func numberOfItems(in section: Int) -> Int {
        return titles.count
    }
    func item(at indexPath: IndexPath) -> String {
        return titles[indexPath.row]
    }
}



// ----------------------------------------------------------------------
// MARK: UITableViewDataSource
// ----------------------------------------------------------------------

extension RecorderDetailViewModel: UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return titles.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: identifier(at: indexPath), for: indexPath) as! RecordDetailCell
        cell.config(item: titles[indexPath.row])
//        if (model != nil) {
            cell.setSubTitleAttributes(indexPath: indexPath, model: model!)
//        }
        return cell
    }
}




class ConfigurableDataSource<Model: DataProvider>: NSObject {
    let model: Model
    required init(model: Model) {
        self.model = model
    }
}

protocol ConfigurableCell: class {
    associatedtype ItemType
    func config(item: ItemType)
}

class TVDataSource<Model: DataProvider, Cell: ConfigurableCell>: ConfigurableDataSource<Model>, UITableViewDataSource where Model.ItemType == Cell.ItemType, Cell: UITableViewCell {
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
        return cell
    }
}








