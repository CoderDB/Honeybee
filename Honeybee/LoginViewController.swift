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
        
        view.backgroundColor = HB.Color.main
        
        setupUI()
    }
    func setupUI() {
        view.addSubview(usernameTF)
        view.addSubview(passwordTF)
        view.addSubview(loginBtn)
        view.addSubview(forgetPasswordBtn)
        view.addSubview(registerBtn)
        
        usernameTF.snp.makeConstraints { (make) in
            make.bottom.equalTo(view.snp.centerY)
            make.left.equalTo(view).offset(20)
            make.right.equalTo(view).offset(-20)
            make.height.equalTo(50)
        }
        passwordTF.snp.makeConstraints { (make) in
            make.top.equalTo(usernameTF.snp.bottom).offset(5)
            make.left.right.height.equalTo(usernameTF)
        }
        usernameTF.addTarget(self, action: #selector(usernameTFValueChanged(_:)), for: .editingChanged)
        passwordTF.addTarget(self, action: #selector(passwordTFValueChanged(_:)), for: .editingChanged)
        //        usernameTF.applyRoundCorners(corners: [.topLeft, .topRight], radius: 10)
        
        loginBtn.snp.makeConstraints { (make) in
            make.left.right.equalTo(passwordTF)
            make.height.equalTo(40)
            make.top.equalTo(passwordTF.snp.bottom).offset(40)
        }
        loginBtn.addTarget(self, action: #selector(loginBtnClicked), for: .touchUpInside)
        
        forgetPasswordBtn.snp.makeConstraints { (make) in
            make.left.equalTo(loginBtn)
            make.top.equalTo(loginBtn.snp.bottom).offset(20)
        }
        registerBtn.snp.makeConstraints { (make) in
            make.right.equalTo(loginBtn.snp.right)
            make.top.equalTo(forgetPasswordBtn)
        }
        forgetPasswordBtn.addTarget(self, action: #selector(forgetPassworfBtnClicked), for: .touchUpInside)
        registerBtn.addTarget(self, action: #selector(registerBtnClicked), for: .touchUpInside)
    }
    
    
    lazy var usernameTF: HBTextField = {
        let tf = HBTextField()
        tf.leftViewMode = .always
        tf.leftView = UIImageView(image: UIImage(named: "username_tf"))
        tf.rightViewMode = .whileEditing
        tf.clearButtonMode = .whileEditing
        tf.borderStyle = .roundedRect
        return tf
    }()
    lazy var passwordTF: HBTextField = {
        let tf = HBTextField()
        tf.leftViewMode = .always
        tf.leftView = UIImageView(image: UIImage(named: "password_tf"))
        tf.rightViewMode = .always
        tf.rightView = UIImageView(image: UIImage(named: "hidden_pwd_tf"))
        tf.borderStyle = .roundedRect
        return tf
    }()
    
    lazy var loginBtn: UIButton = {
        let btn = UIButton()
        btn.setTitle("登录", for: .normal)
        btn.titleLabel?.font = HB.Font.h4_light
        btn.setTitleColor(UIColor.white, for: .normal)
        btn.backgroundColor = UIColor.cyan
        btn.layer.cornerRadius = 5
        return btn
    }()
    lazy var registerBtn: UIButton = {
        let btn = UIButton()
        btn.setTitle("注册", for: .normal)
        btn.titleLabel?.font = HB.Font.h6_light
        btn.setTitleColor(UIColor.white, for: .normal)
        return btn
    }()
    lazy var forgetPasswordBtn: UIButton = {
        let btn = UIButton()
        btn.setTitle("忘记密码", for: .normal)
        btn.titleLabel?.font = HB.Font.h6_light
        btn.setTitleColor(UIColor.white, for: .normal)
        return btn
    }()
}

// ------------------------------------------------------------------------
// MARK: UI Event
// ------------------------------------------------------------------------
extension LoginViewController {
    func usernameTFValueChanged(_ textField: UITextField) {
        print(textField.text!)
    }
    func passwordTFValueChanged(_ textField: UITextField) {
        print(textField.text!)
    }
    func loginBtnClicked() {
        
    }
    func forgetPassworfBtnClicked() {
    }
    func registerBtnClicked() {
    }
}




class HBTextField: UITextField {
    
    func applyRoundCorners(corners: UIRectCorner, radius: CGFloat) {
        let path = UIBezierPath(roundedRect: self.bounds, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
        let shapeLayer = CAShapeLayer()
        shapeLayer.frame = self.bounds
        shapeLayer.path = path.cgPath
        self.layer.mask = shapeLayer
    }
    
    override func leftViewRect(forBounds bounds: CGRect) -> CGRect {
        var iconFrame = super.leftViewRect(forBounds: bounds)
        iconFrame.origin.x += 10
        return iconFrame
    }
    override func rightViewRect(forBounds bounds: CGRect) -> CGRect {
        var iconFrame = super.rightViewRect(forBounds: bounds)
        iconFrame.origin.x -= 10
        return iconFrame
    }
}
