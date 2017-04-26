//
//  AccountBindController.swift
//  Honeybee
//
//  Created by Dongbing Hou on 26/04/2017.
//  Copyright © 2017 Dongbing Hou. All rights reserved.
//

import UIKit

class AccountBindController: BaseTableViewController {

    var dataSource: SetupDataSource!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setNavTitle("账号绑定")
        
        addTableView()
        fetchData()
    }
    func fetchData() {
        let item1 = SetupSwitchItem(title: "记账提醒", subTitle: "每天\n10:00")
        //        let item2 = SetupArrowItem(title: "昵称", subTitle: "二狗哥")
        let item3 = SetupImageItem(title: "背景", subTitle: "", img: "")
        
        let item4 = SetupArrowItem(title: "绑定账号", subTitle: "")
        let item5 = SetupArrowItem(title: "手势密码", subTitle: "")
        let item6 = SetupImageItem(title: "指纹解锁", subTitle: "", img: "touchid")
        dataSource = SetupDataSource(items: [item1, item3, item4, item5, item6])
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
