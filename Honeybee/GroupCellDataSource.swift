//
//  GroupCellDataSource.swift
//  Honeybee
//
//  Created by nvicky on 14/03/2017.
//  Copyright © 2017 Dongbing Hou. All rights reserved.
//

import UIKit

class GroupCellDataSource: NSObject, DataSourceProvider {
    
    typealias ItemType = RLMRecorder
    var items: [RLMRecorder]
    required init(items: [ItemType]) {
        self.items = items
    }
   
//    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        let cell = tableView.dequeueReusableCell(withIdentifier: "\(RecordLiteCell.self)") as! RecordLiteCell
//        let model = items[indexPath.row] as! RLMRecorder
//        cell.model = model
//        
////        dateLabel.text = model?.monthDay
////        weekdayLabel.text = model?.weekday
//        return cell
//    }
}

extension GroupCellDataSource: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "\(RecordLiteCell.self)") as! RecordLiteCell
        cell.model = item(at: indexPath)
        return cell
    }
}
