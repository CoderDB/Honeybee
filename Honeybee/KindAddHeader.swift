//
//  KindAddHeader.swift
//  Honeybee
//
//  Created by Dongbing Hou on 07/03/2017.
//  Copyright © 2017 Dongbing Hou. All rights reserved.
//

import UIKit

class KindAddHeader: BaseHeader {
    
    lazy var titleLabel: UILabel = {
        $0.font = HB.Font.h1
        $0.textAlignment = .center
        $0.textColor = .white
        $0.layer.cornerRadius = HB.Constant.cornerRadius
        $0.layer.masksToBounds = true
        $0.backgroundColor = HB.Color.main
        $0.text = "衣"
        return $0
    }(UILabel())
    
    override func setupUI() {
        super.setupUI()
        
        rightBtn.setTitle("编辑", for: .normal)
        containerView.addSubview(titleLabel)
        
        titleLabel.snp.makeConstraints { (make) in
            make.edges.equalTo(containerView)
        }
    }
}
