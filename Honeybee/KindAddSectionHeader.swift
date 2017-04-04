//
//  KindAddSectionHeader.swift
//  Honeybee
//
//  Created by Dongbing Hou on 04/04/2017.
//  Copyright © 2017 Dongbing Hou. All rights reserved.
//

import UIKit

class KindAddSectionHeader: UICollectionReusableView {

    lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.font = HB.Font.h3
        return label
    }()
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .white
        addSubview(titleLabel)
        titleLabel.snp.makeConstraints { (make) in
            make.left.centerY.equalTo(self)
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }


}
