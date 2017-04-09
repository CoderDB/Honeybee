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
        
//        dataSource = BarDataSource(items: recorders)
        tableView.dataSource = dataSource
        dataSource.fetch { (data) in
            tableView.tableHeaderView = BarHeader(height: 170, data: data)
        }
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
