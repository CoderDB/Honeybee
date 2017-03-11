//
//  KindAddItemHeader.swift
//  Honeybee
//
//  Created by Dongbing Hou on 10/03/2017.
//  Copyright © 2017 Dongbing Hou. All rights reserved.
//

import UIKit
import Then

class KindAddItemHeader: BaseHeader {
    
    lazy var titleLabel = UILabel().then {
        $0.font = HB.Font.h3
        $0.textColor = .white
        $0.numberOfLines = 2
    }
    
    lazy var imgView = UIImageView(image: UIImage(named: "meal"))
    
    
    override func setupUI() {
        super.setupUI()
        rightBtn.setTitle("编辑", for: .normal)
        containerView.backgroundColor = HB.Color.main
        
        containerView.addSubview(titleLabel)
        containerView.addSubview(imgView)
        
        titleLabel.snp.makeConstraints { (make) in
            make.left.top.equalTo(containerView).offset(10)
            make.right.lessThanOrEqualTo(containerView.snp.centerX)
        }
        imgView.snp.makeConstraints { (make) in
            make.left.equalTo(titleLabel.snp.right).offset(10).priority(HB.Priority.low)
            make.centerX.greaterThanOrEqualTo(containerView.snp.centerX)
            make.centerY.equalTo(containerView)
            make.width.height.equalTo(90)
        }
        
//        rightBtn.snp.makeConstraints { (make) in
//            make.width.equalTo(40)
//        }
        
//        stackView.addArrangedSubview(titleLabel)
//        stackView.addArrangedSubview(imgView)
        
//        containerView.addSubview(stackView)
//        stackView.snp.makeConstraints { (make) in
//            make.edges.equalTo(containerView)
//        }
    }
    
//    lazy var stackView: UIStackView = {
//        let view = UIStackView()
//        view.backgroundColor = .cyan
//        view.alignment = .center
//        view.distribution = .fillProportionally
//        view.axis = .horizontal
//        view.spacing = 10
//        return view
//    }()

}
