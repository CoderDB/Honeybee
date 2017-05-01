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




//class PieDataModel {
//    var category: String//RLMRecorderSuper
//    var money: String
//    
//    init(category: String, money: String) {
//        self.category = category
//        self.money = money
//    }
//}


class PieDataModel {
    var category: String
    var recorders: [RLMRecorder]
    
    init(category: String, recorders: [RLMRecorder]) {
        self.category = category
        self.recorders = recorders
    }
}


// -----------------------------------------------------------------------------
// MARK: DataSourceProvider
// -----------------------------------------------------------------------------

//class PieDataSource: NSObject, DataSourceProvider {
//    typealias ItemType = PieDataModel
//    var items: [ItemType]
//    
//    required init(items: [ItemType]) {
//        self.items = items
//    }
//}


class PieDataSource: NSObject, DataSourceProvider {
    typealias ItemType = RLMRecorder
    var items: [ItemType]
    
    required init(items: [ItemType]) {
        self.items = items
    }
}


// -----------------------------------------------------------------------------
// MARK: fetch data from db
// -----------------------------------------------------------------------------

extension PieDataSource {
    
    
    
//    func fetch(result: ([PieDataModel], _ ncp: ([String], [UIColor], [Double])) -> Void) {
////        let date = Date().description
////        let yearMonth = date.substring(to: date.index(date.startIndex, offsetBy: 7))
////        let superRecorders = fetchData(yearMonth: yearMonth)
//        
//        let superRecorders = fetch(top: 30)
//        let ncn = names_colors_percents(models: superRecorders)
//        var models: [PieDataModel] = []
//        _ = superRecorders.map {
//            let dataModel = PieDataModel(category: $0, money: "\($0.totalPay)")
//            models.append(dataModel)
//        }
//        result(models, ncn)
//    }
    
    
    
//    func fetch(month: Int, result: ([PieDataModel], _ recorders: [RLMRecorder], _ ncp: ([String], [UIColor], [Double])) -> Void) {
//        let all = Database.default.all(RLMRecorder.self)
//        let thisMonthData = Array(all.filter { $0.month == month })
//        let superRecorders = getRecorderSuper(recorders: thisMonthData)
//        let ncp = names_colors_percents(models: superRecorders)
//        var models: [PieDataModel] = []
//        _ = superRecorders.map {
//            let dataModel = PieDataModel(category: $0, money: "\($0.totalPay)")
//            models.append(dataModel)
//        }
//        result(models, thisMonthData, ncp)
//        
//    }
//    func totalPayOfOneMonth(recorders: [RLMRecorder], superRecorders: [RLMRecorderSuper]) -> Int {
//        let keys = superRecorders.map { $0.name }
//        
//        var dict: [String: Double] = dictionaryWithValues(forKeys: keys) as! [String : Double]
//        
//        
//        for k in dict.keys {
//            for ele in recorders {
//                if ele.category == k {
//                    dict[k]! += ele.money
//                }
//            }
//        }
//        
//        return 0
//    }
//    private func getRecorderSuper(recorders: [RLMRecorder]) -> [RLMRecorderSuper] {
//        var set = Set<RLMRecorderSuper>()
//        for ele in recorders {
//            if let owner = ele.owner {
//                set.insert(owner)
//            }
//        }
//        return Array(set)
//    }
    
    
//    private func fetch(top: Int) -> [RLMRecorderSuper] {
//        let recorders = Database.default.fetch(RLMRecorder.self, top: top)
//        return getRecorderSuper(recorders: recorders)
//    }
//    private func names_colors_percents(models: [RLMRecorderSuper]) -> ([String], [UIColor], [Double]) {
//        let allPay = models.map { $0.totalPay }.reduce(0, {$0.0 + $0.1})
//
//        var colors: [UIColor] = [],
//        percents: [Double] = [],
//        names: [String] = []
//
//        _ = models.map {
//            names.append($0.name)
//            colors.append(UIColor(hex: $0.color))
//            
//            let totalPayOf = $0.totalPay
//            let per = percent(part: totalPayOf, all: allPay)
//            percents.append(per.1)
//        }
//        return (names, colors, percents)
//    }
    
    private func percent(part: Int, all: Int) -> (String, Double) {
        let part = Double(part), all = Double(all)
        let frac = (part / all) * 100
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        formatter.maximumFractionDigits = 1
        let fracStr = formatter.string(for: frac) ?? "0"
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

