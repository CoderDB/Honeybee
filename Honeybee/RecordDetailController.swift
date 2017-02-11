//
//  RecordDetailController.swift
//  Honeybee
//
//  Created by Dongbing Hou on 11/02/2017.
//  Copyright © 2017 Dongbing Hou. All rights reserved.
//

import UIKit

class RecordDetailController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.white
        navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .any, barMetrics: .default)
        navigationController?.navigationBar.shadowImage = UIImage() //只有设为default黑线才能去除
        // 设置导航栏返回按钮，返回文字颜色
        navigationController?.navigationBar.tintColor = Honybee.mainColor
        
        // 设置 UIBarButtonItem 字体颜色
//        UIBarButtonItem.appearance().setTitleTextAttributes([NSForegroundColorAttributeName: UIColor.green], for: UIControlState.normal)
        
        // 隐藏返回按钮文字
        let buttonItem = UIBarButtonItem.appearance(whenContainedInInstancesOf: [UINavigationBar.self])
        buttonItem.setBackButtonTitlePositionAdjustment(UIOffset(horizontal: -100, vertical: -100), for: .default)
        
        setupNavTitle()
        
        
    }
    
    func setupNavTitle() {
        let titleLabel = UILabel(frame: CGRect(x: 0, y: 0, width: 200, height: 44))
        titleLabel.text = "详情"
        titleLabel.textAlignment = .center
        titleLabel.font = Honybee.subTitleFont
        titleLabel.textColor = Honybee.mainColor
        navigationItem.titleView = titleLabel
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        navigationController?.setNavigationBarHidden(false, animated: true)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

}
