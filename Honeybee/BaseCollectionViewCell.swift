//
//  BaseCollectionViewCell.swift
//  Honeybee
//
//  Created by Dongbing Hou on 09/03/2017.
//  Copyright © 2017 Dongbing Hou. All rights reserved.
//

import UIKit

class BaseCollectionViewCell: UICollectionViewCell {
    
    lazy var imgView = UIImageView(image: UIImage(named: "meal"))
    lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.font = HB.Font.h7
        label.textAlignment = .center
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        initialized()
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func initialized() {
        contentView.addSubview(imgView)
        contentView.addSubview(titleLabel)
        
        
        imgView.snp.makeConstraints { (make) in
            make.top.equalTo(contentView).offset(5)
            make.centerX.equalTo(contentView)
            make.width.height.equalTo(40)
        }
        titleLabel.snp.makeConstraints { (make) in
            make.top.equalTo(imgView.snp.bottom).offset(2)
            make.centerX.equalTo(contentView)
        }
    }
}
