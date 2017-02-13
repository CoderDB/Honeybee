//
//  RecordDetailController.swift
//  Honeybee
//
//  Created by Dongbing Hou on 11/02/2017.
//  Copyright © 2017 Dongbing Hou. All rights reserved.
//

import UIKit

class RecordDetailController: UIViewController {
    
    
    
    lazy var tableView = UITableView()
    
    
    var model: Reocder!
    
    let cellTitles = ["金额", "记录时间", "分类", "备注"]
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.white
        
        navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .any, barMetrics: .default)
        navigationController?.navigationBar.shadowImage = UIImage() //只有设为default黑线才能去除
        // 设置导航栏返回按钮，返回文字颜色
        navigationController?.navigationBar.tintColor = HonybeeColor.main
        
        // 设置 UIBarButtonItem 字体颜色
//        UIBarButtonItem.appearance().setTitleTextAttributes([NSForegroundColorAttributeName: UIColor.green], for: UIControlState.normal)
        
        // 隐藏返回按钮文字
        let buttonItem = UIBarButtonItem.appearance(whenContainedInInstancesOf: [UINavigationBar.self])
        buttonItem.setBackButtonTitlePositionAdjustment(UIOffset(horizontal: -100, vertical: -100), for: .default)
        
        automaticallyAdjustsScrollViewInsets = false // 默认 true (0, 0)点从导航栏下开始， false： (0, 0)就是屏幕左上角
        
        setupNavTitle()
        
        addTableView()
        model = Reocder(date: "", category: "金额", money: "180.50", remark: "请朋友吃饭。日式拉面，泰式鸡丁+油菜花，麻辣香锅炒面，香喷喷大米饭。\n")
        
        
        
    }
    
    func setupNavTitle() {
        let titleLabel = UILabel(frame: CGRect(x: 0, y: 0, width: 200, height: 44))
        titleLabel.text = "详情"
        titleLabel.textAlignment = .center
        titleLabel.font = HonybeeFont.h3
        titleLabel.textColor = HonybeeColor.main
        navigationItem.titleView = titleLabel
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        navigationController?.setNavigationBarHidden(false, animated: true)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
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
        
        
        tableView.register(RecordDetailCell.self, forCellReuseIdentifier: "\(RecordDetailCell.self)")
        
        tableView.snp.makeConstraints { (make) in
            make.top.equalTo(view).offset(64) // 导航栏本是透明的，假装导航栏是白色
            make.left.right.bottom.equalTo(view)
        }
        let header = RecordDetailHeader(height: 115, title: "吃饭", imageName: "meal")
        tableView.tableHeaderView = header // 这样设置的 header 宽度一定是tableview 的宽度
        
        tableView.tableFooterView = RecordDetailFooter(height: 50)
        
    }
}



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
    
    func setSubTitleAttributes(cell: RecordDetailCell, indexPath: IndexPath, model: Reocder) {
        if indexPath.row == 0 {
            cell.subTitleLabel.attributedText = NSAttributedString(string: model.money, attributes: [NSFontAttributeName: HonybeeFont.h1_number!])
        } else if indexPath.row == 1 {
            cell.subTitleLabel.attributedText = NSAttributedString(string: "2017-02-13" + "\n" + "15:11" + "\n", attributes: [NSFontAttributeName: HonybeeFont.h2_number!])
        } else if indexPath.row == 2 {
            cell.subTitleLabel.attributedText = NSAttributedString(string: "支出" + ">" + "食" + ">" + "吃饭" + "\n", attributes: [NSFontAttributeName: HonybeeFont.h3])
        } else {
            cell.subTitleLabel.text = model.remark
        }
    }
    
}
