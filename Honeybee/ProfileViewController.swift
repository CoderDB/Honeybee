//
//  ProfileViewController.swift
//  Honeybee
//
//  Created by Dongbing Hou on 13/02/2017.
//  Copyright © 2017 Dongbing Hou. All rights reserved.
//

import UIKit

class ProfileViewController: BaseTableViewController {
    
    var dataSource = [SetupItem]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setNavTitle("个人信息")
        setNavRightItem("分享")
        addTableView()
        
        let item1 = SetupItem(title: "昵称", subTitle: "MaryLee")
        let item2 = SetupImageItem(title: "头像", subTitle: "")
        
        dataSource.append(item1)
        dataSource.append(item2)
    }
    func addTableView() {
        tableView.rowHeight = HB.Constant.rowHeight
        tableView.register(SetupCell.self)
        tableView.tableHeaderView = ProfileHeader(height: 135)
    }
    
    override func navRightItemClicked() {
        
    }
    
}


// MARK: UITableViewDataSource
extension ProfileViewController {
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataSource.count
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "\(SetupCell.self)") as! SetupCell
        cell.item = dataSource[indexPath.row]
        return cell
    }
}
