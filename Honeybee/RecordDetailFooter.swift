//
//  RecordDetailFooter.swift
//  Honeybee
//
//  Created by Dongbing Hou on 13/02/2017.
//  Copyright © 2017 Dongbing Hou. All rights reserved.
//

import UIKit

class RecordDetailFooter: UIView {

    
    lazy var button: UIButton = {
        let btn = UIButton(type: UIButtonType.system)
        btn.setTitle("删除", for: .normal)
        btn.setTitleColor(UIColor.white, for: .normal)
        btn.titleLabel?.font = HonybeeFont.h1
        btn.backgroundColor = UIColor.black
        btn.layer.cornerRadius = 10
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
        addSubview(button)
        button.snp.makeConstraints { (make) in
            make.top.equalTo(self).offset(40)
            make.left.equalTo(self).offset(10)
            make.right.equalTo(self).offset(-10).priority(750)
            make.height.equalTo(50)
        }
    }
        

}
