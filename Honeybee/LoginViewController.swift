//
//  LoginViewController.swift
//  Honeybee
//
//  Created by Dongbing Hou on 25/03/2017.
//  Copyright © 2017 Dongbing Hou. All rights reserved.
//

import UIKit

import RxSwift
import RxCocoa


class LoginViewController: UIViewController {

    
    var viewModel: LoginViewModel!
    let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = HB.Color.main
        
        setupUI()
        
        viewModel = LoginViewModel(
            input: (
                username: usernameTF.rx.text.orEmpty.asDriver(),
                password: passwordTF.rx.text.orEmpty.asDriver(),
                loginTap: loginBtn.rx.tap.asDriver()
            ),
            service: ValidationService.default
        )
        
//        viewModel.username.drive(onNext: { (<#Result#>) in
//            <#code#>
//        }, onCompleted: <#T##(() -> Void)?##(() -> Void)?##() -> Void#>)
        _ = viewModel.loginButtonEnabled
            .drive(onNext: { [unowned self] in
            self.loginBtn.isEnabled = $0
            self.loginBtn.alpha = $0 ? 1 : 0.3
            })
        .addDisposableTo(disposeBag)
        
        
        _ = viewModel.loginResult.drive(onNext: { (result) in
            switch result {
            case let .success(msg):
                Reminder.success(msg: msg)
            case let .fail(msg):
                Reminder.error(msg: msg)
            case .empty:
                Reminder.error()
            }
        })
        .addDisposableTo(disposeBag)
        
        
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: true)
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
        showPasswordBtn.addTarget(self, action: #selector(showPasswordBtnClicked(_:)), for: .touchUpInside)
        passwordTF.rightView = showPasswordBtn
        
        usernameTF.addTarget(self, action: #selector(usernameTFValueChanged(_:)), for: .editingChanged)
        passwordTF.addTarget(self, action: #selector(passwordTFValueChanged(_:)), for: .editingChanged)
        //        usernameTF.applyRoundCorners(corners: [.topLeft, .topRight], radius: 10)
        
        loginBtn.snp.makeConstraints { (make) in
            make.left.right.equalTo(passwordTF)
            make.height.equalTo(40)
            make.top.equalTo(passwordTF.snp.bottom).offset(30)
        }
        loginBtn.addTarget(self, action: #selector(loginBtnClicked), for: .touchUpInside)
        
        forgetPasswordBtn.snp.makeConstraints { (make) in
            make.left.equalTo(loginBtn)
            make.top.equalTo(loginBtn.snp.bottom).offset(5)
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
        tf.delegate = self
        tf.leftViewMode = .always
        tf.leftView = UIImageView(image: UIImage(named: "username_tf"))
        tf.rightViewMode = .whileEditing
        tf.clearButtonMode = .whileEditing
        tf.borderStyle = .roundedRect
        return tf
    }()
    lazy var passwordTF: HBTextField = {
        let tf = HBTextField()
        tf.delegate = self
        tf.leftViewMode = .always
        tf.leftView = UIImageView(image: UIImage(named: "password_tf"))
        tf.rightViewMode = .always
        tf.isSecureTextEntry = true
        tf.borderStyle = .roundedRect
        return tf
    }()
    
    lazy var showPasswordBtn: UIButton = {
        let btn = UIButton()
        btn.frame = CGRect(x: 0, y: 0, width: 20, height: 20)
        btn.setImage(UIImage(named: "show_pwd_tf"), for: .normal)
        btn.setImage(UIImage(named: "hidden_pwd_tf"), for: .selected)
        return btn
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
        btn.setTitle("现在注册", for: .normal)
        btn.titleLabel?.font = HB.Font.h7_light
        btn.setTitleColor(UIColor.white, for: .normal)
        return btn
    }()
    lazy var forgetPasswordBtn: UIButton = {
        let btn = UIButton()
        let attrText = NSMutableAttributedString(string: "忘记密码？")
        let attrs: [String: Any] = [NSUnderlineStyleAttributeName: NSUnderlineStyle.styleSingle.rawValue,
                                   NSForegroundColorAttributeName: UIColor.white]
        attrText.addAttributes(attrs, range: NSRange(location: 0, length: attrText.length))
        btn.setAttributedTitle(attrText, for: .normal)
        btn.titleLabel?.font = HB.Font.h7_light
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
    func showPasswordBtnClicked(_ btn: UIButton) {
        btn.isSelected = !btn.isSelected
        passwordTF.isSecureTextEntry = !passwordTF.isSecureTextEntry
    }
    func loginBtnClicked() {
        if let delegate = UIApplication.shared.delegate as? AppDelegate {
            delegate.window?.rootViewController = UINavigationController(rootViewController: MainViewController())
        }
    }
    func forgetPassworfBtnClicked() {
    }
    func registerBtnClicked() {
        navigationController?.pushViewController(RegisterViewController(), animated: true)
    }
}


// ------------------------------------------------------------------------
// MARK: UI Event
// ------------------------------------------------------------------------

extension LoginViewController: UITextFieldDelegate {
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        animate(isUp: true)
    }
    func textFieldDidEndEditing(_ textField: UITextField) {
        animate(isUp: false)
    }
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if !textField.isExclusiveTouch {
            return textField.resignFirstResponder()
        }
        return true
    }
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
    }
    func animate(isUp: Bool) {
        let offset: CGFloat = isUp ? -150 : 150
        UIView.animate(withDuration: 0.3, delay: 0, options: .beginFromCurrentState, animations: {[unowned self] in
            self.view.frame = self.view.frame.offsetBy(dx: 0, dy: offset)
        }, completion: nil)
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
