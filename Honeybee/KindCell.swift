//
//  KindCell.swift
//  Honeybee
//
//  Created by Dongbing Hou on 07/03/2017.
//  Copyright © 2017 Dongbing Hou. All rights reserved.
//

import UIKit

class KindCell: UICollectionViewCell, Shakeable {
    lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.font = HB.Font.h1
        label.numberOfLines = 2
        label.textAlignment = .center
        label.textColor = .white
        label.lineBreakMode = .byWordWrapping
//        label.preferredMaxLayoutWidth = 100
        return label
    }()
    lazy var deleteBtn: UIButton = {
        let btn = UIButton()
        btn.setImage(UIImage(named: "kind_delete"), for: .normal)
        btn.isHidden = true
        return btn
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
//        backgroundColor = .randomColor
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
        deleteBtn.addTarget(self, action: #selector(deleteBtnClicked), for: .touchUpInside)
        
        contentView.addSubview(titleLabel)
        contentView.addSubview(deleteBtn)
        titleLabel.snp.makeConstraints { (make) in
            make.width.lessThanOrEqualTo(100)
            make.center.equalTo(contentView)
            //            make.edges.equalTo(contentView)
        }
        deleteBtn.snp.makeConstraints { (make) in
            make.center.equalTo(contentView)
        }
    }
    var deleteBtnAction: (() -> Void)?
    @objc private func deleteBtnClicked() {
        deleteBtnAction?()
    }
    
    
    
}
