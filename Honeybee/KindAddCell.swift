//
//  KindAddCell.swift
//  Honeybee
//
//  Created by Dongbing Hou on 07/03/2017.
//  Copyright © 2017 Dongbing Hou. All rights reserved.
//

import UIKit

class KindAddCell: UICollectionViewCell {
    lazy var selectedImg = UIImageView(image: UIImage(named: "selected_color"))
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.addSubview(selectedImg)
//        selectedImg.isHidden = true
        selectedImg.snp.makeConstraints { (make) in
            make.center.equalTo(contentView)
        }
        
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
