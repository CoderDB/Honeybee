//
//  CalculateView.swift
//  Honeybee
//
//  Created by Dongbing Hou on 01/12/2016.
//  Copyright © 2016 Dongbing Hou. All rights reserved.
//

import UIKit


class CalculateView: UIView {
    
    private let btnTitles = [["7", "8", "9"], ["4", "5", "6"], ["1", "2", "3"], [".", "0", "0"]]

    private let margin: CGFloat = 5
    
    private let btnH: CGFloat
    private let btnW: CGFloat
    
    override init(frame: CGRect) {
        btnH = (frame.height - margin * 5) / 4
        btnW = (frame.width - margin * 4) / 4
        super.init(frame: frame)
        setupButtons()
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupButtons() {
        for i in 0..<3 {
            for j in 0..<4 {
                let x = margin + CGFloat(i) * (btnW + margin)
                let y = margin + CGFloat(j) * (btnH + margin)
                let btn = createBtn(title: btnTitles[j][i])
                btn.frame = CGRect(x: x, y: y, width: btnW, height: btnH)
                if i == 1 && j == 3 {
                    btn.frame.size = CGSize(width: 2 * btnW + margin, height: btnH)
                }
                if i == 2 && j == 3 {
                    btn.frame = CGRect.zero
                }
                addSubview(btn)
            }
        }
        addDeleteBtn()
        addOKBtn()
    }
    func addDeleteBtn() {
        let btn = UIButton(type: .custom)
        btn.backgroundColor = UIColor.black
        btn.layer.cornerRadius = 5
        btn.setImage(UIImage(named: "delete"), for: .normal)
        btn.addTarget(self, action: #selector(deleteClicked(_:)), for: .touchUpInside)
        btn.frame = CGRect(x: frame.width - btnW, y: margin, width: btnW - margin, height: btnH * 2 + margin)
        addSubview(btn)
    }
    
    func addOKBtn() {
        let btn = createBtn(title: "OK")
        btn.frame = CGRect(x: frame.width - btnW, y: margin * 3 + btnH * 2, width: btnW - margin, height: btnH * 2 + margin)
        addSubview(btn)
    }
    
    func createBtn(title: String) -> UIButton {
        let btn = UIButton(type: .system)
        btn.setTitle(title, for: .normal)
        btn.setTitleColor(UIColor.white, for: .normal)
        btn.titleLabel?.font = HonybeeFont.h3_number
        btn.backgroundColor = UIColor.black
        btn.layer.cornerRadius = 5
        btn.addTarget(self, action: #selector(btnClicked(_:)), for: .touchUpInside)
        return btn
    }
    
    func deleteClicked(_ btn: UIButton) {
        print("___backBtnClicked")
    }
    
    func btnClicked(_ btn: UIButton) {
        print("---btnClicked---\(btn.titleLabel?.text)")
    }
}
