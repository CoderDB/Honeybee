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
        label.font = HB.Font.h3
        return label
    }()
    
    lazy var subTitleLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .right
        label.numberOfLines = 0
        label.preferredMaxLayoutWidth = 200
        label.lineBreakMode = .byWordWrapping
        label.font = HB.Font.h5
        
        return label
    }()
    
    func setSubTitleAttributes(indexPath: IndexPath, model: RLMRecorder) {
        if indexPath.row == 0 {
            subTitleLabel.attributedText = NSAttributedString(string: model.money, attributes: [NSFontAttributeName: HB.Font.h3_number])
        } else if indexPath.row == 1 {
            subTitleLabel.attributedText = NSAttributedString(string: model.yearMonthDay + "\n" + model.hourMinute + "\n", attributes: [NSFontAttributeName: HB.Font.h4_number])
        } else if indexPath.row == 2 {
            subTitleLabel.attributedText = NSAttributedString(string: model.superCategory + ">" + model.category + "\n", attributes: [NSFontAttributeName: HB.Font.h5])
        } else {
            subTitleLabel.text = model.remark
        }
    }
    
    override func initialize() {
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

extension RecordDetailCell: DDDCell {
    typealias ItemType = String
    func config(item: String) {
        mainTitleLabel.text = item
    }
}
