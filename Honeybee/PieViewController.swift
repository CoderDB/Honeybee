
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
        var kinds = [String]()
        for recorder in matched {
            kinds.append(recorder.superCategory)
        }
//        let kinds = matched.map { $0.superCategory }
        
        let groupedKinds = group(source: kinds)
        print(groupedKinds)
        
        var items = [SetupArrowItem]()
        for groupedKind in groupedKinds {
            if let name = groupedKind.first {
                let item = SetupArrowItem(title: name, subTitle: "10%")
                items.append(item)
            }
        }
        
        
        dataSource = PieDataSource(items: items)
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
