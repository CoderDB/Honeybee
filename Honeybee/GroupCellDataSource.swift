//
//  GroupCellDataSource.swift
//  Honeybee
//
//  Created by nvicky on 14/03/2017.
//  Copyright © 2017 Dongbing Hou. All rights reserved.
//

import UIKit

class GroupCellDataSource: DataSource {
   
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "\(RecordLiteCell.self)") as! RecordLiteCell
        let model = items[indexPath.row] as! RLMRecorder
        cell.model = model
        
//        dateLabel.text = model?.monthDay
//        weekdayLabel.text = model?.weekday
        return cell
    }
}
