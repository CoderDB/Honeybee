
//
//  PieViewController.swift
//  Honeybee
//
//  Created by Dongbing Hou on 26/12/2016.
//  Copyright © 2016 Dongbing Hou. All rights reserved.
//

import UIKit

class PieViewController: BaseTableViewController {

    var dataSource: PieDataSource!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setNavTitle("图表")
        
        tableView.register(PieCell.self)
        tableView.tableHeaderView = PieHeader(height: 250)
        
        fetchData()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(false, animated: true)
    }
    func fetchData() {
        
        let currentYear = Date().year
        let currentMonth = Date().month
        
        let recorders = DatabaseManager.manager.all(RLMRecorder.self)
        let matched = recorders
            .filter { $0.year == currentYear }
            .filter { $0.month == currentMonth }
        print(matched)
        for recorder in matched {
            print(recorder.superCategory)
        }
        
        
        
        
        let item1 = SetupArrowItem(title: "衣", subTitle: "10%")
        let item2 = SetupArrowItem(title: "食", subTitle: "30%")
        let item3 = SetupArrowItem(title: "住", subTitle: "30%")
        let item4 = SetupArrowItem(title: "行", subTitle: "30%")
        
        dataSource = PieDataSource(items: [item1, item2, item3, item4])
        tableView.dataSource = dataSource
    }
}


// MARK: UITableViewDelegate

extension PieViewController {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let item = dataSource.item(at: indexPath) as? SetupItem {
            let barVC = BarViewController()
            barVC.setNavTitle(item.title)
            navigationController?.pushViewController(barVC, animated: true)
        }
    }
}
