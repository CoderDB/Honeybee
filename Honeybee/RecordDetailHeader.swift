//
//  RecordDetailHeader.swift
//  Honeybee
//
//  Created by Dongbing Hou on 12/02/2017.
//  Copyright © 2017 Dongbing Hou. All rights reserved.
//

import UIKit

class RecordDetailHeader: BaseHeader {
    
    
    lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.textColor = UIColor.white
        label.font = HB.Font.h3
        return label
    }()
    lazy var imgView = UIImageView()
    

    convenience init(height: CGFloat, title: String?, imageName: String, color: String) {
        self.init(frame: CGRect(x: 0, y: 0, width: 0, height: height)) // width = 0,以 tableHeaderView 设置的 header 宽度一定是 tableView 的宽度
        
        titleLabel.text = title ?? nil
        imgView.image = UIImage(named: imageName)
        containerView.backgroundColor = UIColor(hex: color)
    }
    
    override func setupUI() {
        super.setupUI()
        
        rightBtn.setTitle("编辑", for: .normal)
        containerView.isUserInteractionEnabled = false

        containerView.addSubview(imgView)
        containerView.addSubview(titleLabel)
        
        titleLabel.snp.makeConstraints { (make) in
            make.left.top.equalTo(containerView).offset(10)
        }
        imgView.snp.makeConstraints { (make) in
            make.center.equalTo(containerView)
            make.width.height.equalTo(containerView.snp.height).offset(-20)
        }
        
    }
}
