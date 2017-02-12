//
//  RecordNumberCell.swift
//  Honeybee
//
//  Created by Dongbing Hou on 12/02/2017.
//  Copyright © 2017 Dongbing Hou. All rights reserved.
//

import UIKit

class RecordNumberCell: RecordDetailCell {

    lazy var moneyLabel: UILabel = {
        let label = UILabel()
        label.font = HonybeeFont.recordNumberFont
        label.text = "718967.54"
        label.textAlignment = .right
        return label
    }()

    override func setupUI() {
        super.setupUI()
        
        contentView.addSubview(moneyLabel)
        moneyLabel.snp.makeConstraints { (make) in
            make.centerY.equalTo(contentView)
            make.right.equalTo(contentView).offset(-10)
            make.left.equalTo(mainTitleLabel.snp.right).offset(10)
        }
    }
    
    
}
