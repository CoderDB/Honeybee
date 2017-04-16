//
//  RecordDetailController.swift
//  Honeybee
//
//  Created by Dongbing Hou on 11/02/2017.
//  Copyright © 2017 Dongbing Hou. All rights reserved.
//

import UIKit


class RecordDetailController: BaseTableViewController, AlertProvider {
    
    
    private var model: RLMRecorder
    
//    var dataSource: RecorderDetailDataSource!
    init(model: RLMRecorder) {
        self.model = model
        super.init(nibName: nil, bundle: nil)
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    typealias Model = RecorderDetailViewModel
    typealias Cell = RecordDetailCell
    var viewModel: Model!
    var dataSource: ConfigurableDataSourceTableViewDataSource<Model, Cell>!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setNavTitle("详情")
        addTableView()
        fetchData()
    }
//    override func viewWillAppear(_ animated: Bool) {
//        super.viewWillAppear(animated)
//        navigationController?.setNavigationBarHidden(false, animated: true)
//    }
    func fetchData() {
        
//        dataSource = RecorderDetailDataSource(model: model)
//        tableView.dataSource = dataSource
        
        viewModel = RecorderDetailViewModel(model: model)
        dataSource = ConfigurableDataSourceTableViewDataSource<Model, Cell>(model: viewModel)
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
            self.showAlert(message: "你牛！你要删我能拦得住你嘛。", ok: { [unowned self] in
                self.delete()
            }, cancel: nil)
        }
        
        tableView.register(RecordDetailCell.self)
    }
    
    func delete() {
        if let owner = model.owner {
            do {
                try Database.default.delete(item: model, in: owner.recorders)
                if owner.recorders.count == 0  {
                    do {
                        try Database.default.delete(item: owner)
//                        navigationController?.popToRootViewController(animated: true)
                        _ = navigationController?.popViewController(animated: true)
                    } catch let err {
                        Reminder.error(msg: err.localizedDescription)
                    }
                } else {
                    
//                    navigationController?.popToRootViewController(animated: true)
                    _ = navigationController?.popViewController(animated: true)
                }
            } catch let err {
                Reminder.error(msg: err.localizedDescription)
            }
        }
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



