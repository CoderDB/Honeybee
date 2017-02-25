//
//  SetupHeader.swift
//  Honeybee
//
//  Created by Dongbing Hou on 13/02/2017.
//  Copyright © 2017 Dongbing Hou. All rights reserved.
//

import UIKit

class SetupHeader: UIView {
    
    
    lazy var headButton: UIButton = {
        let btn = UIButton(type: .custom)
        btn.backgroundColor = HonybeeColor.main
        btn.imageEdgeInsets = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        btn.setImage(UIImage(named: "avatar"), for: .normal)
        btn.layer.cornerRadius = HonybeeConstant.cornerRadius
        return btn
    }()
    
    lazy var nicknameLabel: UILabel = {
        let label = UILabel()
        label.font = HonybeeFont.h5
        label.text = "二狗哥"
        return label
    }()
    lazy var bioLabel: UILabel = {
        let label = UILabel()
        label.font = HonybeeFont.h6
        label.textColor = UIColor.gray
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        label.preferredMaxLayoutWidth = 200
        label.text = "我是一个从来不记账的人，因为记账是一种修行。我是一个从来不记账的人，因为记账是一种修行。我是一个从来不记账的人，因为记账是一种修行。"
        return label
    }()
    
    
    lazy var editButton: UIButton = {
        let btn = UIButton(type: .system)
        btn.setTitle("编辑", for: .normal)
        btn.setTitleColor(HonybeeColor.main, for: .normal)
        btn.titleLabel?.font = HonybeeFont.h5
        return btn
    }()
    
    
    convenience init(height: CGFloat) {
        self.init(frame: CGRect(x: 0, y: 0, width: 0, height: height))        
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupUI() {
        addSubview(editButton)
        addSubview(headButton)
        addSubview(nicknameLabel)
        addSubview(bioLabel)
        
        
        editButton.snp.makeConstraints { (make) in
            make.right.bottom.equalTo(self).offset(-10)
            make.width.equalTo(40)
            make.height.equalTo(25)
        }
        headButton.snp.makeConstraints { (make) in
            make.top.left.equalTo(self).offset(10)
            make.width.height.equalTo(115)
        }
        nicknameLabel.snp.makeConstraints { (make) in
            make.left.equalTo(headButton.snp.right).offset(10)
            make.top.equalTo(headButton)
            make.width.equalTo(185)
            make.height.equalTo(25)
        }
        bioLabel.snp.makeConstraints { (make) in
            make.top.equalTo(nicknameLabel.snp.bottom).offset(10)
            make.left.equalTo(nicknameLabel)
            make.right.equalTo(editButton.snp.left).offset(-5).priority(750)
            make.bottom.equalTo(headButton).offset(-10)
        } 
    }


}
