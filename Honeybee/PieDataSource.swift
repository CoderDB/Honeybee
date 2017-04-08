//
//  PieDataSource.swift
//  Honeybee
//
//  Created by nvicky on 14/03/2017.
//  Copyright © 2017 Dongbing Hou. All rights reserved.
//

import UIKit

protocol DataSourceProvider {
    associatedtype ItemType
    var items: [ItemType] { get }
    func item(at indexPath: IndexPath) -> ItemType
    init(items: [ItemType])
}

extension DataSourceProvider {
    func item(at indexPath: IndexPath) -> ItemType {
        return items[indexPath.row]
    }
}


//struct PieViewModel {
//    let category: String
//    let money: String
//    init(model: PieDataModel) {
//        self.category = model.category.name
//        self.money = model.money
//    }
//    
//    func fetch() {
//        let date = Date().description
//        let yearMonth = date.substring(to: date.index(date.startIndex, offsetBy: 7))
//        let superRecorders = fetchData(yearMonth: yearMonth)
//        let cnp = names_colors_numbers(models: superRecorders)
//        
//        
//        var models: [PieDataModel] = []
//        _ = superRecorders.map {
//            let dataModel = PieDataModel(category: $0, money: "\(totalPay(of: $0))")
//            models.append(dataModel)
//        }
//        
////        dataSource = PieDataSource(items: models)
////        tableView.dataSource = dataSource
//
//    }
//    
//    
//    func fetchData(yearMonth: String) -> [RLMRecorderSuper] {
//        let recorders = fetchRecorders(limit: 30)
//        var set = Set<RLMRecorderSuper>()
//        for ele in recorders {
//            if let owner = ele.owner {
//                set.insert(owner)
//            }
//        }
//        return Array(set)
//    }
//    
//    func fetchRecorders(limit: Int) -> [RLMRecorder] {
//        let recorders = Database.default.all(RLMRecorder.self)
//        let limit = min(recorders.count, limit)
//        var result: [RLMRecorder] = []
//        for i in 0..<limit {
//            result.append(recorders[i])
//        }
//        return result
//    }
//    
//    func totalPay(of model: RLMRecorderSuper) -> Int {
//        return model.recorders.reduce(0, { $0.0 + Int($0.1.money) })
//    }
//    func totalPay(_ all: [RLMRecorderSuper]) -> Int {
//        return all.map { totalPay(of: $0) }.reduce(0, {$0.0 + $0.1})
//    }
//    
//    func names_colors_numbers(models: [RLMRecorderSuper]) -> ([String], [UIColor], [Double]) {
//        let allPay = totalPay(models)
//        
//        var colors: [UIColor] = [],
//        numbers: [Double] = [],
//        names: [String] = []
//        
//        for m in models {
//            let totalPayOf = totalPay(of: m)
//            let per = percent(part: totalPayOf, all: allPay)
//            colors.append(UIColor(hex: m.color))
//            names.append(m.name)
//            numbers.append(per.1)
//        }
//        return (names, colors, numbers)
//    }
//    
//}


class PieDataModel {
    var category: RLMRecorderSuper
    var money: String
    
    init(category: RLMRecorderSuper, money: String) {
        self.category = category
        self.money = money
    }
}


// -----------------------------------------------------------------------------
// MARK: DataSourceProvider
// -----------------------------------------------------------------------------

class PieDataSource: NSObject, DataSourceProvider {
    typealias ItemType = PieDataModel
    var items: [ItemType]
    
    required init(items: [ItemType]) {
        self.items = items
    }
}


// -----------------------------------------------------------------------------
// MARK: fetch data from db
// -----------------------------------------------------------------------------

extension PieDataSource {
    func fetch(result: ([PieDataModel], _ ncn: ([String], [UIColor], [Double])) -> Void) {
        let date = Date().description
        let yearMonth = date.substring(to: date.index(date.startIndex, offsetBy: 7))
        let superRecorders = fetchData(yearMonth: yearMonth)
        
        let ncn = names_colors_numbers(models: superRecorders)
        var models: [PieDataModel] = []
        _ = superRecorders.map {
            let dataModel = PieDataModel(category: $0, money: "\(totalPay(of: $0))")
            models.append(dataModel)
        }
        result(models, ncn)
    }
    
    func fetchData(yearMonth: String) -> [RLMRecorderSuper] {
        let recorders = Database.default.fetch(RLMRecorder.self, top: 30)
        var set = Set<RLMRecorderSuper>()
        for ele in recorders {
            if let owner = ele.owner {
                set.insert(owner)
            }
        }
        return Array(set)
    }
    
    func totalPay(of model: RLMRecorderSuper) -> Int {
        return model.recorders.reduce(0, { $0.0 + Int($0.1.money) })
    }
    func totalPay(_ all: [RLMRecorderSuper]) -> Int {
        return all.map { totalPay(of: $0) }.reduce(0, {$0.0 + $0.1})
    }
    func names_colors_numbers(models: [RLMRecorderSuper]) -> ([String], [UIColor], [Double]) {
        let allPay = totalPay(models)

        var colors: [UIColor] = [],
        numbers: [Double] = [],
        names: [String] = []

        _ = models.map {
            names.append($0.name)
            colors.append(UIColor(hex: $0.color))
            
            let totalPayOf = totalPay(of: $0)
            let per = percent(part: totalPayOf, all: allPay)
            numbers.append(per.1)
        }
        return (names, colors, numbers)
    }
    func percent(part: Int, all: Int) -> (String, Double) {
        let part = Double(part), all = Double(all)
        let frac = (part / all) * 100
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        formatter.maximumFractionDigits = 1
        let fracStr = formatter.string(for: frac) ?? "0"
        print(fracStr)
        
        let fracNum = formatter.number(from: fracStr)?.doubleValue ?? 0
        return (fracStr, fracNum)
    }
}



// -----------------------------------------------------------------------------
// MARK: UITableViewDataSource
// -----------------------------------------------------------------------------

extension PieDataSource: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "\(PieCell.self)") as! PieCell
        cell.item = item(at: indexPath)
        return cell
    }
}

