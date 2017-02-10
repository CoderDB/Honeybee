//
//  RecordCell.swift
//  Honeybee
//
//  Created by Dongbing Hou on 08/02/2017.
//  Copyright © 2017 Dongbing Hou. All rights reserved.
//

import UIKit
import SnapKit

class RecordCell: UITableViewCell {
    
    lazy var imgView = UIImageView(image: UIImage(named: "meal"))
    
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
    lazy var numberLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .right
        label.font = Honybee.recordNumberFont
        label.textColor = UIColor.black
        label.text = "256.80"
        return label
    }()
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupUI() {
        contentView.addSubview(imgView)
        contentView.addSubview(dateLabel)
        contentView.addSubview(categoryLabel)
        contentView.addSubview(numberLabel)
        
        imgView.snp.makeConstraints { (make) in
            make.left.top.equalTo(contentView).offset(10)
            make.width.height.equalTo(45)
        }
        
        dateLabel.snp.makeConstraints { (make) in
            make.top.equalTo(imgView)
            make.bottom.equalTo(imgView.snp.centerY)
            make.left.equalTo(imgView.snp.right).offset(10)
            make.width.equalTo(100)
        }
        categoryLabel.snp.makeConstraints { (make) in
            make.top.equalTo(dateLabel.snp.bottom)
            make.bottom.equalTo(imgView.snp.bottom)
            make.left.width.equalTo(dateLabel)
        }
        numberLabel.snp.makeConstraints { (make) in
            make.right.equalTo(contentView.snp.right).offset(-10)
            make.left.equalTo(categoryLabel.snp.right)
            make.centerY.equalTo(contentView.snp.centerY)
            
            make.height.equalTo(45)
        }
    }
}
