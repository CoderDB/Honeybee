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
    
    let tableView = UITableView(frame: .zero, style: .grouped)
    
    var dest: UIViewController? = nil
    
    lazy var topBtn: UIButton = {
        let btn = UIButton()
        btn.setTitle("仅支出", for: .normal)
        btn.setTitleColor(HonybeeColor.main, for: .normal)
        btn.titleLabel?.font = HonybeeFont.h5
        return btn
    }()
    lazy var botBtn: UIButton = {
        let btn = UIButton()
        btn.setTitle("仅收入", for: .normal)
        btn.setTitleColor(HonybeeColor.main, for: .normal)
        btn.titleLabel?.font = HonybeeFont.h5
        return btn
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.white
        automaticallyAdjustsScrollViewInsets = false
        
        cardVC.transitioningDelegate = customPresentationController

    
        let destVC = UIViewController()
        topBtn.frame = CGRect(x: 0, y: 0, width: 70, height: 30)
        botBtn.frame = CGRect(x: 0, y: 30, width: 70, height: 30)
        topBtn.addTarget(self, action: #selector(topBtnClicked), for: .touchUpInside)
        destVC.view.addSubview(topBtn)
        destVC.view.addSubview(botBtn)
        destVC.view.backgroundColor = UIColor.white
        destVC.modalPresentationStyle = .popover
        destVC.preferredContentSize = CGSize(width: 70, height: 60)
        
        dest = destVC
        
        addTableView()
        addAddBtn()
    }
    func topBtnClicked() {
        print("___+++++____")
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: true)
    }
    
    func popView(btn: UIButton) {
        guard let popoverVC = dest!.popoverPresentationController else {
            return
        }
        popoverVC.backgroundColor = UIColor.white
        popoverVC.delegate = self
        popoverVC.sourceView = btn
        popoverVC.sourceRect = btn.bounds
        popoverVC.permittedArrowDirections = .up
        
        present(dest!, animated: true, completion: nil)
    }
}

extension MainViewController: UIPopoverPresentationControllerDelegate {
    func adaptivePresentationStyle(for controller: UIPresentationController) -> UIModalPresentationStyle {
        return .none
    }
}


// MARK: UI
extension MainViewController {
    
    func addTableView() {
        tableView.backgroundColor = UIColor.white
        view.addSubview(tableView)
        tableView.snp.makeConstraints { (make) in
            make.top.equalTo(view).offset(20)
            make.left.right.bottom.equalTo(view)
        }
        tableView.dataSource = self
        tableView.delegate = self
        tableView.separatorStyle = .none
        tableView.estimatedRowHeight = 75
        tableView.rowHeight = UITableViewAutomaticDimension
        
        let header = HeaderView()
        header.usernameAction = { [unowned self] in
            self.navigationController?.pushViewController(SetupViewController(), animated: true)
        }
        header.filterAction = { [unowned self] btn in
            self.popView(btn: btn)
        }
        tableView.tableHeaderView = header
        tableView.tableFooterView = UIView()
        
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


// MARK: UI Event
extension MainViewController {
    func addBtnClicked() {
        present(cardVC, animated: true, completion: nil)
    }
}


// MARK: UITableViewDatasource
extension MainViewController: UITableViewDataSource, UITableViewDelegate {
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
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        navigationController?.pushViewController(RecordDetailController(), animated: true)
    }
}

