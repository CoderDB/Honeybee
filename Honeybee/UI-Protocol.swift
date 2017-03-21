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
    
    
    
    
    func showTextField(title: String? = nil, placeholder: String? = "", sel:  Selector, ok: @escaping () -> Void, cancel: (() -> Void)? = nil) {
        let alert = UIAlertController(title: title, message: nil, preferredStyle: .alert)
        alert.addTextField { (tf) in
            tf.placeholder = placeholder
            NotificationCenter.default.addObserver(self, selector: sel, name: .UITextFieldTextDidChange, object: tf)
        }
        
        let cancelAction = UIAlertAction(title: "取消", style: .cancel) { (_) in
            cancel?()
        }
        let okAction = UIAlertAction(title: "确定", style: .default) { (_) in
            NotificationCenter.default.removeObserver(self, name: .UITextFieldTextDidChange, object: alert.textFields)
            ok()
        }
        okAction.isEnabled = false
        alert.addAction(cancelAction)
        alert.addAction(okAction)
        present(alert, animated: true, completion: nil)
    }

    
    
    
    
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



