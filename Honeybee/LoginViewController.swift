//
//  LoginViewController.swift
//  Honeybee
//
//  Created by Dongbing Hou on 25/03/2017.
//  Copyright © 2017 Dongbing Hou. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        view.backgroundColor = HB.Color.main
        view.addSubview(usernameTF)
        view.addSubview(passwordTF)
        
        usernameTF.snp.makeConstraints { (make) in
            make.bottom.equalTo(view.snp.centerY)
            make.left.equalTo(view).offset(20)
            make.right.equalTo(view).offset(-20)
            make.height.equalTo(60)
        }
        passwordTF.snp.makeConstraints { (make) in
            make.top.equalTo(usernameTF.snp.bottom).offset(5)
            make.left.right.height.equalTo(usernameTF)
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    lazy var usernameTF: UITextField = {
        let tf = UITextField()
        tf.leftView = UIImageView(image: UIImage(named: "username_tf"))
        tf.borderStyle = .roundedRect
        return tf
    }()
    lazy var passwordTF: UITextField = {
        let tf = UITextField()
        tf.leftView = UIImageView(image: UIImage(named: "password_tf"))
        tf.borderStyle = .roundedRect
        return tf
    }()
}
