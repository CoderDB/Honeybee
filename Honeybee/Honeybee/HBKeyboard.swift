//
//  HBKeyboard.swift
//  Honeybee
//
//  Created by Dongbing Hou on 03/12/2016.
//  Copyright © 2016 Dongbing Hou. All rights reserved.
//

import UIKit

protocol HBKeyboardProtocol: class {
    func callCamera()
}

class HBKeyboard: UIView {

    
    var scrollView: UIScrollView!
    weak var delegate: HBKeyboardProtocol?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        print("-----frame:  \(frame)")
        
        setupUI(frame: CGRect(x: 0, y: 0, width: ScreenW, height: 300))
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    
    func setupUI(frame: CGRect) {
        let toolView = UIView(frame: CGRect(origin: frame.origin, size: CGSize(width: frame.width, height: 50)))
        toolView.backgroundColor = UIColor.white
        let dateBtn = UIButton(type: .contactAdd)
        dateBtn.frame = CGRect(x: 0, y: 0, width: 30, height: 30)
        dateBtn.addTarget(self, action: #selector(dateBtnClick), for: .touchUpInside)
        toolView.addSubview(dateBtn)
        
        let cameraBtn = UIButton(type: .contactAdd)
        cameraBtn.frame = CGRect(x: ScreenW - 30, y: 0, width: 30, height: 30)
        cameraBtn.addTarget(self, action: #selector(cameraBtnClick), for: .touchUpInside)
        toolView.addSubview(cameraBtn)
        addSubview(toolView)
        
        scrollView = UIScrollView(frame: CGRect(x: 0, y: 50, width: frame.width, height: frame.height-50))
        scrollView.isUserInteractionEnabled = true
        scrollView.backgroundColor = UIColor.red
        scrollView.isPagingEnabled = true
        scrollView.contentSize = CGSize(width: frame.width * 2, height: frame.height)
        let calculateView = CalculateView(frame: frame)
        scrollView.addSubview(calculateView)
        addSubview(scrollView)
    }
    func dateBtnClick() {
        scrollView.setContentOffset(CGPoint(x: ScreenW, y: 0), animated: true)
    }
    func cameraBtnClick() {
        print("cameraBtnClick")
        delegate?.callCamera()
    }
    
}
