//
//  RegisterViewController.swift
//  Honeybee
//
//  Created by Dongbing Hou on 26/03/2017.
//  Copyright © 2017 Dongbing Hou. All rights reserved.
//

import UIKit

class RegisterViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "注册"
        view.backgroundColor = HB.Color.main
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(false, animated: true)
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

}
