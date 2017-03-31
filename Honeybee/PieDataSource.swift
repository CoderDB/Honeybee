//
//  PieDataSource.swift
//  Honeybee
//
//  Created by nvicky on 14/03/2017.
//  Copyright © 2017 Dongbing Hou. All rights reserved.
//

import UIKit

protocol PieDataSourceProtocol {
    associatedtype ItemType
    var items: [ItemType] { get }
    func item(at indexPath: IndexPath) -> ItemType
}


class PieDataSource: NSObject, PieDataSourceProtocol {
    typealias ItemType = SetupItem
    var items: [ItemType]
    func item(at indexPath: IndexPath) -> ItemType {
        return items[indexPath.row]
    }
    
    init(items: [ItemType]) {
        self.items = items
        super.init()
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
