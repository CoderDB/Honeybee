//
//  PieViewController.swift
//  Honeybee
//
//  Created by Dongbing Hou on 26/12/2016.
//  Copyright © 2016 Dongbing Hou. All rights reserved.
//
import UIKit
import DZNEmptyDataSet

class PieViewController: BaseTableViewController {
    
    var dataSource: PieDataSource!
    var header: PieHeader!
    var recorders = [RLMRecorder]()
    
    var MONTH: Int = Date().localDate.month
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setNavTitle("图表")
        setNavRightItem("筛选")
        
        tableView.register(PieCell.self)
        
        tableView.emptyDataSetSource = self
        
        
//        fetchData(month: Date().localDate.month)
        
        fetch()
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
            self.MONTH = row
//            self.fetchData(month: self.MONTH)
        }
        present(destVC, animated: true, completion: nil)
    }
    
    
    func fetch() {
        let all = Database.default.all(RLMRecorder.self)
        let matched = Array(all.filter { $0.month == self.MONTH })
        let grouped = group(recorders: matched)

        dataSource = PieDataSource(items: grouped)
        tableView.dataSource = dataSource
        
        let npm = name_color_percent(models: grouped)
        tableView.tableHeaderView = PieHeader(height: 250, names: npm.0, colors: npm.1, percents: npm.2)
    }
    
    func name_color_percent(models: [PieDataModel]) -> ([String], [UIColor], [Double]) {
        
        var colors: [UIColor] = [],
        percents: [Double] = [],
        names: [String] = []
        var allPay = 0
        _ = models.map {
            names.append($0.category)
            colors.append(UIColor(hex: $0.recorders[0].color))

            let categoryPay = Int($0.recorders.reduce(0, { $0.0 + $0.1.money }))
            allPay += categoryPay
            let per = percent(part: categoryPay, all: allPay)
            percents.append(per.1)
        }
        return (names, colors, percents)
    }
    func percent(part: Int, all: Int) -> (String, Double) {
        let part = Double(part), all = Double(all)
        let frac = (part / all) * 100
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        formatter.maximumFractionDigits = 1
        let fracStr = formatter.string(for: frac) ?? "0"
        let fracNum = formatter.number(from: fracStr)?.doubleValue ?? 0
        return (fracStr, fracNum)
    }
    
    // TODO: group
    
    func group(recorders: [RLMRecorder]) -> [PieDataModel] {
        let keys = Array(Set(recorders.map { $0.superCategory }))
        var dict: [String: [RLMRecorder]] = [:]
        
        var result = [PieDataModel]()
        var iterator = keys.makeIterator()
        while let key = iterator.next() {
            dict[key] = []
            _ = recorders.map {
                if $0.superCategory == key {
                    dict[key]?.append($0)
                }
            }
            let model = PieDataModel(category: key, recorders: dict[key]!)
            result.append(model)
        }
        return result
    }
    
}


// DZNEmptyDataSetSource
extension PieViewController: DZNEmptyDataSetSource {
    func image(forEmptyDataSet scrollView: UIScrollView!) -> UIImage! {
        
        return UIImage(named: "xmark")
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
        
        let model = dataSource.item(at: indexPath)
        let barVC = BarViewController(recorders: model.recorders)
        barVC.setNavTitle(model.category)
        navigationController?.pushViewController(barVC, animated: true)
    }
    
    
//    func matchedRecorders(superModel: RLMRecorderSuper, month: Int) -> [RLMRecorder] {
//        let recorders = superModel.recorders
//        let matched = recorders.filter { $0.month == month }
//        return Array(matched)
//    }
}
