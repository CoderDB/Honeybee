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
        let btn = UIButton(type: .custom)
        btn.backgroundColor = HB.Color.nav
        btn.imageEdgeInsets = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        btn.setImage(UIImage(named: "avatar"), for: .normal)
        btn.layer.cornerRadius = HB.Constant.cornerRadius
        return btn
    }()
    
    lazy var nicknameLabel: UILabel = {
        let label = UILabel()
        label.font = HB.Font.h5
        label.text = "二狗哥"
        return label
    }()
    lazy var bioLabel: UILabel = {
        let label = UILabel()
        label.font = HB.Font.h6_medium
        label.textColor = .gray
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        label.preferredMaxLayoutWidth = 200
        label.text = "我是一个从来不记账的人，因为记账是一种修行。我是一个从来不记账的人，因为记账是一种修行。我是一个从来不记账的人，因为记账是一种修行。"
        return label
    }()
    
    
    
//    convenience init(height: CGFloat) {
//        self.init(frame: CGRect(x: 0, y: 0, width: 0, height: height))        
//    }
//    
//    override init(frame: CGRect) {
//        super.init(frame: frame)
//        setupUI()
//    }
//    required init?(coder aDecoder: NSCoder) {
//        fatalError("init(coder:) has not been implemented")
//    }
    
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
