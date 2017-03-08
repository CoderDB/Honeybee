//
//  HBKeyboard.swift
//  Honeybee
//
//  Created by Dongbing Hou on 03/12/2016.
//  Copyright © 2016 Dongbing Hou. All rights reserved.
//

import UIKit
import SnapKit

protocol HBKeyboardProtocol: CalculateViewProtocol, DateViewProtocol {
    func callCamera()
}

class HBKeyboard: UIView {
    
    weak var delegate: HBKeyboardProtocol?
    var calculateView: CalculateView!
    var dateView: DateView!
    
    private lazy var scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.isUserInteractionEnabled = true
        scrollView.backgroundColor = UIColor.clear
        scrollView.isPagingEnabled = true
        scrollView.bounces = false
        scrollView.showsHorizontalScrollIndicator = false
        scrollView.showsVerticalScrollIndicator = false
        return scrollView
    }()
    private lazy var toolView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.clear
        return view
    }()
    
    private let selfHeight: CGFloat = 240
    private let toolViewHeight: CGFloat = 35
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        layer.cornerRadius = HB.Constant.cornerRadius
        backgroundColor = HB.Color.main
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOpacity = 0.3
        layer.shadowOffset = CGSize(width: 0, height: -3)
        
        
        addToolView()
        addScrollView()
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    
    private func createButton(imageName: String, sel: Selector) -> UIButton {
        let btn = UIButton()
        btn.setImage(UIImage(named: imageName), for: .normal)
        btn.addTarget(self, action: sel, for: .touchUpInside)
        return btn
    }
    private func addToolView() {
        let dateBtn = createButton(imageName: "date", sel: #selector(dateBtnClicked))
        toolView.addSubview(dateBtn)
        let remarkBtn = createButton(imageName: "remark", sel: #selector(remarkBtnClicked))
        toolView.addSubview(remarkBtn)
        let cameraBtn = createButton(imageName: "camera", sel: #selector(cameraBtnClicked))
        toolView.addSubview(cameraBtn)
        
        addSubview(toolView)
        toolView.snp.makeConstraints { (make) in
            make.top.equalTo(self).offset(5)
            make.left.equalTo(self).offset(10)
            make.right.equalTo(self).offset(-10)
            make.height.equalTo(toolViewHeight)
        }
        dateBtn.snp.makeConstraints { (make) in
            make.left.centerY.equalTo(toolView)
            make.width.height.equalTo(30)
        }
        remarkBtn.snp.makeConstraints { (make) in
            make.left.equalTo(dateBtn.snp.right).offset(10)
            make.top.width.height.equalTo(dateBtn)
        }
        cameraBtn.snp.makeConstraints { (make) in
            make.right.equalTo(toolView)
            make.top.width.height.equalTo(dateBtn)
        }
    }
    private func addScrollView() {
        let H = selfHeight - toolViewHeight - 10
        let W = HB.Screen.w - 20
        
        scrollView.contentSize = CGSize(width: W * 2, height: H)
        addSubview(scrollView)
        scrollView.snp.makeConstraints { (make) in
            make.top.equalTo(toolView.snp.bottom)
            make.left.equalTo(self).offset(10)
            make.right.equalTo(self).offset(-10)
            make.bottom.equalTo(self).offset(-10)
        }
        calculateView = CalculateView(frame: CGRect(x: 0, y: 0, width: W, height: H))
        scrollView.addSubview(calculateView)
        
        dateView = DateView(frame: CGRect(x: W, y: 5, width: W, height: H-10))
        scrollView.addSubview(dateView)
    }
    
    
    @objc private func remarkBtnClicked() {
        print("--remark")
    }
    @objc private func dateBtnClicked() {
        scrollView.setContentOffset(CGPoint(x: HB.Screen.w-20, y: 0), animated: true)
    }
    @objc private func cameraBtnClicked() {
        print("cameraBtnClick")
        delegate?.callCamera()
    }
    
}
