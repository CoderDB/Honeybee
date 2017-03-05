//
//  CardHeader.swift
//  Honeybee
//
//  Created by Dongbing Hou on 05/03/2017.
//  Copyright © 2017 Dongbing Hou. All rights reserved.
//

import UIKit

class CardHeader: UIView {
    
    lazy var imgView = UIImageView(image: UIImage(named: "meal"))
    
    lazy var categoryLabel: UILabel = {
        let label = UILabel()
        label.font = HonybeeFont.h5_medium
        return label
    }()
    lazy var numberLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .right
        label.font = HonybeeFont.h3_number
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        layer.cornerRadius = HonybeeConstant.cornerRadius
        layer.borderWidth = 2
        layer.borderColor = UIColor.black.cgColor
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
