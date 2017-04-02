//
//  MainDataSource.swift
//  Honeybee
//
//  Created by nvicky on 14/03/2017.
//  Copyright © 2017 Dongbing Hou. All rights reserved.
//

import UIKit
import RealmSwift

class MainDataSource: NSObject {
    
    var items: [RLMRecorderSuper]
    fileprivate var vc: UIViewController
    init(items: [RLMRecorderSuper], vc: UIViewController) {
        self.items = items
        self.vc = vc
    }
    func item(at indexPath: IndexPath) -> RLMRecorderSuper {
        return items[indexPath.row]
    }
}


extension MainDataSource: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let model = items[indexPath.row]
        if model.recorders.count > 1 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "\(GroupCell.self)") as! GroupCell
            cell.delegate = self
            cell.dataSource = item(at: indexPath).recorders
            tableView.rowHeight = CGFloat(cell.tvHeight + 33 + 24)
            return cell
        } else {
            tableView.estimatedRowHeight = 75
            tableView.rowHeight = UITableViewAutomaticDimension
            let cell = tableView.dequeueReusableCell(withIdentifier: "\(RecordCell.self)") as! RecordCell
            cell.recorder = model.recorders[0]
            return cell
        }
    }
}

extension MainDataSource: GroupCellDelegate {
    func didSelected(model: RLMRecorder) {
        let detailVC = RecordDetailController(model: model)
        vc.navigationController?.pushViewController(detailVC, animated: true)
    }
}
