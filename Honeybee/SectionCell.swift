//
//  SectionCell.swift
//  Honeybee
//
//  Created by Dongbing Hou on 09/02/2017.
//  Copyright © 2017 Dongbing Hou. All rights reserved.
//

import UIKit

class SectionCell: UITableViewCell {

    lazy var dateLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        label.font = Honybee.recordDateFont
        label.textColor = UIColor.black
        label.text = "2月10日"
        return label
    }()
    lazy var categoryLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        label.font = Honybee.subTitleFont
        label.textColor = UIColor.black
        label.text = "打车"
        return label
    }()
    lazy var weekdayLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        label.font = Honybee.weekFont
        label.textColor = UIColor.black
        label.text = "星期二"
        return label
    }()
    lazy var numberLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .right
        label.font = Honybee.recordNumberFont
        label.textColor = UIColor.black
        label.text = "256.80"
        return label
    }()
}
