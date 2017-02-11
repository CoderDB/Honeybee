//
//  GroupCell.swift
//  Honeybee
//
//  Created by Dongbing Hou on 11/02/2017.
//  Copyright © 2017 Dongbing Hou. All rights reserved.
//

import UIKit

class GroupCell: UITableViewCell {

    lazy var dateLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        label.font = Honybee.recordDateFont
        label.textColor = UIColor.black
        label.text = "2月10日"
        return label
    }()
    lazy var weekdayLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .right
        label.font = Honybee.weekFont
        label.textColor = UIColor.black
        label.text = "星期二"
        return label
    }()
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        layer.cornerRadius = 10
        layer.borderWidth = 3
        
        backgroundColor = UIColor.orange
        
        setupUI()
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
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
    
    func setupUI() {
        contentView.addSubview(dateLabel)
        contentView.addSubview(weekdayLabel)
        
        dateLabel.snp.makeConstraints { (make) in
            make.left.top.equalTo(contentView).offset(10)
            make.width.equalTo(100)
            make.height.equalTo(30)
        }
        weekdayLabel.snp.makeConstraints { (make) in
            make.top.equalTo(contentView).offset(10)
            make.right.equalTo(contentView).offset(-10)
            make.width.equalTo(40)
            make.height.equalTo(20)
        }
    }


}
