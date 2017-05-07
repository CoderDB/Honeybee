//
//  RecorderDetailViewModel.swift
//  Honeybee
//
//  Created by Dongbing Hou on 07/05/2017.
//  Copyright © 2017 Dongbing Hou. All rights reserved.
//

import UIKit


class RecorderDetailViewModel: NSObject {
    let titles = ["金额", "记录时间", "分类", "备注"]
    
    let model: RLMRecorder
    
    init(model: RLMRecorder) {
        self.model = model
    }
}


// ----------------------------------------------------------------------
// MARK: DataProvider
// ----------------------------------------------------------------------
extension RecorderDetailViewModel: DataProvider {
    
    typealias ItemType = String
    
    typealias AnotherItemType = RLMRecorder
    internal func additions() -> RLMRecorder {
        return model
    }
    
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
        cell.configAdditional(at: indexPath, model: model)
        return cell
    }
}

