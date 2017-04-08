
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
    var header: PieHeader!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setNavTitle("图表")
        
        tableView.register(PieCell.self)
        header = PieHeader(height: 250)
        tableView.tableHeaderView = header
        
        fetchData()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(false, animated: true)
    }
    
    func fetchData() {
        PieDataSource(items: []).fetch { [weak self] (items, ncp) in
            self?.dataSource = PieDataSource(items: items)
            self?.tableView.dataSource = self?.dataSource
            self?.tableView.tableHeaderView = PieHeader(height: 250, names: ncp.0, colors: ncp.1, percents: ncp.2)
        }
    }
}


// MARK: UITableViewDelegate

extension PieViewController {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {

        let barVC = BarViewController()
        barVC.category = dataSource.item(at: indexPath).category
        barVC.setNavTitle(dataSource.item(at: indexPath).category.name)
        navigationController?.pushViewController(barVC, animated: true)
    }
}
