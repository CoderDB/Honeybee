//
//  RecordDetailController.swift
//  Honeybee
//
//  Created by Dongbing Hou on 11/02/2017.
//  Copyright © 2017 Dongbing Hou. All rights reserved.
//

import UIKit

class RecordDetailController: BaseViewController {
    
    
    lazy var tableView = UITableView()
    var model: Recorder!
    let cellTitles = ["金额", "记录时间", "分类", "备注"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNav(title: "详情")
        addTableView()
        model = Recorder(date: "", category: ["金额"], money: "180.50", remark: "请朋友吃饭。日式拉面，泰式鸡丁+油菜花，麻辣香锅炒面，香喷喷大米饭。\n", color: "green")
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(false, animated: true)
    }
    
    func addTableView() {
        tableView.dataSource = self
        tableView.delegate = self
        view.addSubview(tableView)
        
        tableView.estimatedRowHeight = 60
        tableView.rowHeight = UITableViewAutomaticDimension
//        tableView.rowHeight = 60
        
        tableView.showsHorizontalScrollIndicator = false
        tableView.showsVerticalScrollIndicator = false
        tableView.separatorStyle = .none
        
        tableView.snp.makeConstraints { (make) in
            make.edges.equalTo(view)
        }
        let header = RecordDetailHeader(height: 115, title: "吃饭", imageName: "meal")
        tableView.tableHeaderView = header // 这样设置的 header 宽度一定是tableview 的宽度
        tableView.tableFooterView = RecordDetailFooter(height: 50)
        
        tableView.register(RecordDetailCell.self, forCellReuseIdentifier: "\(RecordDetailCell.self)")
    }
}


// MARK: UITableViewDataSource
extension RecordDetailController: UITableViewDataSource, UITableViewDelegate {

    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cellTitles.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "\(RecordDetailCell.self)") as! RecordDetailCell
        cell.mainTitleLabel.text = cellTitles[indexPath.row]
        setSubTitleAttributes(cell: cell, indexPath: indexPath, model: model)
        return cell
    }
    
    func setSubTitleAttributes(cell: RecordDetailCell, indexPath: IndexPath, model: Recorder) {
        if indexPath.row == 0 {
            cell.subTitleLabel.attributedText = NSAttributedString(string: model.money, attributes: [NSFontAttributeName: HonybeeFont.h3_number])
        } else if indexPath.row == 1 {
            cell.subTitleLabel.attributedText = NSAttributedString(string: "2017-02-13" + "\n" + "15:11" + "\n", attributes: [NSFontAttributeName: HonybeeFont.h4_number])
        } else if indexPath.row == 2 {
            cell.subTitleLabel.attributedText = NSAttributedString(string: "支出" + ">" + "食" + ">" + "吃饭" + "\n", attributes: [NSFontAttributeName: HonybeeFont.h5])
        } else {
            cell.subTitleLabel.text = model.remark
        }
    }
    
}
