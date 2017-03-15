//
//  RecordDetailController.swift
//  Honeybee
//
//  Created by Dongbing Hou on 11/02/2017.
//  Copyright © 2017 Dongbing Hou. All rights reserved.
//

import UIKit


class RecordDetailController: BaseTableViewController, AlertProvider {
    
    
    var model: RLMRecorder!
    
    var dataSource: RecorderDetailDataSource!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setNavTitle("详情")
        addTableView()
        fetchData()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(false, animated: true)
    }
    func fetchData() {
        dataSource = RecorderDetailDataSource(model: model)
        tableView.dataSource = dataSource
    }
    
    func addTableView() {
        tableView.estimatedRowHeight = HB.Constant.rowHeight
        tableView.rowHeight = UITableViewAutomaticDimension
        
        tableView.contentInset.bottom = 100
        let header = RecordDetailHeader(height: 115, title: model.category, imageName: "meal", color: model.color)
        tableView.tableHeaderView = header // 这样设置的 header 宽度一定是tableview 的宽度
        let footer = RecordDetailFooter(height: 50)
        tableView.tableFooterView = footer
        footer.deleteAction = { [unowned self] in
            self.showAlert(message: "你牛！你要删我能拦得住你嘛。", ok: {
                print("ok")
            }, cancel: { 
                 print("cancel")
            })

//            self.showAlert(message: "你牛！你要删我能拦得住你嘛。")
//            DatabaseManager.manager.delete(model: self.model)
//            _ = self.navigationController?.popViewController(animated: true)
        }
        
        tableView.register(RecordDetailCell.self)
    }
    
//    func showAlert(title: String? = "确定?", message: String) {
//        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
//        let okAction = UIAlertAction(title: "确定", style: .default) { (_) in
//            
//        }
//        let cancelAction = UIAlertAction(title: "算了！", style: .cancel) { (_) in
//        }
//        alert.addAction(okAction)
//        alert.addAction(cancelAction)
//        present(alert, animated: true, completion: nil)
//    }
}

protocol AlertProvider {}
extension AlertProvider where Self: UIViewController {
    func showAlert(title: String? = "确定?", message: String, ok: @escaping () -> (), cancel: @escaping () -> ()) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        
        let okAction = UIAlertAction(title: "确定", style: .default) { (_) in
            ok()
        }
        let cancelAction = UIAlertAction(title: "算了！", style: .cancel) { (_) in
            cancel()
        }
        alert.addAction(okAction)
        alert.addAction(cancelAction)
        present(alert, animated: true, completion: nil)
    }
}


