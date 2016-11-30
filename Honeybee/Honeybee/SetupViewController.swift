//
//  SetupViewController.swift
//  Honeybee
//
//  Created by Dongbing Hou on 30/11/2016.
//  Copyright © 2016 Dongbing Hou. All rights reserved.
//

import UIKit

class SetupViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.white
        title = "设置"
        
        addNavRightItem()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    func addNavRightItem() {
        let completeBtn = UIButton(frame: CGRect(x: 0, y: 0, width: 50, height: 30))
        completeBtn.backgroundColor = UIColor.red
        completeBtn.setTitle("完成", for: .normal)
        completeBtn.addTarget(self, action: #selector(rightItemAction), for: .touchUpInside)
        navigationItem.rightBarButtonItem = UIBarButtonItem(customView: completeBtn)
    }
    func rightItemAction() {
        dismiss(animated: true, completion: nil)
    }

}
