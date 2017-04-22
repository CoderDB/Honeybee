//
//  IncomeCell.swift
//  Honeybee
//
//  Created by Dongbing Hou on 22/04/2017.
//  Copyright © 2017 Dongbing Hou. All rights reserved.
//

import UIKit

class IncomeCell: UICollectionViewCell {
    lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.font = HB.Font.h3
        label.textAlignment = .center
        label.textColor = .white
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        layer.cornerRadius = HB.Constant.cornerRadius
        setupUI()
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func config(model: HoneybeeKind) {
        titleLabel.text = model.name
        backgroundColor = UIColor(hex: model.color)
    }
    
    
    func setupUI() {
        
        contentView.addSubview(titleLabel)
        titleLabel.snp.makeConstraints { (make) in
            make.width.lessThanOrEqualTo(100)
            make.center.equalTo(contentView)
        }
    }
}
