//
//  AccountBindController.swift
//  Honeybee
//
//  Created by Dongbing Hou on 26/04/2017.
//  Copyright © 2017 Dongbing Hou. All rights reserved.
//

import UIKit

class AccountBindController: BaseTableViewController {

    var dataSource: AccountBindDataSource!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setNavTitle("账号绑定")
        
        addTableView()
        fetchData()
    }
    func fetchData() {
        let item1 = SetupSwitchItem(title: "微信", subTitle: "绑定成功")
        let item2 = SetupSwitchItem(title: "微博", subTitle: "绑定成功")
        let item3 = SetupSwitchItem(title: "QQ", subTitle: "绑定成功")
        
        dataSource = AccountBindDataSource(items: [item1, item2, item3])
        tableView.dataSource = dataSource
    }
    deinit {
        print("deinit --SetupViewController")
    }
    
}

// MARK: UI
extension AccountBindController {
    
    func addTableView() {
        tableView.rowHeight = HB.Constant.rowHeight
        tableView.register(SetupCell.self)
        let header = AccountBindHeader(height: 200)
        tableView.tableHeaderView = header
    }
}
