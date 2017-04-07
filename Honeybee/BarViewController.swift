//
//  BarViewController.swift
//  Honeybee
//
//  Created by Dongbing Hou on 22/02/2017.
//  Copyright © 2017 Dongbing Hou. All rights reserved.
//

import UIKit



protocol TableViewProvider {
    var delegate: UITableViewDelegate! { set get }
    var dataSource: UITableViewDataSource! { set get }
    var tableView: UITableView { get }
}
extension TableViewProvider {
    var tableView: UITableView {
        let tv = UITableView()
        tv.delegate = delegate
        tv.dataSource = dataSource
        tv.separatorStyle = .none
        tv.showsVerticalScrollIndicator = false
        tv.showsHorizontalScrollIndicator = false
        return tv
    }
}


class BarViewController: BaseTableViewController {

    var dataSource: BarDataSource!
    
    var category: RLMRecorderSuper!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(tableView)
        tableView.register(BarCell.self)
        tableView.tableHeaderView = BarHeader(height: 170)
        
        setNavRightItem("筛选")
        fetchData()
        
    }
    
    override func navRightItemClicked(_ btn: UIButton) {
        let destVC = BarPopoverController()
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
        let recorders = Array(category.recorders)
        var data: [Int: Double] = [:]
        
        _ = recorders.map {
            if data.keys.contains($0.day) {
                data[$0.day]?.add(Double($0.money))
            } else {
                data[$0.day] = Double($0.money)
            }
        }
        let date = Date()
        let days = Date.days(year: date.year, month: date.month)
        var tempDict = [Int: Double]()
        for i in 1...days {
            tempDict[i] = 0
        }
        data = flatDict(lhs: tempDict, rhs: data)
        
        tableView.tableHeaderView = BarHeader(height: 170, data: data)
        
        dataSource = BarDataSource(items: recorders)
        tableView.dataSource = dataSource
    }
    // TODO: 合并字典
    func flatDict(lhs: [Int: Double], rhs: [Int: Double]) -> [Int: Double] {
        var lhs = lhs, rhs = rhs
        for (k, v) in rhs {
            lhs.updateValue(v, forKey: k)
        }
        return lhs
    }
    // TODO: 合并字典，对相同k的value相加或其他
    func flatSum(source: [(Int, Double)]) -> [Int: Double] {
        var result = [Int: Double]()
        _ = source.map { (ele) in
            result[ele.0] = ele.1
        }
        
        return [0: 0]
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
        let vc = RecordDetailController(model: dataSource.item(at: indexPath))
        navigationController?.pushViewController(vc, animated: true)
    }
}


extension BarViewController {
    override var shouldAutorotate: Bool {
        return true
    }
    
    override var preferredInterfaceOrientationForPresentation: UIInterfaceOrientation {
        return .landscapeLeft
    }
    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        return .all
    }
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        super.viewWillTransition(to: size, with: coordinator)
        
    }
    
}
