//
//  BarCell.swift
//  Honeybee
//
//  Created by Dongbing Hou on 22/02/2017.
//  Copyright © 2017 Dongbing Hou. All rights reserved.
//

import UIKit

class BarCell: UITableViewCell {
    lazy var imgView = UIImageView(image: UIImage(named: "meal"))
    lazy var mainTopTitleLabel: UILabel = {
        let label = UILabel()
        label.font = HonybeeFont.h4
        return label
    }()
    lazy var mainBottomTitleLabel: UILabel = {
        let label = UILabel()
        label.font = HonybeeFont.h4_number
        return label
    }()
    lazy var subTitleLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .right
        label.font = HonybeeFont.h3_number
        return label
    }()
    lazy var arrow = UIImageView(image: UIImage(named: "rightArrow"))
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        layer.cornerRadius = 10
        layer.borderWidth = 1
        setupUI()
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    override var frame: CGRect {
        didSet {
            var newFrame = frame
            newFrame.origin.x += 10
            newFrame.origin.y += 20
            newFrame.size = CGSize(width: frame.width-20, height: frame.height-10)
            super.frame = newFrame
        }
    }
    var item: SetupItem! {
        didSet {
            mainTopTitleLabel.text = "星期六"
            mainBottomTitleLabel.text = "02-18"
            subTitleLabel.text = item.subTitle
        }
    }
    func setupUI() {
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
