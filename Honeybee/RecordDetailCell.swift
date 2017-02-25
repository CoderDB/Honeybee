//
//  RecordDetailCell.swift
//  Honeybee
//
//  Created by Dongbing Hou on 11/02/2017.
//  Copyright © 2017 Dongbing Hou. All rights reserved.
//

import UIKit


class RecordDetailCell: BaseTableViewCell {
    
    lazy var mainTitleLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        label.font = HonybeeFont.h3
        label.text = "记录时间"
        return label
    }()
    
    lazy var subTitleLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .right
        label.numberOfLines = 0
        label.preferredMaxLayoutWidth = 200
        label.lineBreakMode = .byWordWrapping
        label.font = HonybeeFont.h5
        
        return label
    }()
    
    
    override func setupUI() {
        contentView.addSubview(mainTitleLabel)
        contentView.addSubview(subTitleLabel)
        
        mainTitleLabel.snp.makeConstraints { (make) in
            make.centerY.equalTo(contentView)
            make.left.equalTo(10)
            make.width.equalTo(120)
            make.height.greaterThanOrEqualTo(45)
        }
        
        subTitleLabel.snp.makeConstraints { (make) in
            make.right.equalTo(contentView).offset(-10)
            make.centerY.equalTo(contentView)
            make.left.equalTo(mainTitleLabel.snp.right).offset(10)
            make.bottom.equalTo(contentView.snp.bottom).offset(-10)
        }
    }
}
