//
//  CardCollectionCell.swift
//  Honeybee
//
//  Created by Dongbing Hou on 25/02/2017.
//  Copyright © 2017 Dongbing Hou. All rights reserved.
//

import UIKit

class CardCollectionCell: BaseCollectionViewCell {
  
    var model: HoneybeeItem? {
        didSet {
            if let model = model {
                titleLabel.text = model.name
                imgView.image = UIImage(named: model.icon)
            }
        }
    }
}
