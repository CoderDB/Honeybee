//
//  RecordLiteCell.swift
//  Honeybee
//
//  Created by Dongbing Hou on 11/02/2017.
//  Copyright © 2017 Dongbing Hou. All rights reserved.
//

import UIKit

class RecordLiteCell: UITableViewCell {
    
    lazy var category: UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        label.font = HonybeeFont.h4
        label.textColor = UIColor.black
        label.text = "购物"
        return label
    }()
    lazy var number: UILabel = {
        let label = UILabel()
        label.textAlignment = .right
        label.font = HonybeeFont.h1_number
        label.textColor = UIColor.black
        label.text = "98456.87"
        return label
    }()
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        layer.cornerRadius = 10
        backgroundColor = UIColor.brown
        
        setupUI()
    }
    
    override var frame: CGRect {
        didSet {
            var newFrame = frame
            newFrame.origin.x += 10
            newFrame.origin.y += 10
            newFrame.size = CGSize(width: frame.width-20, height: frame.height-20)
            super.frame = newFrame
        }
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    func setupUI() {
        contentView.addSubview(category)
        contentView.addSubview(number)
        
        category.snp.makeConstraints { (make) in
            make.centerY.equalTo(contentView.snp.centerY)
            make.left.equalTo(contentView).offset(10)
            make.width.equalTo(100)
            make.height.equalTo(40)
        }
        
        number.snp.makeConstraints { (make) in
            make.left.equalTo(category.snp.right).offset(20)
            make.centerY.equalTo(category.snp.centerY)
            make.width.equalTo(200)
            make.height.equalTo(40)
            make.bottom.equalTo(contentView.snp.bottom).offset(-20)
        }
        
    }
}

