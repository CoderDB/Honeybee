//
//  BaseViewController.swift
//  Honeybee
//
//  Created by Dongbing Hou on 13/02/2017.
//  Copyright © 2017 Dongbing Hou. All rights reserved.
//

import UIKit

class BaseViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func setNavTitle(_ title: String) {
        let titleLabel = UILabel(frame: CGRect(x: 0, y: 0, width: 100, height: 44))
        titleLabel.text = title
        titleLabel.textAlignment = .center
        titleLabel.font = HB.Font.h5
        titleLabel.textColor = HB.Color.nav
        navigationItem.titleView = titleLabel
    }
    
    func setNavRightItem(_ title: String) {
        
        let btn = UIButton(type: .custom)
//        btn.snp.makeConstraints { (make) in
//            make.width.lessThanOrEqualTo(100)
//            make.height.equalTo(25)
//        }
        btn.frame = CGRect(x: 0, y: 0, width: 40, height: 25)
        btn.setTitle(title, for: .normal)
        btn.setTitleColor(HB.Color.nav, for: .normal)
        btn.titleLabel?.font = HB.Font.h5
//        btn.titleLabel?.adjustsFontSizeToFitWidth = true
//        btn.titleLabel?.minimumScaleFactor = 0.8
        btn.contentHorizontalAlignment = .right
        btn.addTarget(self, action: #selector(navRightItemClicked(_:)), for: .touchUpInside)
        navigationItem.rightBarButtonItem = UIBarButtonItem(customView: btn)
//        navRightItemAction = action
    }
//    private var navRightItemAction: (() -> ())?
//    @objc private func navRightItemClicked() {
//        navRightItemAction?()
//    }
    func navRightItemClicked(_ btn: UIButton) {
    }

}
