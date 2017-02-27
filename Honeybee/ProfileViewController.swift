//
//  ProfileViewController.swift
//  Honeybee
//
//  Created by Dongbing Hou on 13/02/2017.
//  Copyright © 2017 Dongbing Hou. All rights reserved.
//

import UIKit

class ProfileViewController: BaseViewController {
    
    lazy var tableView = UITableView()
    var dataSource = [SetupItem]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupNav(title: "个人信息")
        addTableView()
        addRightNavItem()
        
        let item1 = SetupItem(title: "昵称", subTitle: "MaryLee")
        let item2 = SetupImageItem(title: "头像", subTitle: "")
        
        dataSource.append(item1)
        dataSource.append(item2)
    }
    
    func addTableView() {
        view.addSubview(tableView)
        tableView.snp.makeConstraints { (make) in
            make.edges.equalTo(view)
        }
        
        tableView.dataSource = self
        tableView.delegate = self
        tableView.separatorStyle = .none
        tableView.showsVerticalScrollIndicator = false
        tableView.showsHorizontalScrollIndicator = false
        
        tableView.rowHeight = HonybeeConstant.rowHeight
        
        tableView.register(SetupCell.self)
        tableView.tableHeaderView = ProfileHeader(height: 135)
    }
    func addRightNavItem() {
        let btn = UIButton(frame: CGRect(x: 0, y: 0, width: 40, height: 25))
        btn.setTitle("分享", for: .normal)
        btn.setTitleColor(HonybeeColor.main, for: .normal)
        btn.titleLabel?.font = HonybeeFont.h5
        btn.addTarget(self, action: #selector(rightBarButtonItemClicked), for: .touchUpInside)
        navigationItem.rightBarButtonItem = UIBarButtonItem(customView: btn)
        
    }
    func rightBarButtonItemClicked() {
        
    }
}


// MARK: UITableViewDataSource
extension ProfileViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataSource.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "\(SetupCell.self)") as! SetupCell
        cell.item = dataSource[indexPath.row]
        return cell
    }
}
