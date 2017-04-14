//
//  ProfileHeader.swift
//  Honeybee
//
//  Created by Dongbing Hou on 13/02/2017.
//  Copyright © 2017 Dongbing Hou. All rights reserved.
//

import UIKit

class ProfileHeader: BaseHeader {

    
    lazy var titleLabel: UILabel = {
        $0.font = HB.Font.h4
        $0.textColor = .white
        $0.text = "累计记账"
        return $0
    }(UILabel())
    lazy var countLabel: UILabel = {
        $0.font = HB.Font.h1_number
        $0.textColor = .white
        return $0
    }(UILabel())
    
    convenience init(height: CGFloat) {
        self.init(frame: CGRect(x: 0, y: 0, width: 0, height: height))
        
        countLabel.attributedText = calculateChargeUpDays()
    }
    override func setupUI() {
        super.setupUI()
        
        containerView.backgroundColor = HB.Color.main
        rightBtn.setTitle("分享", for: .normal)
        
        containerView.addSubview(titleLabel)
        containerView.addSubview(countLabel)

        titleLabel.snp.makeConstraints { (make) in
            make.left.top.equalTo(containerView).offset(10)
        }
        countLabel.snp.makeConstraints { (make) in
            make.bottom.equalTo(containerView).offset(-10)
            make.centerX.equalTo(containerView)
        }
    }

    
    func calculateChargeUpDays() -> NSAttributedString {
        let start = "2017-01-01" // 注册日
//        let end = "2017-02-14"
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        let day1 = formatter.date(from: start)!
        let day2 = Date()//formatter.date(from: end)!
        
        let cal = Calendar(identifier: .gregorian)
        let days = cal.dateComponents([.day], from: day1, to: day2).day ?? 0
        
        let dayStr = "\(days)天"
        
        let attr = NSMutableAttributedString(string: dayStr)
        attr.addAttributes([NSFontAttributeName: HB.Font.h4], range: NSRange(location: dayStr.characters.count-1, length: 1))
        return attr
    }

 
    
    
}

