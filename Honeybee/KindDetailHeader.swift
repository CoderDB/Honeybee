//
//  KindDetailHeader.swift
//  Honeybee
//
//  Created by Dongbing Hou on 08/03/2017.
//  Copyright © 2017 Dongbing Hou. All rights reserved.
//

import UIKit

class KindDetailHeader: BaseHeader {

    lazy var titleLabel: UILabel = {
        $0.font = HB.Font.h1
        $0.textAlignment = .center
        $0.textColor = .white
        $0.layer.cornerRadius = HB.Constant.cornerRadius
        $0.layer.masksToBounds = true
        $0.backgroundColor = HB.Color.main
        $0.text = "衣"
        return $0
    }(UILabel())
    
    lazy var deleteBtn: UIButton = {
        $0.setTitle("删除", for: .normal)
        $0.setTitle("完成", for: .selected)
        $0.setTitleColor(.white, for: .normal)
        $0.titleLabel?.font = HB.Font.h5
        $0.backgroundColor = HB.Color.main
        $0.layer.cornerRadius = HB.Constant.cornerRadius
        return $0
    }(UIButton())
    
    lazy var addBtn: UIButton = {
        $0.setTitle("添加", for: .normal)
        $0.setTitleColor(.white, for: .normal)
        $0.titleLabel?.font = HB.Font.h5
        $0.backgroundColor = HB.Color.nav
        $0.layer.cornerRadius = HB.Constant.cornerRadius
        return $0
    }(UIButton())
    
    override func setupUI() {
        super.setupUI()
        
        containerView.addSubview(addBtn)
        containerView.addSubview(deleteBtn)
        containerView.addSubview(titleLabel)
        
        addBtn.addTarget(self, action: #selector(addBtnClicked), for: .touchUpInside)
        deleteBtn.addTarget(self, action: #selector(deleteBtnClicked(_:)), for: .touchUpInside)
        addBtn.snp.makeConstraints { (make) in
            make.top.right.equalTo(containerView)
            make.width.equalTo(100)
            make.height.equalTo(55)
        }
        
        deleteBtn.snp.makeConstraints { (make) in
            make.right.bottom.equalTo(containerView)
            make.width.height.equalTo(addBtn)
        }
        
        titleLabel.snp.makeConstraints { (make) in
            make.left.top.bottom.equalTo(containerView)
            make.right.equalTo(addBtn.snp.left).offset(-10)
        }
    }

    var addNewItemAction: (() -> Void)?
    @objc private func addBtnClicked() {
        addNewItemAction?()
    }
    var deleteBtnAction: ((UIButton) -> Void)?
    @objc private func deleteBtnClicked(_ btn: UIButton) {
        btn.isSelected = !btn.isSelected
        deleteBtnAction?(btn)
    }
    
    
}
