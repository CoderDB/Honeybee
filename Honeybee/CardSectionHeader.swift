//
//  CardSectionHeader.swift
//  Honeybee
//
//  Created by Dongbing Hou on 09/03/2017.
//  Copyright © 2017 Dongbing Hou. All rights reserved.
//

import UIKit

class CardSectionHeader: UICollectionReusableView {

    lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.font = HB.Font.h3
        return label
    }()
    lazy var line: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(pure: 229)
        return view
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = UIColor.white
        addSubview(titleLabel)
        addSubview(line)
        titleLabel.snp.makeConstraints { (make) in
            make.left.equalTo(self)
            make.top.equalTo(self)
        }
        line.snp.makeConstraints { (make) in
            make.left.right.bottom.equalTo(self)
            make.height.equalTo(1)
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }


}
