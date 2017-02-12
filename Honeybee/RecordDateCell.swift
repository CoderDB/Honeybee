//
//  RecordDateCell.swift
//  Honeybee
//
//  Created by Dongbing Hou on 12/02/2017.
//  Copyright © 2017 Dongbing Hou. All rights reserved.
//

import UIKit

class RecordDateCell: RecordDetailCell {

    
    lazy var dateLabel: UILabel = {
        let label = UILabel()
        label.font = HonybeeFont.recordDateFont
        label.text = "2017-02-12"
        label.textAlignment = .right
        return label
    }()
    lazy var timeLabel: UILabel = {
        let label = UILabel()
        label.font = HonybeeFont.recordDateFont
        label.text = "18:06"
        label.textAlignment = .right
        return label
    }()
    
    override func setupUI() {
        super.setupUI()
        
        contentView.addSubview(dateLabel)
        contentView.addSubview(timeLabel)
        
        dateLabel.snp.makeConstraints { (make) in
            make.right.equalTo(contentView).offset(-10)
            make.left.equalTo(mainTitleLabel.snp.right).offset(10)
            make.bottom.equalTo(contentView.snp.centerY)
        }
        timeLabel.snp.makeConstraints { (make) in
            make.right.equalTo(contentView).offset(-10)
            make.top.equalTo(dateLabel.snp.bottom)
            make.left.equalTo(dateLabel)
        }
    }

}
