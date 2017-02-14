//
//  RecordDetailHeader.swift
//  Honeybee
//
//  Created by Dongbing Hou on 12/02/2017.
//  Copyright © 2017 Dongbing Hou. All rights reserved.
//

import UIKit

class RecordDetailHeader: UIView {
    
    
    lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.textColor = UIColor.white
        label.font = HonybeeFont.h2
        return label
    }()
    lazy var editButton: UIButton = {
        let btn = UIButton(type: UIButtonType.system)
        btn.setTitle("编辑", for: .normal)
        btn.setTitleColor(HonybeeColor.main, for: .normal)
        btn.titleLabel?.font = HonybeeFont.h4
        return btn
    }()
    lazy var imgView = UIImageView()
    
    lazy var containerView: UIView = {
        let view = UIView()
        view.layer.cornerRadius = 10
        view.backgroundColor = UIColor.cyan
        view.isUserInteractionEnabled = false
        return view
    }()
    
    

    convenience init(height: CGFloat, title: String?, imageName: String) {
        self.init(frame: CGRect(x: 0, y: 0, width: 0, height: height)) // width = 0,以 tableHeaderView 设置的 header 宽度一定是 tableView 的宽度
        
        titleLabel.text = title ?? nil
        imgView.image = UIImage(named: imageName)
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
        addSubview(containerView)
        containerView.addSubview(imgView)
        containerView.addSubview(titleLabel)
        
        
        editButton.snp.makeConstraints { (make) in
            make.right.bottom.equalTo(self).offset(-10)
            make.width.equalTo(40)
            make.height.equalTo(25)
        }
        containerView.snp.makeConstraints { (make) in
            make.top.bottom.equalTo(self)
            make.left.equalTo(self).offset(10)
            make.right.equalTo(editButton.snp.left).offset(-10).priority(HonybeePriority.mid)
        }
        imgView.snp.makeConstraints { (make) in
            make.center.equalTo(containerView)
            make.width.height.equalTo(containerView.snp.height).offset(-20)
        }
        
        titleLabel.snp.makeConstraints { (make) in
            make.left.top.equalTo(containerView).offset(10)
            make.height.equalTo(45)
            make.width.equalTo(60)
        }
        
    }
}
