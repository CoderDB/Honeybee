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
    lazy var mainTopTitleLabel: UILabel = {
        let label = UILabel()
        label.font = HB.Font.h5
        return label
    }()
    lazy var mainBottomTitleLabel: UILabel = {
        let label = UILabel()
        label.font = HB.Font.h4_number
        return label
    }()
    lazy var subTitleLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .right
        label.font = HB.Font.h3_number
        return label
    }()
    lazy var arrow = UIImageView(image: UIImage(named: "rightArrow"))
    
  
    var item: SetupItem! {
        didSet {
            mainTopTitleLabel.text = "星期六"
            mainBottomTitleLabel.text = "02-18"
            subTitleLabel.text = item.subTitle
        }
    }
    override func initialize() {
        contentView.addSubview(imgView)
        contentView.addSubview(mainTopTitleLabel)
        contentView.addSubview(mainBottomTitleLabel)
        contentView.addSubview(subTitleLabel)
        imgView.snp.makeConstraints { (make) in
            make.centerY.equalTo(contentView)
            make.left.equalTo(contentView).offset(10)
            make.width.height.equalTo(40)
        }
        mainTopTitleLabel.snp.makeConstraints { (make) in
            make.bottom.equalTo(contentView.snp.centerY)
            make.left.equalTo(imgView.snp.right).offset(10)
        }
        mainBottomTitleLabel.snp.makeConstraints { (make) in
            make.top.equalTo(contentView.snp.centerY)
            make.left.equalTo(mainTopTitleLabel)
        }
        subTitleLabel.snp.makeConstraints { (make) in
            make.right.centerY.equalTo(contentView)
        }
        accessoryView = arrow
    }


}
