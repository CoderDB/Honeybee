//
//  KindAddHeader.swift
//  Honeybee
//
//  Created by Dongbing Hou on 07/03/2017.
//  Copyright © 2017 Dongbing Hou. All rights reserved.
//

import UIKit

class KindAddHeader: BaseHeader {

    
    lazy var titleBtn: UIButton = {
        let btn = UIButton()
        btn.setTitle("衣食住行", for: .normal)
        btn.setTitleColor(UIColor.white, for: .normal)
        btn.titleLabel?.font = HB.Font.h1
        return btn
    }()
    
    
    override func setupUI() {
        super.setupUI()
        
        containerView.backgroundColor = HB.Color.main
        containerView.addSubview(titleBtn)
        titleBtn.snp.makeConstraints { (make) in
            make.center.equalTo(containerView)
        }
    }
}
