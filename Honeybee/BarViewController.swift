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
        
        setupNav(title: "衣")
        
        addTableView()
        
        let item1 = SetupArrowItem(title: "衣", subTitle: "10%")
        let item2 = SetupArrowItem(title: "食", subTitle: "30%")
        let item3 = SetupArrowItem(title: "住", subTitle: "30%")
        let item4 = SetupArrowItem(title: "行", subTitle: "30%")
        dataSource.append(item1)
        dataSource.append(item2)
        dataSource.append(item3)
        dataSource.append(item4)
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(false, animated: true)
    }
}

// MARK: UI
extension BarViewController {
    func addTableView() {
        tableView.delegate = self
        
        tableView.rowHeight = 60
        tableView.register(PieCell.self, forCellReuseIdentifier: "\(PieCell.self)")
    }
}


// MARK: UITableViewDataSource
extension BarViewController: UITableViewDelegate {
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataSource.count
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "\(PieCell.self)") as! PieCell
        cell.item = dataSource[indexPath.row]
        return cell
    }
}
