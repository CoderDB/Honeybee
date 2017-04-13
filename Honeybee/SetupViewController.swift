//
//  SetupViewController.swift
//  Honeybee
//
//  Created by Dongbing Hou on 30/11/2016.
//  Copyright © 2016 Dongbing Hou. All rights reserved.
//

import UIKit

class SetupViewController: BaseTableViewController {
    
    
    
    var dataSource: SetupDataSource!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setNavTitle("设置")
        
        addTableView()
        fetchData()
    }
    func fetchData() {
        let item1 = SetupSwitchItem(title: "记账提醒", subTitle: "每天\n10:00")
//        let item2 = SetupArrowItem(title: "昵称", subTitle: "二狗哥")
        let item3 = SetupImageItem(title: "背景", subTitle: "", img: "")
        
        let item4 = SetupArrowItem(title: "绑定账号", subTitle: "")
        let item5 = SetupArrowItem(title: "手势密码", subTitle: "")
        let item6 = SetupImageItem(title: "指纹解锁", subTitle: "", img: "touchid")
        dataSource = SetupDataSource(items: [item1, item3, item4, item5, item6])
        tableView.dataSource = dataSource
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(false, animated: true)
    }
    deinit {
        print("deinit --SetupViewController")
    }
}

// MARK: UI
extension SetupViewController {
    
    func addTableView() {
        tableView.rowHeight = HB.Constant.rowHeight
        tableView.register(SetupCell.self)
        let header = SetupHeader(height: 135)
        
        header.rightButtonAction = { [weak self] _ in
            self?.navigationController?.pushViewController(ProfileViewController(), animated: true)
        }
        
        tableView.tableHeaderView = header
        tableView.tableFooterView = SetupFooter(height: 50)
    }
}


// -----------------------------------------------------------------------------
// MARK: UITabelViewDelegate
// -----------------------------------------------------------------------------
extension SetupViewController {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        switch indexPath.row {
        case 0:
            break
        case 1:
            break
        case 2:
            bindingAccounts()
            break
            
        case 3:
            navigationController?.pushViewController(PasswordViewController(), animated: true)
            break
        case 4:
            let touchId = TouchId()
            touchId.delegate = self
            touchId.accessTouchId(description: "请求使用指纹")
            break
        default:
            break
        }
    }
    
    func bindingAccounts() {
        let actionSheet = UIAlertController(title: "\n\n\n\n\n\n\n\n", message: "", preferredStyle: .actionSheet)
        
        let btn = UIButton(frame: CGRect(x: 10, y: 10, width: 50, height: 50))
        btn.setTitle("微信", for: .normal)
        btn.backgroundColor = UIColor.cyan
        
        let weibo = UIButton(frame: CGRect(x: 70, y: 10, width: 50, height: 50))
        weibo.setTitle("微博", for: .normal)
        weibo.backgroundColor = .blue
        
        let qq = UIButton(frame: CGRect(x: 130, y: 10, width: 50, height: 50))
        qq.setTitle("QQ", for: .normal)
        qq.backgroundColor = .blue
        
        
        
        actionSheet.view.addSubview(btn)
        actionSheet.view.addSubview(weibo)
        actionSheet.view.addSubview(qq)
        let cancelAction = UIAlertAction(title: "取消", style: .cancel) { (action) in
            print("cancel")
        }
        
        actionSheet.addAction(cancelAction)
        present(actionSheet, animated: true, completion: nil)
        
    }
}


// -----------------------------------------------------------------------------
// MARK: TouchIdDelegate
// -----------------------------------------------------------------------------
extension SetupViewController: TouchIdDelegate {
    func touchIdAccessSuccessed() {
        print("touchid successed")
    }
    func touchIdAccessFailed(errorCode: Int) {
        print("touchid failed--\(errorCode)")
    }
}
