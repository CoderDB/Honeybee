//
//  PieCell.swift
//  Honeybee
//
//  Created by Dongbing Hou on 22/02/2017.
//  Copyright © 2017 Dongbing Hou. All rights reserved.
//

import UIKit

class PieCell: BaseTableViewCell {
    
    lazy var mainTitleLabel: UILabel = {
        let label = UILabel()
        label.font = HB.Font.h3
        return label
    }()
    lazy var subTitleLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .right
        label.font = HB.Font.h3_number
        return label
    }()
    lazy var arrow = UIImageView(image: UIImage(named: "rightArrow"))
    
//    var item: SetupItem! {
//        didSet {
//            mainTitleLabel.text = item.title
//            subTitleLabel.text = item.subTitle
//        }
//    }
//    var item: RLMRecorderSuper! {
//        didSet {
//            mainTitleLabel.text = item.name
//            subTitleLabel.text = "9"//item.month
//        }
//    }
    override func initialize() {
        contentView.addSubview(mainTitleLabel)
        contentView.addSubview(subTitleLabel)
        
        mainTitleLabel.snp.makeConstraints { (make) in
            make.centerY.equalTo(contentView)
            make.left.equalTo(contentView).offset(10)
        }
        subTitleLabel.snp.makeConstraints { (make) in
            make.centerY.equalTo(contentView)
            make.right.equalTo(contentView).offset(-5)
        }
        accessoryView = arrow
    }
}
