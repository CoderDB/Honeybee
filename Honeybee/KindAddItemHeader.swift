//
//  KindAddItemHeader.swift
//  Honeybee
//
//  Created by Dongbing Hou on 10/03/2017.
//  Copyright © 2017 Dongbing Hou. All rights reserved.
//

import UIKit
import Then

class KindAddItemHeader: BaseHeader {
    
    lazy var titleLabel = UILabel().then {
        $0.font = HB.Font.h3
        $0.textColor = .white
        $0.text = "衣食住行"
    }
    
    lazy var imgView = UIImageView(image: UIImage(named: "meal"))
    
    
    override func setupUI() {
        super.setupUI()
        rightBtn.setTitle("编辑", for: .normal)
        containerView.backgroundColor = HB.Color.main
        
        containerView.addSubview(titleLabel)
        containerView.addSubview(imgView)
        
        titleLabel.snp.makeConstraints { (make) in
            make.left.top.equalTo(containerView).offset(10)
        }
        // TODO: priority
        imgView.snp.makeConstraints { (make) in
            make.left.equalTo(titleLabel.snp.right).offset(10).priority(HB.Priority.low)
            make.centerY.equalTo(containerView)
            make.width.height.equalTo(90)
        }
    }

}
