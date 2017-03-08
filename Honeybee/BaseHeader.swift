//
//  BaseHeader.swift
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
        view.isUserInteractionEnabled = false
        return view
    }()
    lazy var rightBtn: UIButton = {
        let btn = UIButton()
        btn.setTitleColor(HB.Color.nav, for: .normal)
        btn.titleLabel?.font = HB.Font.h5
        btn.contentHorizontalAlignment = .right
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
        addSubview(rightBtn)
        addSubview(containerView)
        
        rightBtn.addTarget(self, action: #selector(rightBtnClicked(_:)), for: .touchUpInside)
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
    var rightButtonAction: ((UIButton) -> ())?
    func rightBtnClicked(_ btn: UIButton) {
        rightButtonAction?(btn)
    }
}
