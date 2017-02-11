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
    

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.white
        navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .any, barMetrics: .default)
        navigationController?.navigationBar.shadowImage = UIImage() //只有设为default黑线才能去除
        // 设置导航栏返回按钮，返回文字颜色
        navigationController?.navigationBar.tintColor = HonybeeColor.mainColor
        
        // 设置 UIBarButtonItem 字体颜色
//        UIBarButtonItem.appearance().setTitleTextAttributes([NSForegroundColorAttributeName: UIColor.green], for: UIControlState.normal)
        
        // 隐藏返回按钮文字
        let buttonItem = UIBarButtonItem.appearance(whenContainedInInstancesOf: [UINavigationBar.self])
        buttonItem.setBackButtonTitlePositionAdjustment(UIOffset(horizontal: -100, vertical: -100), for: .default)
        
        
        setupNavTitle()
        
//        addRoundRect()
        addTableView()
    }
    
    func setupNavTitle() {
        let titleLabel = UILabel(frame: CGRect(x: 0, y: 0, width: 200, height: 44))
        titleLabel.text = "详情"
        titleLabel.textAlignment = .center
        titleLabel.font = HonybeeFont.subTitleFont
        titleLabel.textColor = HonybeeColor.mainColor
        navigationItem.titleView = titleLabel
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        navigationController?.setNavigationBarHidden(false, animated: true)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func addTableView() {
        tableView.dataSource = self
        tableView.delegate = self
        view.addSubview(tableView)
        tableView.separatorStyle = .none
        
        tableView.estimatedRowHeight = 70
        tableView.rowHeight = UITableViewAutomaticDimension
        
        tableView.register(RecordDetailCell.self, forCellReuseIdentifier: "RecordDetailCell")
        tableView.snp.makeConstraints { (make) in
            make.edges.equalTo(view)
        }
    }
    
    func addRoundRect() {
        let roundView = UIView(frame: CGRect(x: 10, y: 74, width: 300, height: 100))
        roundView.layer.cornerRadius = 10
        roundView.backgroundColor = UIColor.cyan
        view.addSubview(roundView)
    }
}



extension RecordDetailController: UITableViewDataSource, UITableViewDelegate {

    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 20
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return tableView.dequeueReusableCell(withIdentifier: "RecordDetailCell") as! RecordDetailCell
    }
}
