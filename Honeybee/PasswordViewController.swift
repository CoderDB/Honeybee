//
//  PasswordViewController.swift
//  Honeybee
//
//  Created by Dongbing Hou on 11/04/2017.
//  Copyright © 2017 Dongbing Hou. All rights reserved.
//

import UIKit

class PasswordViewController: UIViewController,VerificationDelegate,ResetDelegate,GesturePasswordDelegate {

    var passwordView: PasswordView!
    
    var previousString:String? = ""
    var password:String? = ""
    
    var secKey:String = "HoneybeePasswordKey"
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        previousString = ""
        password = KeychainWrapper.stringForKey(secKey)
        
        if( password == "" || password == nil){
            
            self.reset()
        }
        else{
            self.verify()
        }
        
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
//        navigationController?.setNavigationBarHidden(true, animated: false)
        navigationController?.view.sendSubview(toBack: navigationController!.navigationBar)
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        navigationController?.view.bringSubview(toFront: navigationController!.navigationBar)
    }
    
    //MARK: - 验证手势密码
    
    func verify(){
        passwordView = PasswordView(frame: view.bounds)
        passwordView.tentacleView!.rerificationDelegate = self
        passwordView.tentacleView!.style = 1
        passwordView.gesturePasswordDelegate = self
        self.view.addSubview(passwordView)
        
    }
    
    //MARK: - 重置手势密码
    func reset(){
        passwordView = PasswordView(frame: view.bounds)
        passwordView.tentacleView!.resetDelegate = self
        passwordView.tentacleView!.style = 2
        passwordView.forgetButton!.isHidden = true
        passwordView.changeButton!.isHidden = true
        self.view.addSubview(passwordView)
    }
    
    func exist()->Bool{
        
        
        password = KeychainWrapper.stringForKey(secKey)
        if password == "" {
            return false
        }
        return true
    }
    
    //MARK: - 清空记录
    func clear(){
        KeychainWrapper.removeObjectForKey(secKey)
    }
    
    //MARK: - 改变手势密码
    func change(){
        
        print("改变手势密码")
        
    }
    
    //MARK: - 忘记密码
    func forget(){
        print("忘记密码")
    }
    
    
    func verification(_ result:String)->Bool{
        
        // println("password:\(result)====\(password)")
        if(result == password){
            
            passwordView.state!.textColor = UIColor.white
            passwordView.state!.text = "输入正确"
            
            return true
        }
        passwordView.state!.textColor = UIColor.red
        passwordView.state!.text = "手势密码错误"
        return false
    }
    
    func resetPassword(_ result: String) -> Bool {
        
        if(previousString == ""){
            previousString = result
            passwordView.tentacleView!.enterArgin()
            passwordView.state!.textColor = UIColor(red: 2/255, green: 174/255, blue: 240/255, alpha: 1)
            passwordView.state!.text = "请验证输入密码"
            
            return true
        }else{
            
            if(result == previousString){
                
                _ = KeychainWrapper.setString(result, forKey: secKey)
                
                passwordView.state!.textColor = UIColor(red: 2/255, green: 174/255, blue: 240/255, alpha: 1)
                passwordView.state!.text = "已保存手势密码"
                
                
                return true;
            }else{
                previousString = "";
                passwordView.state!.textColor = UIColor.red
                passwordView.state!.text = "两次密码不一致，请重新输入"
                
                return false
            }
            
        }
    }
}
