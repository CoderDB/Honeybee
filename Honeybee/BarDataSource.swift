//
//  BarDataSource.swift
//  Honeybee
//
//  Created by nvicky on 14/03/2017.
//  Copyright © 2017 Dongbing Hou. All rights reserved.
//

import UIKit

class BarDataSource: NSObject, DataSourceProvider {
    typealias ItemType = RLMRecorder
    var items: [ItemType]
    required init(items: [ItemType]) {
        self.items = items
    }
}


extension BarDataSource: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "\(BarCell.self)") as! BarCell
        cell.item = item(at: indexPath)
        return cell
    }
}
