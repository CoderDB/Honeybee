//
//  RecorderDetailDataSource.swift
//  Honeybee
//
//  Created by Dongbing Hou on 11/03/2017.
//  Copyright © 2017 Dongbing Hou. All rights reserved.
//

import UIKit

class RecorderDetailDataSource: DataSource {
    
    var model: RLMRecorder
    
    init(model: RLMRecorder) {
        self.model = model
        super.init(items: ["金额", "记录时间", "分类", "备注"])
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "\(RecordDetailCell.self)") as! RecordDetailCell
        cell.mainTitleLabel.text = items[indexPath.row] as? String
        cell.setSubTitleAttributes(indexPath: indexPath, model: model)
        return cell
    }
}
