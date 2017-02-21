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

    var cardVC: CardViewController!
    var customPresentationController: HBPresentationController!
    
    let tableView = UITableView(frame: .zero, style: .grouped)
    
    lazy var destVC: UIViewController = {
        let vc = UIViewController()
        vc.modalPresentationStyle = .popover
        vc.preferredContentSize = CGSize(width: 70, height: 60)
        vc.view.backgroundColor = UIColor.white
        return vc
    }()
    lazy var topBtn: UIButton = {
        let btn = UIButton(frame: CGRect(x: 0, y: 0, width: 70, height: 30))
        btn.setTitle("仅支出", for: .normal)
        btn.setTitleColor(HonybeeColor.main, for: .normal)
        btn.titleLabel?.font = HonybeeFont.h5
        return btn
    }()
    lazy var botBtn: UIButton = {
        let btn = UIButton(frame: CGRect(x: 0, y: 30, width: 70, height: 30))
        btn.setTitle("仅收入", for: .normal)
        btn.setTitleColor(HonybeeColor.main, for: .normal)
        btn.titleLabel?.font = HonybeeFont.h5
        return btn
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.white
        automaticallyAdjustsScrollViewInsets = false
        
        cardVC = CardViewController()
        customPresentationController = HBPresentationController(presentedViewController: cardVC, presenting: self)
        cardVC.transitioningDelegate = customPresentationController

        addTableView()
        addAddBtn()
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: true)
    }
}

// MARK: UIPopoverPresentationControllerDelegate
extension MainViewController: UIPopoverPresentationControllerDelegate {
    func adaptivePresentationStyle(for controller: UIPresentationController) -> UIModalPresentationStyle {
        return .none
    }
}
// MARK: Popover
extension MainViewController {
    func popView(btn: UIButton) {
        guard let popoverVC = destVC.popoverPresentationController else {
            return
        }
        destVC.view.addSubview(topBtn)
        destVC.view.addSubview(botBtn)
        topBtn.addTarget(self, action: #selector(topBtnClicked), for: .touchUpInside)
        botBtn.addTarget(self, action: #selector(botBtnClicked), for: .touchUpInside)
        popoverVC.backgroundColor = UIColor.white
        popoverVC.delegate = self
        popoverVC.sourceView = btn
        popoverVC.sourceRect = btn.bounds
        popoverVC.permittedArrowDirections = .up
        present(destVC, animated: true, completion: nil)
    }
    func topBtnClicked() {
        print("___top____")
    }
    func botBtnClicked() {
        print("___bot____")
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
        header.tapContainerViewAction = { [unowned self] in
            self.navigationController?.pushViewController(PieViewController(), animated: true)
        }
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

