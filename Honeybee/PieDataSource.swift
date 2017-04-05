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





class PieDataModel {
    var category: RLMRecorderSuper
    var money: String
    
    init(category: RLMRecorderSuper, money: String) {
        self.category = category
        self.money = money
    }
}

class PieDataSource: NSObject, DataSourceProvider {
    typealias ItemType = PieDataModel
    var items: [ItemType]
    
    required init(items: [ItemType]) {
        self.items = items
    }
}

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
