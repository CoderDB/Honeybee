//
//  HeaderView.swift
//  Honeybee
//
//  Created by Dongbing Hou on 08/02/2017.
//  Copyright © 2017 Dongbing Hou. All rights reserved.
//

import UIKit
import SnapKit

class HeaderView: UIView {
    
    
    lazy var usernameBtn: UIButton = {
        let btn = UIButton(type: .custom)
//        btn.backgroundColor = UIColor.cyan
        btn.setTitle("二狗哥", for: .normal)
        btn.setTitleColor(UIColor.black, for: .normal)
        btn.titleLabel?.font = HonybeeFont.titleFont
        btn.contentHorizontalAlignment = .left
        return btn
    }()
    
    lazy var filterBtn: UIButton = {
        let btn = UIButton(type: .custom)
//        btn.backgroundColor = UIColor.cyan
        btn.setTitle("分类", for: .normal)
        btn.setTitleColor(HonybeeColor.mainColor, for: .normal)
        btn.titleLabel?.font = HonybeeFont.subTitleFont
        btn.contentHorizontalAlignment = .left
        return btn
    }()

    override init(frame: CGRect) {
        super.init(frame: CGRect(x: 0, y: 0, width: ScreenW, height: 80))
        setupUI()
    }
    
    
    func setupUI() {
        addSubview(usernameBtn)
        addSubview(filterBtn)
        
        usernameBtn.snp.makeConstraints { (make) in
            make.left.equalTo(self).offset(10)
            make.top.equalTo(self).offset(10)
            make.width.equalTo(200)
            make.height.equalTo(50)
        }
        filterBtn.snp.makeConstraints { (make) in
            make.right.equalTo(self).offset(-10)
            make.bottom.equalTo(usernameBtn)
            make.width.equalTo(40)
            make.height.equalTo(30)
        }
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
