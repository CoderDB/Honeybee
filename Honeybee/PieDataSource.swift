//
//  PieDataSource.swift
//  Honeybee
//
//  Created by nvicky on 14/03/2017.
//  Copyright © 2017 Dongbing Hou. All rights reserved.
//

import UIKit

class PieDataSource: DataSource {
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "\(PieCell.self)") as! PieCell
        cell.item = items[indexPath.row] as! SetupItem
        return cell
    }
    
}
