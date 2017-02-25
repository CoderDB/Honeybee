//
//  BaseCell.swift
//  Honeybee
//
//  Created by Dongbing Hou on 22/02/2017.
//  Copyright © 2017 Dongbing Hou. All rights reserved.
//

import UIKit

class BaseCell: UITableViewCell {
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        layer.cornerRadius = HonybeeConstant.cornerRadius
        layer.borderWidth = 1
        setupUI()
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    override var frame: CGRect {
        didSet {
            var newFrame = frame
            newFrame.origin.x += 10
            newFrame.origin.y += 20
            newFrame.size = CGSize(width: frame.width-20, height: frame.height-10)
            super.frame = newFrame
        }
    }
    func setupUI() {}
}
