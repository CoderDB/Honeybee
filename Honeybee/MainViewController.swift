//
//  MainViewController.swift
//  Honeybee
//
//  Created by Dongbing Hou on 30/11/2016.
//  Copyright © 2016 Dongbing Hou. All rights reserved.
//

import UIKit
import SnapKit

let ScreenW = UIScreen.main.bounds.width
let ScreenH = UIScreen.main.bounds.height


class MainViewController: UIViewController {

    lazy var cardVC: CardViewController = CardViewController()
    lazy var customPresentationController: HBPresentationController = HBPresentationController(presentedViewController: self.cardVC, presenting: self)
    
    let tableView = UITableView(frame: CGRect.zero, style: .grouped)
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.white
        
        cardVC.transitioningDelegate = customPresentationController

        addTableView()

        addAddBtn()
        
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        navigationController?.setNavigationBarHidden(true, animated: false)
    }
}


// MARK: UI

extension MainViewController {
    
    func addTableView() {
        tableView.backgroundColor = UIColor.white
        tableView.dataSource = self
        tableView.delegate = self
        view.addSubview(tableView)
        tableView.tableHeaderView = HeaderView()
        tableView.tableFooterView = UIView()
        tableView.snp.makeConstraints { (make) in
            make.top.equalTo(view).offset(20)
            make.left.right.bottom.equalTo(view)
        }
        
//        tableView.rowHeight = 75
        tableView.estimatedRowHeight = 75
        tableView.register(UINib(nibName: "RecordCell", bundle: nil), forCellReuseIdentifier: "RecordCell")
        tableView.register(UINib(nibName: "SectionCell", bundle: nil), forCellReuseIdentifier: "SectionCell")
        
    }
    
    func addAddBtn() {
        let addBtn = UIButton(type: .custom)
        addBtn.setImage(UIImage(named: "add"), for: .normal)
        addBtn.frame = CGRect(x: (ScreenW - 60) * 0.5, y: ScreenH - 80, width: 60, height: 60)
        addBtn.addTarget(self, action: #selector(addBtnClicked), for: .touchUpInside)
        view.addSubview(addBtn)
    }
}

extension MainViewController: UITableViewDataSource, UITableViewDelegate {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 3
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return 2
        } else if section == 1 {
            return 4
        } else {
            return 3
        }
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 1 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "SectionCell") as! SectionCell
            return cell
            
        }
        let cell = tableView.dequeueReusableCell(withIdentifier: "RecordCell") as! RecordCell
        cell.dateLabel.text = "今天"
        cell.categoryLabel.text = "吃饭"
        cell.costLabel.text = "108.95"
        return cell
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        
        return "Test"
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return indexPath.section == 1 ? 300 : 75
    }
    
}


// MARK: UI Event

extension MainViewController {
    func addBtnClicked() {
        present(cardVC, animated: true, completion: nil)
    }
}
