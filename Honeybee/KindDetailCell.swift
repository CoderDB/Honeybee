//
//  KindDetailCell.swift
//  Honeybee
//
//  Created by Dongbing Hou on 09/03/2017.
//  Copyright © 2017 Dongbing Hou. All rights reserved.
//

import UIKit

class KindDetailCell: BaseCollectionViewCell {
    
    
    lazy var deleteBtn: UIButton = {
        let btn = UIButton()
        btn.isHidden = true
        btn.setImage(UIImage(named: "delete_collv"), for: .normal)
        return btn
    }()
    override func initialized() {
        layer.cornerRadius = 5.0
        layer.borderColor = UIColor.lightGray.cgColor
        layer.borderWidth = 1.0
        super.initialized()
        
        contentView.addSubview(deleteBtn)
        deleteBtn.snp.makeConstraints { (make) in
            make.top.equalTo(5)
            make.right.equalTo(-5)
            make.width.height.equalTo(10)
        }
    }
    
    func configWith(model: HoneybeeItem) {
        titleLabel.text = model.name
        imgView.image = UIImage(named: model.icon)
    }
}

