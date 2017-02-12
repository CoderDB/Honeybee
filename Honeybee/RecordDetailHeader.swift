//
//  RecordDetailHeader.swift
//  Honeybee
//
//  Created by Dongbing Hou on 12/02/2017.
//  Copyright © 2017 Dongbing Hou. All rights reserved.
//

import UIKit

class RecordDetailHeader: UIView {
    
    
    lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.textColor = UIColor.white
        label.font = HonybeeFont.recordDetailMainTitle
        
        return label
    }()
    
    lazy var imgView = UIImageView()
    
    

    convenience init(height: CGFloat, title: String?, imageName: String) {
        self.init(frame: CGRect(x: 10, y: 10, width: ScreenW-20, height: height))
        
        titleLabel.text = title ?? nil
        imgView.image = UIImage(named: imageName)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        layer.cornerRadius = 10
        backgroundColor = UIColor.cyan
        setupUI()
    }
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupUI() {
        addSubview(imgView)
        addSubview(titleLabel)
        
        imgView.snp.makeConstraints { (make) in
            make.center.equalTo(self)
            make.width.height.equalTo(100)
        }
        
        titleLabel.snp.makeConstraints { (make) in
            make.left.top.equalTo(self).offset(10)
            make.height.equalTo(45)
            make.width.equalTo(60)
        }
    }
}
