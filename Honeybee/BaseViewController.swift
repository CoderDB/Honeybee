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
        view.backgroundColor = UIColor.white
        automaticallyAdjustsScrollViewInsets = false
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func setupNav(title: String) {
        let titleLabel = UILabel(frame: CGRect(x: 0, y: 0, width: 200, height: 44))
        titleLabel.text = title
        titleLabel.textAlignment = .center
        titleLabel.font = HonybeeFont.h5
        titleLabel.textColor = HonybeeColor.main
        navigationItem.titleView = titleLabel
    }

}
