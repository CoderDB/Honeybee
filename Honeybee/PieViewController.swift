
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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setNavTitle("图表")
        
        tableView.register(PieCell.self)
        tableView.tableHeaderView = PieHeader(height: 250)
        
        fetchData()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(false, animated: true)
    }
    func percent(part: Int, all: Int) -> String {
        let part = Float(part), all = Float(all)
        let frac = (part / all) * 100
        return String(format: "%.2f%%", frac)
    }
    
    func fetchData() {
        let dateString = Date().description
        let currentDate = dateString.substring(to: dateString.index(dateString.startIndex, offsetBy: 7))
        
        let superRecorders = DatabaseManager.manager.all(RLMRecorderSuper.self)
        let currentMonthRecorders = superRecorders
            .filter { $0.yearMonth == currentDate }
        let kindAndTotalPays = currentMonthRecorders.map { ($0.name, $0.totalPay) }//.map { SetupArrowItem(title: $0, subTitle: "20%") }
        let allPay = kindAndTotalPays.reduce(0) { (resu, test) -> Int in
            return resu + test.1
        }
//        let appPay = parts.reduce(0, +)
//        let items = kindAndTotalPays.map { (kind, pay) -> SetupArrowItem in
//            let per = self.percent(part: pay, all: allPay)
//            return SetupArrowItem(title: kind, subTitle: per)
//        }
        
        var items = [SetupArrowItem]()
        for temp in kindAndTotalPays {
            let per = self.percent(part: temp.1, all: allPay)
            let item = SetupArrowItem(title: temp.0, subTitle: per)
            items.append(item)
        }
//        let items = kindAndTotalPays.map {
//            let per = self.percent(part: $0.1, all: allPay)
//            SetupArrowItem(title: $0.0, subTitle: per)
//        }
        
    
//        var items = [SetupArrowItem]()
//        for (idx, ele) in kinds.enumerated() {
//            
//            let <#name#> = parts[idx]
//            
//            let item = SetupArrowItem(title: ele, subTitle: "20%")
//            items.append(item)
//        }
        
        
        
//        let recorders = DatabaseManager.manager.all(RLMRecorder.self)
//        
//        let matched = recorders
//            .filter { $0.year == currentYear }
//            .filter { $0.month == currentMonth }
//        print(matched)
//        var kinds = [String]()
//        for recorder in matched {
//            kinds.append(recorder.superCategory)
//        }
////        let kinds = matched.map { $0.superCategory }
//        
//        let groupedKinds = group(source: kinds)
//        print(groupedKinds)
//        
//        var items = [SetupArrowItem]()
//        for groupedKind in groupedKinds {
//            if let name = groupedKind.first {
//                let item = SetupArrowItem(title: name, subTitle: "10%")
//                items.append(item)
//            }
//        }
        
        
        dataSource = PieDataSource(items: items)
        tableView.dataSource = dataSource
    }
}


// MARK: UITableViewDelegate

extension PieViewController {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let item = dataSource.item(at: indexPath) as? SetupItem {
            let barVC = BarViewController()
            barVC.setNavTitle(item.title)
            navigationController?.pushViewController(barVC, animated: true)
        }
    }
}
