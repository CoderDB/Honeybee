//
//  ProfileViewController.swift
//  Honeybee
//
//  Created by Dongbing Hou on 13/02/2017.
//  Copyright © 2017 Dongbing Hou. All rights reserved.
//

import UIKit

class ProfileViewController: BaseTableViewController {
    
    var dataSource: ProfileDataSource!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setNavTitle("个人信息")
//        setNavRightItem("分享")
        addTableView()
        fetchData()
    }
    func fetchData() {
        let item1 = SetupItem(title: "昵称", subTitle: "MaryLee")
        let item2 = SetupImageItem(title: "头像", subTitle: "", img: "")
        
        dataSource = ProfileDataSource(items: [item1, item2])
        tableView.dataSource = dataSource
    }
    func addTableView() {
        tableView.rowHeight = HB.Constant.rowHeight
        tableView.register(SetupCell.self)
        let header = ProfileHeader(height: 135)
        header.rightButtonAction = { [weak self] _ in
            self?.presentShareView()
        }
        tableView.tableHeaderView = header
    }
    
    func presentShareView() {
        
    }
}
