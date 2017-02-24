//
//  IconManagerSectionHeader.swift
//  Honeybee
//
//  Created by Dongbing Hou on 24/02/2017.
//  Copyright © 2017 Dongbing Hou. All rights reserved.
//

import UIKit

class IconManagerSectionHeader: UICollectionReusableView {
    
    
    lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.text = "衣食住行"
        label.font = HonybeeFont.h2
        return label
    }()
    
    lazy var line: UIView = {
        let view = UIView()
        view.backgroundColor = HonybeeColor.main
        return view
    }()
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = UIColor.white
        addSubview(titleLabel)
//        addSubview(line)
        titleLabel.snp.makeConstraints { (make) in
            make.left.equalTo(self).offset(10)
            make.centerY.equalTo(self)
        }
//        line.snp.makeConstraints { (make) in
//            make.left.equalTo(self).offset(10)
//            make.right.bottom.equalTo(self)
//            make.height.equalTo(1)
//        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
