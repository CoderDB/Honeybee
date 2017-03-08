//
//  CurveCell.swift
//  Honeybee
//
//  Created by Dongbing Hou on 22/12/2016.
//  Copyright © 2016 Dongbing Hou. All rights reserved.
//

import UIKit

class CurveCell: UITableViewCell {

    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        backgroundColor = UIColor.gray
        setupUI()
    }
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    
    var testView: UIView!
    
    func setupUI() {
//        testView = BarView(frame: CGRect(x: 0, y: 0, width: HB.Screen.w, height: 200))//LineView(frame: CGRect.zero)
//        
//        contentView.addSubview(testView)
       
    }
}
