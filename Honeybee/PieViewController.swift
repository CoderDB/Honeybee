
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
        
        let item1 = SetupItem(title: "记账提醒", subTitle: "每天\n10:00")
        let item2 = SetupArrowItem(title: "昵称", subTitle: "二狗哥")
        let item3 = SetupImageItem(title: "头像", subTitle: "")
        dataSource.append(item1)
        dataSource.append(item2)
        dataSource.append(item3)
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
        
        tableView.register(SetupCell.self, forCellReuseIdentifier: "\(SetupCell.self)")
        
        tableView.tableHeaderView = PieHeader(height: 250)
    }
}


// MARK: UITableViewDataSource
extension PieViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataSource.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "\(SetupCell.self)") as! SetupCell
        cell.item = dataSource[indexPath.row]
        return cell
    }
}
