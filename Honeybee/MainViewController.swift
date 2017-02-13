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
    
    lazy var profileVC: SetupViewController = SetupViewController()
    lazy var customPC: HBPresentationController = HBPresentationController(presentedViewController: self.profileVC, presenting: self)
    
    let tableView = UITableView(frame: CGRect.zero, style: .grouped)
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.white
        
        cardVC.transitioningDelegate = customPresentationController
        profileVC.transitioningDelegate = customPC

        addTableView()

        addAddBtn()
        
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        navigationController?.setNavigationBarHidden(true, animated: true)
    }
}


// MARK: UI

extension MainViewController {
    
    func addTableView() {
        tableView.backgroundColor = UIColor.white
        tableView.dataSource = self
        tableView.delegate = self
        view.addSubview(tableView)
        let header = HeaderView()
        header.usernameAction = { [unowned self] in
            print("********")
            self.navigationController?.pushViewController(SetupViewController(), animated: true)
        }
        
        tableView.tableHeaderView = header
        tableView.tableFooterView = UIView()
        tableView.snp.makeConstraints { (make) in
            make.top.equalTo(view).offset(20)
            make.left.right.bottom.equalTo(view)
        }
        tableView.separatorStyle = .none
        tableView.estimatedRowHeight = 75
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.register(RecordCell.self, forCellReuseIdentifier: "RecordCell")
        tableView.register(SectionCell.self, forCellReuseIdentifier: "SectionCell")
        tableView.register(RecordLiteCell.self, forCellReuseIdentifier: "RecordLiteCell")
        
    }
    
    func addAddBtn() {
        let addBtn = UIButton(type: .custom)
        addBtn.setImage(UIImage(named: "add"), for: .normal)
        addBtn.frame = CGRect(x: (ScreenW - 60) * 0.5, y: ScreenH - 80, width: 60, height: 60)
        addBtn.addTarget(self, action: #selector(addBtnClicked), for: .touchUpInside)
        view.addSubview(addBtn)
    }
}

extension MainViewController: UITableViewDataSource{
    func numberOfSections(in tableView: UITableView) -> Int {
        return 3
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return 20
        } else if section == 1 {
            return 40
        } else {
            return 30
        }
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 1 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "SectionCell") as! SectionCell
            return cell
        }
        let cell = tableView.dequeueReusableCell(withIdentifier: "RecordCell") as! RecordCell

        cell.dateLabel.text = "2月13日"
        cell.categoryLabel.text = "吃饭"
        cell.numberLabel.text = "108.95"
        return cell
    }
}

extension MainViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        navigationController?.pushViewController(RecordDetailController(), animated: true)
    }
}


// MARK: UI Event

extension MainViewController {
    func addBtnClicked() {
        present(cardVC, animated: true, completion: nil)
    }
}
