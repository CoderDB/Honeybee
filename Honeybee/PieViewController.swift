
//
//  PieViewController.swift
//  Honeybee
//
//  Created by Dongbing Hou on 26/12/2016.
//  Copyright © 2016 Dongbing Hou. All rights reserved.
//

import UIKit

class PieViewController: BaseViewController {

    
    
    var dataSource = [SetupItem]()
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupNav(title: "图表")
        
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
extension PieViewController {
    func addTableView() {
        let tableView = UITableView()
        view.addSubview(tableView)
        tableView.snp.makeConstraints { (make) in
            make.top.equalTo(view).offset(64)
            make.left.right.bottom.equalTo(view)
        }
        
        tableView.dataSource = self
        tableView.delegate = self
        tableView.separatorStyle = .none
        tableView.showsVerticalScrollIndicator = false
        tableView.showsHorizontalScrollIndicator = false
        
        tableView.rowHeight = 60
        
        tableView.register(PieCell.self, forCellReuseIdentifier: "\(PieCell.self)")
        
        tableView.tableHeaderView = PieHeader(height: 250)
    }
}


// MARK: UITableViewDataSource
extension PieViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataSource.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "\(PieCell.self)") as! PieCell
        cell.item = dataSource[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        navigationController?.pushViewController(BarViewController(), animated: true)
    }
}
