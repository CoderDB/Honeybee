//
//  MianPopController.swift
//  Honeybee
//
//  Created by Dongbing Hou on 18/03/2017.
//  Copyright © 2017 Dongbing Hou. All rights reserved.
//

import UIKit

class MainPopController: BaseViewController {
    
    private lazy var incomeBtn: UIButton = {
        $0.setTitle("仅支出", for: .normal)
        $0.setTitleColor(HB.Color.nav, for: .normal)
        $0.titleLabel?.font = HB.Font.h6_medium
        return $0
    }(UIButton())
    private lazy var expendBtn: UIButton = {
        $0.setTitle("仅收入", for: .normal)
        $0.setTitleColor(HB.Color.nav, for: .normal)
        $0.titleLabel?.font = HB.Font.h6_medium
        return $0
    }(UIButton())
    
    override func viewDidLoad() {
        super.viewDidLoad()
        preferredContentSize = CGSize(width: 70, height: 70)
        
        incomeBtn.addTarget(self, action: #selector(incomeBtnClicked), for: .touchUpInside)
        expendBtn.addTarget(self, action: #selector(expendBtnClicked), for: .touchUpInside)
        
        view.addSubview(incomeBtn)
        view.addSubview(expendBtn)
        incomeBtn.snp.makeConstraints { (make) in
            make.top.centerX.equalTo(view)
        }
        expendBtn.snp.makeConstraints { (make) in
            make.bottom.centerX.equalTo(view)
        }
    }
    
    var incomeBtnAction: (() -> Void)?
    var expendBtnAction: (() -> Void)?
    
    @objc private func incomeBtnClicked() {
        incomeBtnAction?()
    }
    @objc private func expendBtnClicked() {
        expendBtnAction?()
    }
}
