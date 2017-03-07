//
//  KindAddHeader.swift
//  Honeybee
//
//  Created by Dongbing Hou on 07/03/2017.
//  Copyright © 2017 Dongbing Hou. All rights reserved.
//

import UIKit

class BaseHeader: UIView {
    lazy var containerView: UIView = {
        let view = UIView()
        view.layer.cornerRadius = HB.Constant.cornerRadius
        return view
    }()
    
    lazy var rightBtn: UIButton = {
        let btn = UIButton()
        btn.setTitle("编辑", for: .normal)
        btn.setTitleColor(HB.Color.nav, for: .normal)
        btn.titleLabel?.font = HB.Font.h5
        return btn
    }()
    func setupUI() {
        addSubview(rightBtn)
        addSubview(containerView)
        
        rightBtn.snp.makeConstraints { (make) in
            make.right.equalTo(self).offset(-10)
            make.bottom.equalTo(self)
        }
        containerView.snp.makeConstraints { (make) in
            make.top.bottom.equalTo(self)
            make.left.equalTo(self).offset(10)
            make.right.equalTo(rightBtn.snp.left).offset(-10).priority(HB.Priority.mid)
        }
    }
}

class KindAddHeader: BaseHeader {

    
    lazy var titleBtn: UIButton = {
        let btn = UIButton()
        btn.setTitle("衣食住行", for: .normal)
        btn.setTitleColor(UIColor.white, for: .normal)
        btn.titleLabel?.font = HB.Font.h1
        return btn
    }()
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func setupUI() {
        super.setupUI()
        
        containerView.backgroundColor = HB.Color.main
        containerView.addSubview(titleBtn)
        titleBtn.snp.makeConstraints { (make) in
            make.center.equalTo(containerView)
        }
    }
}
