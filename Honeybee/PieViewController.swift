
//
//  PieViewController.swift
//  Honeybee
//
//  Created by Dongbing Hou on 26/12/2016.
//  Copyright © 2016 Dongbing Hou. All rights reserved.
//

import UIKit

class PieViewController: BaseTableViewController {

    
    var dataSource = [SetupItem]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setNavTitle("图表")
        
        tableView.register(PieCell.self)
        tableView.tableHeaderView = PieHeader(height: 250)
        
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


// MARK: UITableViewDataSource
extension PieViewController {
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataSource.count
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "\(PieCell.self)") as! PieCell
        cell.item = dataSource[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let barVC = BarViewController()
        barVC.setNavTitle(dataSource[indexPath.row].title)
        navigationController?.pushViewController(barVC, animated: true)
    }
}
