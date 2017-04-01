
//
//  PieViewController.swift
//  Honeybee
//
//  Created by Dongbing Hou on 26/12/2016.
//  Copyright © 2016 Dongbing Hou. All rights reserved.
//

import UIKit
import RealmSwift

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
        formatter.positiveFormat = "00.0"
        let fracStr = formatter.string(from: NSNumber(value: frac)) ?? "0"
        print(fracStr)
        
        let fracNum = formatter.number(from: fracStr)?.doubleValue ?? 0
        
//        let fracStr = String(format: "%.2f%%", frac)
//        let fracNum = (fracStr as NSString).doubleValue
        return (fracStr, fracNum)
    }
    func fetchData(yearMonth: String) -> [RLMRecorderSuper] {
        let models = DatabaseManager.manager.all(RLMRecorderSuper.self)
            .filter { $0.yearMonth == yearMonth }
        return Array(models)
    }
    
    func colors_numbers_percents(models: [RLMRecorderSuper]) -> ([UIColor], [Double], [String]) {
        let kind_pay_color = models.map { (kind: $0.name, totalPay: $0.totalPay, color: $0.color) }
        let allPay = kind_pay_color.reduce(0, { $0.0 + $0.1.totalPay })
        
        var colors: [UIColor] = [],
            numbers: [Double] = [],
            percents: [String] = []
        
        for kpc in kind_pay_color {
            let per = percent(part: kpc.totalPay, all: allPay)
            
            colors.append(UIColor(hex: kpc.color))
            percents.append(per.0)
            numbers.append(per.1)
        }
        return (colors, numbers, percents)
    }
    
    func fetchData() {
        let date = Date().description
        let yearMonth = date.substring(to: date.index(date.startIndex, offsetBy: 7))
        let superRecorders = fetchData(yearMonth: yearMonth)
        let cnp = colors_numbers_percents(models: superRecorders)
        
        tableView.tableHeaderView = PieHeader(height: 250, colors: cnp.0, numbers: cnp.1)
        
        var models: [PieDataModel] = []
        for (idx, category) in superRecorders.enumerated() {
            let dataModel = PieDataModel(category: category, percent: cnp.2[idx])
            models.append(dataModel)
        }
        dataSource = PieDataSource(items: models)
        tableView.dataSource = dataSource
    }
}


// MARK: UITableViewDelegate

extension PieViewController {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {

        let barVC = BarViewController()
        barVC.category = dataSource.item(at: indexPath).category
        barVC.setNavTitle(dataSource.item(at: indexPath).category.name)
        navigationController?.pushViewController(barVC, animated: true)
    }
}
