//
//  PasswordView.swift
//  Honeybee
//
//  Created by Dongbing Hou on 11/04/2017.
//  Copyright © 2017 Dongbing Hou. All rights reserved.
//

import UIKit

protocol PasswordViewProtocol: class {
    func forget()
    func change()
}

class PasswordView: UIView {

    weak var gesturePasswordDelegate: PasswordViewProtocol?
    
    
    var tentacleView: TentacleView!
    
    lazy var state: UILabel = {
        $0.textAlignment = .center
        $0.font = HB.Font.h4
        return $0
    }(UILabel())
    lazy var forgetButton: UIButton = {
        $0.titleLabel?.font = HB.Font.h4
        $0.setTitleColor(UIColor.white, for: .normal)
        $0.setTitle("忘记手势密码", for: .normal)
        return $0
    }(UIButton())
    lazy var changeButton: UIButton = {
        $0.titleLabel?.font = HB.Font.h4
        $0.setTitleColor(UIColor.white, for: .normal)
        $0.setTitle("修改手势密码", for: .normal)
        return $0
    }(UIButton())
    
    fileprivate var buttonArray: [PasswordButton] = []
    
    fileprivate var lineStartPoint:CGPoint?
    fileprivate var lineEndPoint:CGPoint?
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    func setupUI() {
        let view = UIView(frame:CGRect(x: frame.size.width/2-160, y: frame.size.height/2-80, width: 320, height: 320))
        for i in 0..<9 {
            let row = Int(i/3)
            let col = Int(i%3)
            let distance = Int(320/3)
            let size:Int = Int(Float(distance)/1.5)
            let margin = Int(size/4)
            
            let gesturePasswordButton = PasswordButton(frame: CGRect(x: CGFloat(col*distance+margin), y: CGFloat(row*distance), width: CGFloat(size), height: CGFloat(size)))
            
            gesturePasswordButton.tag = i
            
            view.addSubview(gesturePasswordButton)
            buttonArray.append(gesturePasswordButton)
        }
        addSubview(view)
        
        tentacleView = TentacleView(frame: view.frame)
        
        tentacleView.buttonArray = buttonArray
        tentacleView.touchBeginDelegate = self
        addSubview(tentacleView!)
        
        state.frame = CGRect(x: frame.size.width/2-140, y: frame.size.height/2-120, width: 280, height: 30)
        addSubview(state)
        
        forgetButton.frame = CGRect(x: frame.size.width/2-150, y: frame.size.height/2+220, width: 120, height: 30)
        forgetButton.addTarget(self, action: #selector(forget), for: .touchDown)
        addSubview(forgetButton)
        
        changeButton.frame = CGRect(x: frame.size.width/2+30, y: frame.size.height/2+220, width: 120, height: 30)
        changeButton.addTarget(self, action: #selector(change), for: .touchDown)
        addSubview(changeButton)
    }
    
    override func draw(_ rect: CGRect) {
        guard let context = UIGraphicsGetCurrentContext() else { return }
        
        let rgb = CGColorSpaceCreateDeviceRGB()
        let colors:[CGFloat] = [134/255,157/255,147/255,1.0,3/255,3/255,37/255,1.0]
        let nilUnsafePointer: UnsafePointer<CGFloat>? = nil
        
        guard let gradient = CGGradient(colorSpace: rgb, colorComponents: colors, locations: nilUnsafePointer,count: 2) else { return }
        context.drawLinearGradient(gradient, start: CGPoint(x: 0.0,y: 0.0),end: CGPoint(x: 0.0,y: frame.height), options: [])
    }
    
    
    func forget(){
        gesturePasswordDelegate?.forget()
    }
    func change(){
        gesturePasswordDelegate?.change()
    }
}

extension PasswordView: TouchBeginDelegate {
    func gestureTouchBegin(){
        state.text = ""
    }
    
}
