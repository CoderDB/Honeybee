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
        scrollView.backgroundColor = UIColor.white
        scrollView.isPagingEnabled = true
        scrollView.bounces = false
        scrollView.showsHorizontalScrollIndicator = false
        scrollView.showsVerticalScrollIndicator = false
        return scrollView
    }()
    
    private let selfHeight: CGFloat = 260
    private let toolViewHeight: CGFloat = 45
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        addToolView()
        addScrollView()
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func addToolView() {
        let toolView = UIView()
        toolView.backgroundColor = UIColor.white
        addSubview(toolView)
        
        let lineView = UIView()
        lineView.backgroundColor = UIColor.black
        toolView.addSubview(lineView)
        
        
       
        let dateBtn = createButton(imageName: "date", sel: #selector(dateBtnClicked))
        toolView.addSubview(dateBtn)
        let remarkBtn = createButton(imageName: "remark", sel: #selector(remarkBtnClicked))
        toolView.addSubview(remarkBtn)
        let cameraBtn = createButton(imageName: "camera", sel: #selector(cameraBtnClicked))
        toolView.addSubview(cameraBtn)
        
        toolView.snp.makeConstraints { (make) in
            make.top.left.width.equalTo(self)
            make.height.equalTo(toolViewHeight)
        }
        lineView.snp.makeConstraints { (make) in
            make.left.top.right.equalTo(toolView)
            make.height.equalTo(2)
        }
        
        dateBtn.snp.makeConstraints { (make) in
            make.left.equalTo(toolView).offset(10)
            make.centerY.equalTo(toolView)
            make.width.height.equalTo(30)
        }
        remarkBtn.snp.makeConstraints { (make) in
            make.left.equalTo(dateBtn.snp.right).offset(10)
            make.top.width.height.equalTo(dateBtn)
        }
        cameraBtn.snp.makeConstraints { (make) in
            make.right.equalTo(toolView).offset(-10)
            make.top.width.height.equalTo(dateBtn)
        }
    }
    private func addScrollView() {
        let scrollViewH = selfHeight - toolViewHeight
        scrollView.frame = CGRect(x: 0, y: toolViewHeight, width: ScreenW, height: scrollViewH)
        scrollView.contentSize = CGSize(width: ScreenW * 2, height: scrollViewH)
        addSubview(scrollView)
        
        calculateView = CalculateView(frame: CGRect(x: 0, y: 0, width: ScreenW, height: scrollViewH))
        scrollView.addSubview(calculateView)
        
        dateView = DateView(frame: CGRect(x: ScreenW, y: 0, width: ScreenW, height: scrollViewH))
        scrollView.addSubview(dateView)
    }
    
    private func createButton(imageName: String, sel: Selector) -> UIButton {
        let btn = UIButton()
        btn.setImage(UIImage(named: imageName), for: .normal)
        btn.addTarget(self, action: sel, for: .touchUpInside)
        return btn
    }
    
    
    @objc private func remarkBtnClicked() {
        print("--remark")
    }
    @objc private func dateBtnClicked() {
        scrollView.setContentOffset(CGPoint(x: ScreenW, y: 0), animated: true)
    }
    @objc private func cameraBtnClicked() {
        print("cameraBtnClick")
        delegate?.callCamera()
    }
    
}
