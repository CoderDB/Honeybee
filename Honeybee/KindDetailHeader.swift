//
//  KindDetailHeader.swift
//  Honeybee
//
//  Created by Dongbing Hou on 08/03/2017.
//  Copyright © 2017 Dongbing Hou. All rights reserved.
//

import UIKit

class KindDetailHeader: BaseHeader {

    lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.font = HB.Font.h1
        label.textAlignment = .center
        label.textColor = UIColor.white
        return label
    }()
    
    override func setupUI() {
        super.setupUI()
        
        rightBtn.setTitle("保存", for: .normal)
        containerView.addSubview(titleLabel)
        
        containerView.backgroundColor = HB.Color.main
        
        titleLabel.snp.makeConstraints { (make) in
            make.center.equalTo(containerView)
        }
    }

}
