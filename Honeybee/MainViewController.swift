//
//  MainViewController.swift
//  Honeybee
//
//  Created by Dongbing Hou on 30/11/2016.
//  Copyright © 2016 Dongbing Hou. All rights reserved.
//

import UIKit
import SnapKit
import RealmSwift


class MainViewController: BaseTableViewController {
    
    var dataSource: MainDataSource! {
        didSet {
            tableView.reloadData()
        }
    }
    
    var notiToken: NotificationToken? = nil
    var header: MainHeader!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        automaticallyAdjustsScrollViewInsets = false
        addTableView()
        addTableViewHeader()
        addAddBtn()
        fetchDataFromServe()
        fetchData()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: true)
    }
//    func sameRecorderBeGrouped() {
//        let data = Database.manager.all(RLMRecorder.self)
//        var recorders = [RLMRecorder]()
//        for recorder in data {
//            recorders.append(recorder)
//        }
//        let grouped = group(recorders: recorders)
//        var showing = [ShowRecorder]()
//        for group in grouped {
//            let show = ShowRecorder(recorders: group)
//            showing.append(show)
//        }
//    }
    
    func fetchData() {
        let data = Database.default.all(RLMRecorderSuper.self)
        dataSource = MainDataSource(items: Array(data), vc: self)
        tableView.dataSource = dataSource
        
        notiToken = Database.default.notification({ [unowned self] (_, realm) in
            self.dataSource = MainDataSource(items: Array(realm.objects(RLMRecorderSuper.self)), vc: self)
            self.tableView.dataSource = self.dataSource
            
            self.header.outMoneyLabel.text = self.totalPayText()
        })
    }

    func totalPayText() -> String {
        let month = Date().month
        let recorders = Database.default.all(RLMRecorder.self)
        let matched = Array(recorders.filter { $0.month == month })
        let allPay = matched.reduce(0) { $0.0 + $0.1.money }
        return String(Int(allPay))
    }
    
    
    func fetchDataFromServe() {
        let serveIsChanged = true
        if serveIsChanged {
            HoneybeeKind.fetchAllKinds()
            HoneybeeColor.fetchAllColors()
            HoneybeeIcon.fetchAllIcons()
        }
    }
    deinit {
        notiToken?.stop()
    }
}



// MARK: Popover

extension MainViewController: UIPopoverPresentationControllerDelegate {
    func adaptivePresentationStyle(for controller: UIPresentationController) -> UIModalPresentationStyle {
        return .none
    }
    func popView(btn: UIButton) {
        let destVC = MainPopController()
        destVC.modalPresentationStyle = .popover
        guard let popoverVC = destVC.popoverPresentationController else {
            return
        }
        popoverVC.backgroundColor = .white
        popoverVC.delegate = self
        popoverVC.sourceView = btn
        popoverVC.sourceRect = btn.bounds
        popoverVC.permittedArrowDirections = .up
        present(destVC, animated: true, completion: nil)
        
        destVC.incomeBtnAction = {
            print("income")
            //            let data = Database.manager.allPayout()
            //            print(data)
            //            self.dataSource = MainDataSource(items: data, vc: self)
            
        }
        destVC.expendBtnAction = {
            print("expend")
        }
    }
}



// MARK: UI

extension MainViewController {
    func addTableView() {
        tableView.snp.updateConstraints { (make) in
            make.top.equalTo(view).offset(20)
        }
        tableView.estimatedRowHeight = 75
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.tableFooterView = UIView()
        tableView.register(RecordCell.self)
        tableView.register(GroupCell.self)
    }
    func addTableViewHeader() {
        header = MainHeader(height: 205)
        header.outMoneyLabel.text = totalPayText()
        header.tapContainerViewAction = { [weak self] in
            self?.navigationController?.pushViewController(PieViewController(), animated: true)
        }
        header.usernameAction = { [weak self] in
            self?.navigationController?.pushViewController(SetupViewController(), animated: true)
        }
        header.rightButtonAction = { [weak self] btn in
            self?.popView(btn: btn)
        }
        tableView.tableHeaderView = header
    }
    func addAddBtn() {
        let addBtn = UIButton(type: .custom)
        addBtn.setImage(UIImage(named: "add"), for: .normal)
        addBtn.frame = CGRect(x: (HB.Screen.w - 60) * 0.5, y: HB.Screen.h - 80, width: 60, height: 60)
        addBtn.addTarget(self, action: #selector(addBtnClicked), for: .touchUpInside)
        view.addSubview(addBtn)
    }
    func addBtnClicked() {
        let vc = CardViewController()
        vc.shouldReloadData = { [unowned self] in
            self.fetchData()
        }
        let nav = UINavigationController(rootViewController: vc)
        present(nav, animated: true, completion: nil)
    }
}


// MARK: UITableViewDelegate

extension MainViewController {
//    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        let detailVC = RecordDetailController(model: dataSource.item(at: indexPath).)
//        navigationController?.pushViewController(detailVC, animated: true)
//    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let model = dataSource.item(at: indexPath)
        
        if model.recorders.count == 1 {
            let detailVC = RecordDetailController(model: model.recorders[0])
            navigationController?.pushViewController(detailVC, animated: true)
        }
    }
}


