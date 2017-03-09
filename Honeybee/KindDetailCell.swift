//
//  KindDetailCell.swift
//  Honeybee
//
//  Created by Dongbing Hou on 09/03/2017.
//  Copyright © 2017 Dongbing Hou. All rights reserved.
//

import UIKit

class KindDetailCell: UICollectionViewCell {
    
    
    lazy var imgView = UIImageView(image: UIImage(named: "meal"))
    lazy var deleteBtn: UIButton = {
        let btn = UIButton()
        btn.isHidden = true
        btn.setImage(UIImage(named: "delete_collv"), for: .normal)
        return btn
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        layer.cornerRadius = 5.0
        layer.borderColor = UIColor.gray.cgColor
        layer.borderWidth = 1.0
        layer.borderWidth = 0
        initialized()
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func initialized() {
        addSubview(imgView)
        addSubview(deleteBtn)
        deleteBtn.snp.makeConstraints { (make) in
            make.top.equalTo(5)
            make.right.equalTo(-5)
            make.width.height.equalTo(10)
        }
        imgView.snp.makeConstraints { (make) in
            make.center.equalTo(self)
            make.width.height.equalTo(45)
        }
    }
}
