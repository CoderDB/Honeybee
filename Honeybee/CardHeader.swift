//
//  CardHeader.swift
//  Honeybee
//
//  Created by Dongbing Hou on 05/03/2017.
//  Copyright © 2017 Dongbing Hou. All rights reserved.
//

import UIKit

class CardHeader: UIView {
    
    lazy var imgView = UIImageView(image: UIImage(named: "meal"))
    
    lazy var categoryLabel: UILabel = {
        let label = UILabel()
        label.font = HonybeeFont.h3
        label.text = "未填写"
        return label
    }()
    lazy var numberLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .right
        label.font = HonybeeFont.h2_number
        label.text = "98765.39"
        return label
    }()
    
    lazy var containView: UIView = {
        let view = UIView()
        view.layer.cornerRadius = HonybeeConstant.cornerRadius
        view.isUserInteractionEnabled = false
        view.backgroundColor = HonybeeColor.main
        return view
    }()
    
    lazy var editButton: UIButton = {
        let btn = UIButton(type: .system)
        btn.setTitle("编辑", for: .normal)
        btn.setTitleColor(HonybeeColor.main, for: .normal)
        btn.titleLabel?.font = HonybeeFont.h5
        return btn
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupUI() {
        addSubview(editButton)
        addSubview(containView)
        containView.addSubview(imgView)
        containView.addSubview(categoryLabel)
        containView.addSubview(numberLabel)
        
        
        editButton.snp.makeConstraints { (make) in
            make.right.equalTo(self).offset(-10)
            make.bottom.equalTo(self)
        }
        containView.snp.makeConstraints { (make) in
            make.top.bottom.equalTo(self)
            make.left.equalTo(self).offset(10)
            make.right.equalTo(editButton.snp.left).offset(-10).priority(HonybeePriority.mid)
        }
        
        imgView.snp.makeConstraints { (make) in
            make.left.top.equalTo(10)
            make.width.height.equalTo(50)
        }
        categoryLabel.snp.makeConstraints { (make) in
            make.left.equalTo(imgView.snp.right).offset(10)
            make.centerY.equalTo(imgView)
        }
        numberLabel.snp.makeConstraints { (make) in
            make.right.bottom.equalTo(containView)
        }
    }

}
