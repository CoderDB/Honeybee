//
//  BarCell.swift
//  Honeybee
//
//  Created by Dongbing Hou on 22/02/2017.
//  Copyright © 2017 Dongbing Hou. All rights reserved.
//

import UIKit

class BarCell: BaseTableViewCell {
    
    lazy var imgView = UIImageView(image: UIImage(named: "meal"))
    
    lazy var dateLabel: UILabel = {
        let label = UILabel()
        label.font = HB.Font.h5_number
        return label
    }()
    lazy var nameLabel: UILabel = {
        let label = UILabel()
        label.font = HB.Font.h5
        return label
    }()
    lazy var weekdayLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .right
        label.font = HB.Font.h7
        return label
    }()
    lazy var moneyLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .right
        label.font = HB.Font.h3_number
        return label
    }()
    lazy var arrow = UIImageView(image: UIImage(named: "rightArrow"))
    
  
//    var item: SetupItem! {
//        didSet {
//            mainTopTitleLabel.text = "星期六"
//            mainBottomTitleLabel.text = "02-18"
//            subTitleLabel.text = item.subTitle
//        }
//    }
    
    var item: RLMRecorder! {
        didSet {
            dateLabel.text = item.monthDay
            nameLabel.text = item.category
            weekdayLabel.text = item.weekday
            moneyLabel.text = "\(item.money)"
        }
    }
    override func initialize() {
        contentView.addSubview(imgView)
        contentView.addSubview(dateLabel)
        contentView.addSubview(nameLabel)
        contentView.addSubview(weekdayLabel)
        contentView.addSubview(moneyLabel)
        imgView.snp.makeConstraints { (make) in
            make.centerY.equalTo(contentView)
            make.left.equalTo(contentView).offset(10)
            make.width.height.equalTo(40)
        }
        
        dateLabel.snp.makeConstraints { (make) in
            make.left.equalTo(imgView.snp.right).offset(10)
            make.top.equalTo(contentView).offset(5)
        }
        nameLabel.snp.makeConstraints { (make) in
            make.left.equalTo(dateLabel)
            make.top.equalTo(dateLabel.snp.bottom)
        }
        weekdayLabel.snp.makeConstraints { (make) in
            make.right.equalTo(contentView).offset(-10)
            make.top.equalTo(contentView)
        }
        moneyLabel.snp.makeConstraints { (make) in
            make.right.equalTo(contentView).offset(-5)
            make.bottom.equalTo(contentView)
        }
        
        accessoryView = arrow
    }


}
