
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
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setNavTitle("图表")
        
        tableView.register(PieCell.self)
        header = PieHeader(height: 250)
        tableView.tableHeaderView = header
        
        fetchData()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(false, animated: true)
    }
    func percent(part: Int, all: Int) -> (String, Double) {
        let part = Double(part), all = Double(all)
        let frac = (part / all) * 100
        let formatter = NumberFormatter()
        formatter.positiveFormat = "00.00"
        let fracStr = formatter.string(from: NSNumber(value: frac)) ?? "0"
        print(fracStr)
        
        let fracNum = formatter.number(from: fracStr)?.doubleValue ?? 0
        
//        let fracStr = String(format: "%.2f%%", frac)
//        let fracNum = (fracStr as NSString).doubleValue
        return (fracStr, fracNum)
    }
    
    func fetchData() {
        let dateString = Date().description
        let currentDate = dateString.substring(to: dateString.index(dateString.startIndex, offsetBy: 7))
        
        let superRecorders = DatabaseManager.manager.all(RLMRecorderSuper.self)
        
        let currentMonthRecorders = superRecorders
            .filter { $0.yearMonth == currentDate }
        let kindPayColor = currentMonthRecorders.map { (kind: $0.name, totalPay: $0.totalPay, color: $0.color) }//.map { SetupArrowItem(title: $0, subTitle: "20%") }

        let allPay = kindPayColor.reduce(0, { $0.0 + $0.1.totalPay })
        
        var colors: [UIColor] = []
        var numbers: [Double] = []
        var perStrs: [String] = []
        var items = [SetupArrowItem]()
        for kpc in kindPayColor {
            let per = self.percent(part: kpc.totalPay, all: allPay)
            let item = SetupArrowItem(title: kpc.kind, subTitle: per.0)
            items.append(item)
            
            colors.append(UIColor(hex: kpc.color))
            perStrs.append(per.0)
            numbers.append(per.1)
        }
        
        tableView.tableHeaderView = PieHeader(height: 250, colors: colors, numbers: numbers)
        
        var models: [PieDataModel] = []
        for (idx, category) in superRecorders.enumerated() {
            let dataModel = PieDataModel(category: category, percent: perStrs[idx])
            models.append(dataModel)
        }
        dataSource = PieDataSource(items: models)
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
