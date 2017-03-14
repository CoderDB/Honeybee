//
//  BarViewController.swift
//  Honeybee
//
//  Created by Dongbing Hou on 22/02/2017.
//  Copyright © 2017 Dongbing Hou. All rights reserved.
//

import UIKit

class BarViewController: BaseTableViewController {
    
    var dataSource: BarDataSource! //= [SetupItem]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.register(BarCell.self)
        tableView.tableHeaderView = BarHeader(height: 170)
        
        setNavRightItem("筛选")
        fetchData()
        
//        let btn = UIButton(frame: CGRect(x: 0, y: 0, width: 30, height: 25))
//        btn.setImage(UIImage(named: "calendar"), for: .normal)
////        btn.setTitle("选择", for: .normal)
////        btn.setTitleColor(HB.Color.nav, for: .normal)
////        btn.titleLabel?.font = HB.Font.h5
//        btn.addTarget(self, action: #selector(navRightItemClicked(_:)), for: .touchUpInside)
//        navigationItem.rightBarButtonItem = UIBarButtonItem(customView: btn)
    }
    
    override func navRightItemClicked(_ btn: UIButton) {
        let destVC = BarPopoverViewController()
        destVC.modalPresentationStyle = .popover
        let popoverVC = destVC.popoverPresentationController!
        popoverVC.backgroundColor = .white
        popoverVC.delegate = self
        popoverVC.sourceView = btn
        popoverVC.sourceRect = btn.bounds
        popoverVC.permittedArrowDirections = .up
        destVC.didSelectRow = {row in
            print("----\(row)")
        }
        present(destVC, animated: true, completion: nil)
    }
    
    func fetchData() {
        let item1 = SetupArrowItem(title: "衣", subTitle: "-28510")
        let item2 = SetupArrowItem(title: "食", subTitle: "-30")
        let item3 = SetupArrowItem(title: "住", subTitle: "-1096.56")
        let item4 = SetupArrowItem(title: "行", subTitle: "-7782.30")
        dataSource = BarDataSource(items: [item1, item2, item3, item4])
        tableView.dataSource = dataSource
    }
}
// MARK: UIPopoverPresentationControllerDelegate
extension BarViewController: UIPopoverPresentationControllerDelegate {
    func adaptivePresentationStyle(for controller: UIPresentationController) -> UIModalPresentationStyle {
        return .none
    }
}

// MARK: UITableViewDelegate
extension BarViewController {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        navigationController?.pushViewController(RecordDetailController(), animated: true)
    }
}
