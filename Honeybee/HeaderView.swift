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
        btn.setTitle("二狗哥", for: .normal)
        btn.setTitleColor(UIColor.black, for: .normal)
        btn.titleLabel?.font = HonybeeFont.h1
        btn.contentHorizontalAlignment = .left
        return btn
    }()
    lazy var userImgView: UIImageView = {
        let imgView = UIImageView(image: UIImage(named: "avatar"))
        imgView.layer.cornerRadius = 10
        imgView.layer.masksToBounds = true
        return imgView
    }()
    
    lazy var filterBtn: UIButton = {
        let btn = UIButton(type: .custom)
        btn.setTitle("分类", for: .normal)
        btn.setTitleColor(HonybeeColor.main, for: .normal)
        btn.titleLabel?.font = HonybeeFont.h4
        btn.contentHorizontalAlignment = .left
        return btn
    }()
    
    lazy var containerView: UIView = {
        let view = UIView()
        view.backgroundColor = HonybeeColor.main
        view.layer.cornerRadius = 10
        return view
    }()

    
    
    
    override init(frame: CGRect) {
        super.init(frame: CGRect(x: 0, y: 0, width: 0, height: 205))
        
        setupUI()
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    
    
    func setupUI() {
        usernameBtn.addTarget(self, action: #selector(usernameBtnClicked), for: .touchUpInside)
        
        addSubview(usernameBtn)
        addSubview(userImgView)
        addSubview(filterBtn)
        addSubview(containerView)
        
        usernameBtn.snp.makeConstraints { (make) in
            make.left.equalTo(self).offset(10)
            make.top.equalTo(self)
        }
        userImgView.snp.makeConstraints { (make) in
            make.left.equalTo(usernameBtn.snp.right).offset(10)
            make.centerY.equalTo(usernameBtn)
            make.height.width.equalTo(40)
        }
        filterBtn.snp.makeConstraints { (make) in
            make.right.bottom.equalTo(self).offset(-10)
        }
        containerView.snp.makeConstraints { (make) in
            make.left.equalTo(usernameBtn)
            make.top.equalTo(usernameBtn.snp.bottom)
            make.bottom.equalTo(self).offset(-10)
            make.right.equalTo(filterBtn.snp.left).offset(-10).priority(HonybeePriority.low)
        }
    }
    
    var usernameAction: (() -> ())?
    func usernameBtnClicked() {
        usernameAction?()
    }

}
