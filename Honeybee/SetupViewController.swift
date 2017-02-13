//
//  SetupViewController.swift
//  Honeybee
//
//  Created by Dongbing Hou on 30/11/2016.
//  Copyright © 2016 Dongbing Hou. All rights reserved.
//

import UIKit

class SetupViewController: UIViewController {
    
    var tableView: UITableView!

    
    
    var dataSource = [SetupItem]()
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.white
        automaticallyAdjustsScrollViewInsets = false
        
        setupNavTitle()
        
        addTableView()
        
        
        let item1 = SetupItem(title: "记账提醒", subTitle: "每天\n10:00")
        let item2 = SetupArrowItem(title: "昵称", subTitle: "二狗哥")
        let item3 = SetupImageItem(title: "头像", subTitle: "")
        
        
        dataSource.append(item1)
        dataSource.append(item2)
        dataSource.append(item3)
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        navigationController?.setNavigationBarHidden(false, animated: true)
    }
    deinit {
        print("deinit --SetupViewController")
    }
}

// MARK: UI
extension SetupViewController {
    
    func setupNavTitle() {
        let titleLabel = UILabel(frame: CGRect(x: 0, y: 0, width: 200, height: 44))
        titleLabel.text = "设置"
        titleLabel.textAlignment = .center
        titleLabel.font = HonybeeFont.h4
        titleLabel.textColor = HonybeeColor.main
        navigationItem.titleView = titleLabel
    }
    
    func addTableView() {
        tableView = UITableView()
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
        
        tableView.tableHeaderView = SetupHeader(height: 135)
        tableView.tableFooterView = SetupFooter(height: 50)
    }
}



// MARK: UITableViewDataSource
extension SetupViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataSource.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "\(SetupCell.self)") as! SetupCell
        cell.item = dataSource[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("----\(indexPath.row)")
        
        navigationController?.pushViewController(ProfileViewController(), animated: true)
    }
}
