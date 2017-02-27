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
    
    func setSubTitleAttributes(indexPath: IndexPath, model: Recorder) {
        if indexPath.row == 0 {
            subTitleLabel.attributedText = NSAttributedString(string: model.money, attributes: [NSFontAttributeName: HonybeeFont.h3_number])
        } else if indexPath.row == 1 {
            subTitleLabel.attributedText = NSAttributedString(string: model.yearMonthDay + "\n" + model.hourMinute + "\n", attributes: [NSFontAttributeName: HonybeeFont.h4_number])
        } else if indexPath.row == 2 {
            subTitleLabel.attributedText = NSAttributedString(string: model.superCategory + ">" + model.category + "\n", attributes: [NSFontAttributeName: HonybeeFont.h5])
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
