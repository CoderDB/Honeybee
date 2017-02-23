//
//  BarViewController.swift
//  Honeybee
//
//  Created by Dongbing Hou on 22/02/2017.
//  Copyright © 2017 Dongbing Hou. All rights reserved.
//

import UIKit

class BarViewController: BaseTableViewController {
    
    var dataSource = [SetupItem]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let item1 = SetupArrowItem(title: "衣", subTitle: "-28510")
        let item2 = SetupArrowItem(title: "食", subTitle: "-30")
        let item3 = SetupArrowItem(title: "住", subTitle: "-1096.56")
        let item4 = SetupArrowItem(title: "行", subTitle: "-7782.30")
        dataSource.append(item1)
        dataSource.append(item2)
        dataSource.append(item3)
        dataSource.append(item4)
        
        tableView.register(BarCell.self, forCellReuseIdentifier: "\(BarCell.self)")
        tableView.tableHeaderView = BarHeader(height: 170)
        
        let btn = UIButton(frame: CGRect(x: 0, y: 0, width: 30, height: 25))
        btn.setImage(UIImage(named: "calendar"), for: .normal)
//        btn.setTitle("选择", for: .normal)
//        btn.setTitleColor(HonybeeColor.main, for: .normal)
//        btn.titleLabel?.font = HonybeeFont.h4
        btn.addTarget(self, action: #selector(navRightItemAction(_:)), for: .touchUpInside)
        navigationItem.rightBarButtonItem = UIBarButtonItem(customView: btn)
    }
    
    func navRightItemAction(_ btn: UIButton) {
        let destVC = BarPopoverViewController()
        destVC.modalPresentationStyle = .popover
        let popoverVC = destVC.popoverPresentationController!
        popoverVC.delegate = self
        popoverVC.sourceView = btn
        popoverVC.sourceRect = btn.bounds
        popoverVC.permittedArrowDirections = .up
        destVC.didSelectRow = {row in
            print("----\(row)")
        }
        present(destVC, animated: true, completion: nil)
    }
}
// MARK: UIPopoverPresentationControllerDelegate
extension BarViewController: UIPopoverPresentationControllerDelegate {
    func adaptivePresentationStyle(for controller: UIPresentationController) -> UIModalPresentationStyle {
        return .none
    }
}

// MARK: UITableViewDataSource
extension BarViewController {
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataSource.count
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "\(BarCell.self)") as! BarCell
        cell.item = dataSource[indexPath.row]
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        navigationController?.pushViewController(RecordDetailController(), animated: true)
    }
}
