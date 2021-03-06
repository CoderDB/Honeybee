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
        $0.text = "--"
        return $0
    }(UILabel())
    
    override func setupUI() {
        super.setupUI()
//        containerView.backgroundColor = HB.Color.main
        containerView.addSubview(titleLabel)
        
        titleLabel.snp.makeConstraints { (make) in
            make.edges.equalTo(containerView)
        }
    }
}
