//
//  UI-Protocol.swift
//  Honeybee
//
//  Created by Dongbing Hou on 15/03/2017.
//  Copyright © 2017 Dongbing Hou. All rights reserved.
//

import UIKit

protocol AlertProvider {}
extension AlertProvider where Self: UIViewController {
    
    //    func showAlert(msg: AlertMessage = AlertMessage(title: "", message: "", okText: "", cancelText: "", ok: {}, cancel: {})) {
    //        let alert = UIAlertController(title: msg.title!, message: msg.message, preferredStyle: .alert)
    //
    //        let okAction = UIAlertAction(title: msg.okText, style: .default) { (_) in
    //            msg.ok()
    //        }
    //        let cancelAction = UIAlertAction(title: msg.cancelText, style: .cancel) { (_) in
    //            msg.cancel?()
    //        }
    //        alert.addAction(okAction)
    //        alert.addAction(cancelAction)
    //        present(alert, animated: true, completion: nil)
    //    }
    
    func showAlert(title: String? = "确定?", message: String?, ok: @escaping () -> Void, cancel: (() -> Void)? = nil) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "确定", style: .default) { (_) in
            ok()
        }
        let cancelAction = UIAlertAction(title: "算了！", style: .cancel) { (_) in
            cancel?()
        }
        alert.addAction(okAction)
        alert.addAction(cancelAction)
        present(alert, animated: true, completion: nil)
    }
    
    func showTextField(title: String? = nil, placeholder: String? = "", textField:  @escaping (UITextField) -> Void, ok: @escaping () -> Void, cancel: (() -> Void)? = nil) {
        let alert = UIAlertController(title: title, message: nil, preferredStyle: .alert)
        alert.addTextField { (tf) in
            tf.placeholder = placeholder
            textField(tf)
        }
        
        let cancelAction = UIAlertAction(title: "取消", style: .cancel) { (_) in
            cancel?()
        }
        let okAction = UIAlertAction(title: "确定", style: .default) { (_) in
            ok()
        }
        okAction.isEnabled = false
        alert.addAction(cancelAction)
        alert.addAction(okAction)
        present(alert, animated: true, completion: nil)
    }
    
    
    
    
//    func showTextField(title: String? = nil, placeholder: String? = "", completion: (_ controller: UIAlertController, _ ok: () -> Void, _ cancel: () -> Void) -> Void) {
//        let alert = UIAlertController(title: title, message: nil, preferredStyle: .alert)
//        alert.addTextField { (tf) in
//            tf.placeholder = placeholder
//        }
//        let okA: () -> Void = {}
//        let cancelA: () -> Void = {}
//        
//        let cancelAction = UIAlertAction(title: "取消", style: .cancel) { (_) in
//            cancelA()
//        }
//        let okAction = UIAlertAction(title: "确定", style: .default) { (_) in
//            okA()
//        }
//        
//        completion(alert, okA, cancelA)
//        okAction.isEnabled = false
//        alert.addAction(cancelAction)
//        alert.addAction(okAction)
//        present(alert, animated: true, completion: nil)
//    }

    
    
    
    
//    func alertTextFieldTextDidChange(_ noti: Notification) {
//        
//    }
    
    func showWarning(message: String, ok: @escaping () -> Void, cancel: (() -> Void)? = nil) {
        showAlert(message: message, ok: ok, cancel: cancel)
    }
}


protocol HoneybeeViewProvider {}
extension HoneybeeViewProvider where Self: UIViewController {
    func tipLabel(text: String, frame: CGRect) {
        let label = UILabel()
        label.text = text
        label.font = HB.Font.h5_light
        label.textColor = .gray
        let t1 = CGAffineTransform(scaleX: -1, y: 1)//.rotated(by: -(CGFloat)(M_PI_2))
        let t2 = CGAffineTransform(rotationAngle: -90 * CGFloat.pi/180)
        label.transform = t1.concatenating(t2)
        label.frame = frame
        view.addSubview(label)
    }
}

protocol Shakeable {}
extension Shakeable where Self: UIView {
    func shake() {
        let animation = CABasicAnimation(keyPath: "transform.rotation.z")
        animation.duration = 0.06
        animation.repeatCount = MAXFLOAT
        animation.autoreverses = true
        animation.fromValue = -M_1_PI / 10
        animation.toValue = M_1_PI / 10
        animation.autoreverses = true
        layer.add(animation, forKey: "rotation")
    }
}

