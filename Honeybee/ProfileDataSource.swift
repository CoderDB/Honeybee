//
//  ProfileDataSource.swift
//  Honeybee
//
//  Created by nvicky on 13/03/2017.
//  Copyright © 2017 Dongbing Hou. All rights reserved.
//

import UIKit

class ProfileDataSource: DataSource {
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "\(SetupCell.self)")
        if let cell = cell as? SetupCell, let item = items[indexPath.row] as? SetupItem {
            cell.item = item
        }
        return cell!
    }
}
