//
//  TouchId.swift
//  Honeybee
//
//  Created by Dongbing Hou on 12/04/2017.
//  Copyright © 2017 Dongbing Hou. All rights reserved.
//

import UIKit
import LocalAuthentication


protocol TouchIdDelegate: class {
    func accessTouchIdSuccessed()
    func accessTouchIdFailed(errorCode: Int)
}

class TouchId: NSObject {
  
    
    weak var touchIdDelegate: TouchIdDelegate?
    
    private let context: LAContext
    
    override init() {
        self.context = LAContext()
        super.init()
    }
    
    func isTouchIdValid() -> Bool {
        var error: NSError? = nil
        return context.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: &error)
//        throw(error)!
    }
    func accessTouchId(description: String) {
        if isTouchIdValid() {
            context.evaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, localizedReason: description, reply: { (isSuccessed, error) in
                if isSuccessed {
                    print("成功")
                    self.touchIdDelegate?.accessTouchIdSuccessed()
                } else {
                    if let error = error as NSError? {
                        self.touchIdDelegate?.accessTouchIdFailed(errorCode: error.code)
                    }
                }
            })
        }
    }
    
}
