//
//  PieCell.swift
//  Honeybee
//
//  Created by Dongbing Hou on 22/02/2017.
//  Copyright © 2017 Dongbing Hou. All rights reserved.
//

import UIKit

class PieCell: UITableViewCell {
    
    lazy var mainTitleLabel: UILabel = {
        let label = UILabel()
        label.font = HonybeeFont.h2
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
            mainTitleLabel.text = item.title
            subTitleLabel.text = item.subTitle
        }
    }
    func setupUI() {
        contentView.addSubview(mainTitleLabel)
        contentView.addSubview(subTitleLabel)
        
        mainTitleLabel.snp.makeConstraints { (make) in
            make.centerY.equalTo(contentView)
            make.left.equalTo(contentView).offset(10)
        }
        subTitleLabel.snp.makeConstraints { (make) in
            make.right.centerY.equalTo(contentView)
        }
        accessoryView = arrow
    }
    

}
