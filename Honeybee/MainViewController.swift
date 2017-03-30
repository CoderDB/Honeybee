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
//        let data = DatabaseManager.manager.all(RLMRecorder.self)
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
        let data = DatabaseManager.manager.all(RLMRecorderSuper.self)
        dataSource = MainDataSource(items: data, vc: self)
        tableView.dataSource = dataSource
        
//        notiToken = DatabaseManager.manager.notification({ [unowned self] (_, realm) in
//            self.dataSource = MainDataSource(items: realm.objects(RLMRecorderSuper.self), vc: self)
//            self.tableView.dataSource = self.dataSource
//        })
    }
    deinit {
        notiToken?.stop()
    }
    func fetchDataFromServe() {
        let serveIsChanged = false
        if serveIsChanged {
            HoneybeeKind.fetchAllKinds()
            HoneybeeColor.fetchAllColors()
            HoneybeeIcon.fetchAllIcons()
        }
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
            //            let data = DatabaseManager.manager.allPayout()
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
        let header = MainHeader(height: 205)
        header.tapContainerViewAction = { [unowned self] in
            self.navigationController?.pushViewController(PieViewController(), animated: true)
        }
        header.usernameAction = { [unowned self] in
            self.navigationController?.pushViewController(SetupViewController(), animated: true)
        }
        header.rightButtonAction = { [unowned self] btn in
            self.popView(btn: btn)
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
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let model = dataSource.items[indexPath.row]
        
        if model.recorders.count == 1 {
            let detailVC = RecordDetailController()
            detailVC.model = model.recorders[0]
            navigationController?.pushViewController(detailVC, animated: true)
        }
    }
}


