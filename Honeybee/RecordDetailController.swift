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
    var superModel: RLMRecorderSuper!
    
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
//            self.showAlert(msg: AlertMessage(title: "确定", message: "哈哈哈", okText: "OK", cancelText: "Can", ok: {
//                
//            }, cancel: nil))
//            self.showAlert(msg:
//                AlertMessage(
//                    title: "",
//                    message: "",
//                    okText: "",
//                    cancelText: "",
//                    ok: { },
//                    cancel: {})
//            )
            self.showAlert(message: "你牛！你要删我能拦得住你嘛。", ok: { [unowned self] in
                self.delete()
            }, cancel: nil)
//            self.showAlert(message: "你牛！你要删我能拦得住你嘛。", ok: { [unowned self] in
//                self.delete()
//            }, cancel: {
//                 print("cancel")
//            })
        }
        
        tableView.register(RecordDetailCell.self)
    }
    
    func delete() {
        
        DatabaseManager.manager.delete(model: model)
        DatabaseManager.manager.notification {
            
        }
        _ = navigationController?.popViewController(animated: true)
    }
}

//struct AlertMessage {
//    typealias testAction = () -> ()
//    var title: String? = "确定?"
//    var message: String
//    var okText: String
//    var cancelText: String
//    var ok: () -> ()
//    var cancel: (() -> ())?
//}

protocol AlertProvider {}
extension AlertProvider where Self: UIViewController {
    
//    func showAlert(msg: AlertMessage = AlertMessage(title: "", message: "", okText: "", cancelText: "", ok: {}, cancel: {})) {
//        let alert = UIAlertController(title: msg.title!, message: msg.message, preferredStyle: .alert)
//        
//        let okAction = UIAlertAction(title: msg.okText, style: .default) { (_) in
//            msg.ok()
//        }
//        let cancelAction = UIAlertAction(title: msg.cancelText, style: .cancel) { (_) in
//            msg.cancel?()
//        }
//        alert.addAction(okAction)
//        alert.addAction(cancelAction)
//        present(alert, animated: true, completion: nil)
//    }
    
    func showAlert(title: String? = "确定?", message: String, ok: @escaping () -> (), cancel: (() -> ())? = nil) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "确定", style: .default) { (_) in
            ok()
        }
        let cancelAction = UIAlertAction(title: "算了！", style: .cancel) { (_) in
            cancel?()
        }
        alert.addAction(okAction)
        alert.addAction(cancelAction)
        present(alert, animated: true, completion: nil)
    }
}


