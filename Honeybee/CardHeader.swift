//
//  CardHeader.swift
//  Honeybee
//
//  Created by Dongbing Hou on 05/03/2017.
//  Copyright © 2017 Dongbing Hou. All rights reserved.
//

import UIKit

class CardHeader: BaseHeader {
    
    lazy var imgView = UIImageView(image: UIImage(named: "meal"))
    
    lazy var categoryLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.font = HB.Font.h3
        label.text = "未填写"
        return label
    }()
    lazy var numberLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.textAlignment = .right
        label.font = HB.Font.h2_number
        label.text = "98765.39"
        return label
    }()
    
    override func setupUI() {
        super.setupUI()
        
        rightBtn.setTitle("编辑", for: .normal)
        containerView.backgroundColor = HB.Color.main
        
        containerView.addSubview(imgView)
        containerView.addSubview(categoryLabel)
        containerView.addSubview(numberLabel)
        
        imgView.snp.makeConstraints { (make) in
            make.left.top.equalTo(10)
            make.width.height.equalTo(50)
        }
        categoryLabel.snp.makeConstraints { (make) in
            make.left.equalTo(imgView.snp.right).offset(10)
            make.centerY.equalTo(imgView)
        }
        numberLabel.snp.makeConstraints { (make) in
            make.bottom.equalTo(containerView)
            make.right.equalTo(containerView).offset(-5)
        }
    }

}
