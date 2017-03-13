//
//  SetupViewController.swift
//  Honeybee
//
//  Created by Dongbing Hou on 30/11/2016.
//  Copyright © 2016 Dongbing Hou. All rights reserved.
//

import UIKit

class SetupViewController: BaseTableViewController {
    
    var dataSource: SetupDataSource!
    override func viewDidLoad() {
        super.viewDidLoad()
        setNavTitle("设置")
        
        addTableView()
        
        let item1 = SetupItem(title: "记账提醒", subTitle: "每天\n10:00")
        let item2 = SetupArrowItem(title: "昵称", subTitle: "二狗哥")
        let item3 = SetupImageItem(title: "头像", subTitle: "")
        dataSource = SetupDataSource(items: [item1, item2, item3])
        tableView.dataSource = dataSource
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(false, animated: true)
    }
    deinit {
        print("deinit --SetupViewController")
    }
}

// MARK: UI
extension SetupViewController {
    
    func addTableView() {
        tableView.rowHeight = HB.Constant.rowHeight
        tableView.register(SetupCell.self)
        tableView.tableHeaderView = SetupHeader(height: 135)
        tableView.tableFooterView = SetupFooter(height: 50)
    }
}

// MARK: UITableViewDataSource
extension SetupViewController {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("----\(indexPath.row)")
        
        navigationController?.pushViewController(ProfileViewController(), animated: true)
    }
}
