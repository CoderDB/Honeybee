//
//  BarDataSource.swift
//  Honeybee
//
//  Created by nvicky on 14/03/2017.
//  Copyright © 2017 Dongbing Hou. All rights reserved.
//

import UIKit

class BarDataSource: NSObject, DataSourceProvider {
    typealias ItemType = RLMRecorder
    var items: [ItemType]
    required init(items: [ItemType]) {
        self.items = items
    }
}


extension BarDataSource: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "\(BarCell.self)") as! BarCell
        cell.item = item(at: indexPath)
        return cell
    }
}


extension BarDataSource {
    
    func fetch(result: ([Int: Double]) -> Void) {
        
        var data: [Int: Double] = [:]
        
        _ = items.map {
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
        result(data)
    }
    
    // TODO: 合并字典
    private func flatDict(lhs: [Int: Double], rhs: [Int: Double]) -> [Int: Double] {
        var lhs = lhs, rhs = rhs
        for (k, v) in rhs {
            lhs.updateValue(v, forKey: k)
        }
        return lhs
    }
    // TODO: 合并字典，对相同k的value相加或其他
//    func flatSum(source: [(Int, Double)]) -> [Int: Double] {
//        var result = [Int: Double]()
//        _ = source.map { (ele) in
//            result[ele.0] = ele.1
//        }
//        
//        return [0: 0]
//    }
    
}
