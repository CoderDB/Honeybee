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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        automaticallyAdjustsScrollViewInsets = false
        addTableView()
        addAddBtn()
        fetchData()
    }
    
    func fetchData() {
        let data = DatabaseManager.manager.allData()
        dataSource = MainDataSource(items: data, vc: self)
        tableView.dataSource = dataSource
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
            let data = DatabaseManager.manager.allPayout()
            print(data)
            self.dataSource = MainDataSource(items: data, vc: self)
            
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
        tableView.tableFooterView = UIView()
        tableView.register(RecordCell.self)
        tableView.register(GroupCell.self)
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
        
        if model.style != "group" {
            let detailVC = RecordDetailController()
            detailVC.model = model.recorders[0]
            navigationController?.pushViewController(detailVC, animated: true)
        }
    }
}


