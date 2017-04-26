//
//  AccountBindHeader.swift
//  Honeybee
//
//  Created by Dongbing Hou on 26/04/2017.
//  Copyright © 2017 Dongbing Hou. All rights reserved.
//

import UIKit

class AccountBindHeader: UIView {

    
    lazy var iconImgView: UIImageView = {
        $0.image = UIImage.image(color: HB.Color.main)
        $0.layer.cornerRadius = HB.Constant.cornerRadius
        $0.layer.masksToBounds = true
        return $0
    }(UIImageView())
    lazy var describeLabel: UILabel = {
        $0.font = HB.Font.h6_medium
        $0.textColor = .gray
        $0.text = "绑定账号可以多平台数据同步"
        return $0
    }(UILabel())
    
    convenience init(height: CGFloat) {
        self.init(frame: CGRect(x: 0, y: 0, width: HB.Screen.w, height: height))
    }
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    func setupUI() {
        addSubview(iconImgView)
        addSubview(describeLabel)
        
        iconImgView.snp.makeConstraints { (make) in
            make.center.equalTo(self)
            make.width.height.equalTo(100)
        }
        describeLabel.snp.makeConstraints { (make) in
            make.left.equalTo(self).offset(10)
            make.bottom.equalTo(self)
        }
    }


}
