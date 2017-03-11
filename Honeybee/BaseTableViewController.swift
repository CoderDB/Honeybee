//
//  BaseTableViewController.swift
//  Honeybee
//
//  Created by Dongbing Hou on 22/02/2017.
//  Copyright © 2017 Dongbing Hou. All rights reserved.
//

import UIKit

class BaseTableViewController: BaseViewController {

    lazy var tableView: UITableView = {
        $0.separatorStyle = .none
        $0.showsVerticalScrollIndicator = false
        $0.showsHorizontalScrollIndicator = false
        $0.dataSource = self
        $0.delegate = self
        $0.rowHeight = HB.Constant.rowHeight
        return $0
    }(UITableView())
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(tableView)
        tableView.snp.makeConstraints { (make) in
            make.edges.equalTo(view)
        }
    }
}

extension BaseTableViewController: UITableViewDataSource, UITableViewDelegate {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 0
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return UITableViewCell()
    }
}
