//
//  SetupHeader.swift
//  Honeybee
//
//  Created by Dongbing Hou on 13/02/2017.
//  Copyright © 2017 Dongbing Hou. All rights reserved.
//

import UIKit

class SetupHeader: BaseHeader {
    
    
    lazy var headButton: UIButton = {
        $0.backgroundColor = HB.Color.nav
        $0.imageEdgeInsets = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        $0.setImage(UIImage(named: "avatar"), for: .normal)
        $0.layer.cornerRadius = HB.Constant.cornerRadius
        return $0
    }(UIButton())
    
    lazy var nicknameLabel: UILabel = {
        $0.font = HB.Font.h5
        $0.text = "二狗哥"
        return $0
    }(UILabel())
    lazy var bioLabel: UILabel = {
        $0.font = HB.Font.h6_medium
        $0.textColor = .gray
        $0.numberOfLines = 0
        $0.lineBreakMode = .byWordWrapping
        $0.preferredMaxLayoutWidth = 200
        $0.text = "我是一个从来不记账的人，因为记账是一种修行。我是一个从来不记账的人，因为记账是一种修行。我是一个从来不记账的人，因为记账是一种修行。"
        return $0
    }(UILabel())
    
    
    override func setupUI() {
        super.setupUI()
        
        containerView.addSubview(headButton)
        containerView.addSubview(nicknameLabel)
        containerView.addSubview(bioLabel)
        
        
        headButton.snp.makeConstraints { (make) in
            make.top.left.equalTo(containerView)
            make.width.height.equalTo(115)
        }
        nicknameLabel.snp.makeConstraints { (make) in
            make.top.equalTo(headButton)
            make.left.equalTo(headButton.snp.right).offset(10)
            make.right.equalTo(containerView)
            make.height.equalTo(25)
        }
        bioLabel.snp.makeConstraints { (make) in
            make.left.right.equalTo(nicknameLabel)
            make.top.equalTo(nicknameLabel.snp.bottom).offset(10)
            make.bottom.equalTo(headButton).offset(-10)
        }
    }
}
