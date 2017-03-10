//
//  KindAddItemHeader.swift
//  Honeybee
//
//  Created by Dongbing Hou on 10/03/2017.
//  Copyright © 2017 Dongbing Hou. All rights reserved.
//

import UIKit

class KindAddItemHeader: BaseHeader {

    lazy var titleBtn: UIButton = {
        $0.setTitle("衣食住行", for: .normal)
        $0.setTitleColor(UIColor.white, for: .normal)
        $0.titleLabel?.font = HB.Font.h1
        return $0
    }(UIButton())
    
    lazy var imgView = UIImageView()
    
    
    override func setupUI() {
        super.setupUI()
        
        containerView.backgroundColor = HB.Color.main
        containerView.addSubview(titleBtn)
        containerView.addSubview(imgView)
        
        titleBtn.snp.makeConstraints { (make) in
            make.center.equalTo(containerView)
        }
        imgView.snp.makeConstraints { (make) in
            make.left.equalTo(titleBtn.snp.right)
            make.centerY.equalTo(containerView)
            make.width.height.equalTo(90)
        }
    }

}
