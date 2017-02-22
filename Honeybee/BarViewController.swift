//
//  BarViewController.swift
//  Honeybee
//
//  Created by Dongbing Hou on 22/02/2017.
//  Copyright © 2017 Dongbing Hou. All rights reserved.
//

import UIKit

class BarViewController: BaseTableViewController {
    
    var dataSource = [SetupItem]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let item1 = SetupArrowItem(title: "衣", subTitle: "-28510")
        let item2 = SetupArrowItem(title: "食", subTitle: "-30")
        let item3 = SetupArrowItem(title: "住", subTitle: "-1096.56")
        let item4 = SetupArrowItem(title: "行", subTitle: "-7782.30")
        dataSource.append(item1)
        dataSource.append(item2)
        dataSource.append(item3)
        dataSource.append(item4)
        
        tableView.register(BarCell.self, forCellReuseIdentifier: "\(BarCell.self)")
        tableView.tableHeaderView = BarHeader(height: 170)
    }
}


// MARK: UITableViewDataSource
extension BarViewController {
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataSource.count
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "\(BarCell.self)") as! BarCell
        cell.item = dataSource[indexPath.row]
        return cell
    }
}
