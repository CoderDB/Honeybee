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
    

    var item: PieDataModel? {
        didSet {
            if let item = item {
                mainTitleLabel.text = item.category.name
                subTitleLabel.attributedText = attributeString(text: item.money)
            }
        }
    }
    func attributeString(text: String) -> NSMutableAttributedString {
        let dayStr = "\(text)¥"
        let attr = NSMutableAttributedString(string: dayStr)
        attr.addAttributes([NSFontAttributeName: HB.Font.h4], range: NSRange(location: dayStr.characters.count-1, length: 1))
        return attr
    }
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
