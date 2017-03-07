//
//  IconAddCell.swift
//  Honeybee
//
//  Created by Dongbing Hou on 25/02/2017.
//  Copyright © 2017 Dongbing Hou. All rights reserved.
//

import UIKit

class IconAddCell: UICollectionViewCell {
    
    lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.font = HB.Font.h1
        label.textAlignment = .center
        label.textColor = UIColor.white
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = UIColor.randomColor()
        layer.cornerRadius = HB.Constant.cornerRadius
        
        contentView.addSubview(titleLabel)
        titleLabel.snp.makeConstraints { (make) in
            make.edges.equalTo(contentView)
        }
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
