//
//  PieViewController.swift
//  Honeybee
//
//  Created by Dongbing Hou on 26/12/2016.
//  Copyright © 2016 Dongbing Hou. All rights reserved.
//
import UIKit

class PieViewController: BaseTableViewController {
    
    var dataSource: PieDataSource!
    var header: PieHeader!
    var recorders = [RLMRecorder]()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setNavTitle("图表")
        setNavRightItem("筛选")
        
        tableView.register(PieCell.self)
        header = PieHeader(height: 250)
        tableView.tableHeaderView = header
        
        fetchData(month: Date().localDate.month)
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(false, animated: true)
    }
    override func navRightItemClicked(_ btn: UIButton) {
        let destVC = PiePopoverController()
        destVC.modalPresentationStyle = .popover
        let popoverVC = destVC.popoverPresentationController!
        popoverVC.backgroundColor = .white
        popoverVC.delegate = self
        popoverVC.sourceView = btn
        popoverVC.sourceRect = btn.bounds
        popoverVC.permittedArrowDirections = .up
        destVC.didSelectRow = {row in
            print("----\(row)")
            var row = row
            if row == 2 {
                row = Date().localDate.month - 1
            } else if row == 1 {
                row = Date().localDate.month - 2
            }
            self.fetchData(month: row)
        }
        present(destVC, animated: true, completion: nil)
    }
    func fetchData(month: Int) {
        PieDataSource(items: []).fetch(month: month) { [weak self] (pieData, recorders, ncp) in
            self?.recorders = recorders
            self?.dataSource = PieDataSource(items: pieData)
            self?.tableView.dataSource = self?.dataSource
            self?.tableView.tableHeaderView = PieHeader(height: 250, names: ncp.0, colors: ncp.1, percents: ncp.2)
        }
    }
}


// MARK: UIPopoverPresentationControllerDelegate
extension PieViewController: UIPopoverPresentationControllerDelegate {
    func adaptivePresentationStyle(for controller: UIPresentationController) -> UIModalPresentationStyle {
        return .none
    }
}

// MARK: UITableViewDelegate
extension PieViewController {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let barVC = BarViewController()
        barVC.dataSource = BarDataSource(items: recorders)
        
        //        barVC.category = dataSource.item(at: indexPath).category
        barVC.setNavTitle(dataSource.item(at: indexPath).category.name)
        navigationController?.pushViewController(barVC, animated: true)
    }
}
