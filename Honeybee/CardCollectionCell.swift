//
//  CardCollectionCell.swift
//  Honeybee
//
//  Created by Dongbing Hou on 25/02/2017.
//  Copyright © 2017 Dongbing Hou. All rights reserved.
//

import UIKit

class CardCollectionCell: UICollectionViewCell {
  
    
    lazy var imgView = UIImageView(image: UIImage(named: "meal"))
    lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.font = HB.Font.h7
        label.textAlignment = .center
        return label
    }()
    
    var model: HoneybeeItem? {
        didSet {
            if let model = model {
                titleLabel.text = model.name
                imgView.image = UIImage(named: model.icon)
            }
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        layer.cornerRadius = 5.0
        initialized()
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func initialized() {
        contentView.addSubview(imgView)
        contentView.addSubview(titleLabel)
        imgView.snp.makeConstraints { (make) in
            make.centerX.equalTo(contentView)
            make.top.equalTo(5)
            make.width.height.equalTo(45)
        }
        titleLabel.snp.makeConstraints { (make) in
            make.centerX.equalTo(contentView)
            make.top.equalTo(imgView.snp.bottom)
        }
    }
}
