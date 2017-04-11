
//
//  SetupCell.swift
//  Honeybee
//
//  Created by Dongbing Hou on 13/02/2017.
//  Copyright © 2017 Dongbing Hou. All rights reserved.
//

import UIKit

class SetupCell: BaseTableViewCell {
    
    
    lazy var mainTitleLabel: UILabel = {
        let label = UILabel()
        label.font = HB.Font.h3
        return label
    }()
    
    lazy var subTitleLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .right
        label.numberOfLines = 0
        label.preferredMaxLayoutWidth = 200
        label.lineBreakMode = .byWordWrapping
        label.font = HB.Font.h4_number
        return label
    }()
    
    lazy var arrow = UIImageView(image: UIImage(named: "rightArrow"))
    
    lazy var imgView: UIImageView = {
        let imgView = UIImageView(image: UIImage.image(color: HB.Color.nav))
        imgView.layer.cornerRadius = 5
        imgView.layer.masksToBounds = true
        return imgView
    }()
    
    
    var item: SetupItem! {
        didSet {
            mainTitleLabel.text = item.title
            subTitleLabel.text = item.subTitle
            
            updateUI()
        }
    }
    
    func updateUI() {
        if item.isKind(of: SetupArrowItem.self) {
            accessoryView = arrow
        } else if item.isKind(of: SetupImageItem.self) {
            accessoryView = nil
            contentView.addSubview(imgView)
            imgView.snp.makeConstraints({ (make) in
                make.right.equalTo(contentView).offset(-10)
                make.centerY.equalTo(contentView)
                make.width.height.equalTo(40)
            })
            subTitleLabel.snp.removeConstraints()
            subTitleLabel.snp.makeConstraints({ (make) in
                make.right.equalTo(imgView.snp.left).offset(-5)
            })
        } else if item.isKind(of: SetupSwitchItem.self) {
            let switchOn = UISwitch()
            subTitleLabel.isHidden = true
            subTitleLabel.text = "每天\n10:00"
            switchOn.addTarget(self, action: #selector(switchOnChanhed(_:)), for: .valueChanged)
            accessoryView = switchOn
        } else {
            accessoryView = nil
        }
    }
    func switchOnChanhed(_ switchOn: UISwitch) {
        
//        if isNotificationAllowed() {
            subTitleLabel.isHidden = !switchOn.isOn
//        } else {
            print("打开alert")
//            switchOn.setOn(false, animated: true)
//        }
    }
    func isNotificationAllowed() -> Bool {
        if let settings = UIApplication.shared.currentUserNotificationSettings {
            if settings.types.rawValue != 0 {
                return true
            }
        }
        return false
    }
    override func initialize() {
        contentView.addSubview(mainTitleLabel)
        contentView.addSubview(subTitleLabel)
        
        mainTitleLabel.snp.makeConstraints { (make) in
            make.centerY.equalTo(contentView)
            make.left.equalTo(10)
            make.width.equalTo(120)
            make.height.greaterThanOrEqualTo(45)
        }
        
        subTitleLabel.snp.makeConstraints { (make) in
            make.right.equalTo(contentView).offset(-10)
            make.centerY.equalTo(contentView)
            make.left.equalTo(mainTitleLabel.snp.right).offset(10)
        }
    }
    

}
