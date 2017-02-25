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
        btn.titleLabel?.font = HonybeeFont.h2
        btn.backgroundColor = UIColor.black
        btn.layer.cornerRadius = HonybeeConstant.cornerRadius
        return btn
    }()
    
    
    convenience init(height: CGFloat) {
        self.init(frame: CGRect(x: 0, y: 0, width: 0, height: height))
    }
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    override var frame: CGRect {
        didSet {
            var newFrame = frame
            newFrame.origin.y += 50 // 因为 tableView 中 cell 都往下移动了，所以这里也要移动一下，以防 button 点不到
            super.frame = newFrame
        }
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupUI() {
        button.addTarget(self, action: #selector(buttonClicked), for: .touchUpInside)
        addSubview(button)
        button.snp.makeConstraints { (make) in
            make.left.equalTo(self).offset(10)
            make.right.equalTo(self).offset(-10).priority(750)
            make.top.bottom.equalTo(self)
        }
    }
    
    func buttonClicked() {
        print("----buttonClicked")
    }
        

}
