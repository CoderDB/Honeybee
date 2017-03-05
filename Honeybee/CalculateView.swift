//
//  CalculateView.swift
//  Honeybee
//
//  Created by Dongbing Hou on 01/12/2016.
//  Copyright © 2016 Dongbing Hou. All rights reserved.
//

import UIKit

protocol CalculateViewProtocol: class {
    func inputing(text: String)
    func deleted(text: String)
    func completed(text: String)
}

class CalculateView: UIView {
    
    fileprivate var result: String = ""
    fileprivate var inputString = ""
    weak var delegate: CalculateViewProtocol?
    
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
                    btn.frame = .zero
                }
                addSubview(btn)
            }
        }
        addDeleteBtn()
        addOKBtn()
    }
    
    private let btnTitles = [["7", "8", "9"], ["4", "5", "6"], ["1", "2", "3"], [".", "0", "0"]]
    func createBtn(title: String) -> UIButton {
        let btn = UIButton()
        btn.setTitle(title, for: .normal)
        btn.setTitleColor(UIColor.black, for: .normal)
        btn.titleLabel?.font = HonybeeFont.h3_number
        btn.backgroundColor = UIColor.white
        btn.layer.cornerRadius = 5
        btn.addTarget(self, action: #selector(btnClicked(_:)), for: .touchUpInside)
        return btn
    }
    func addDeleteBtn() {
        let btn = UIButton(type: .custom)
        btn.backgroundColor = UIColor.white
        btn.layer.cornerRadius = 5
        btn.setImage(UIImage(named: "delete"), for: .normal)
        btn.addTarget(self, action: #selector(deleteClicked), for: .touchUpInside)
        btn.frame = CGRect(x: frame.width - btnW, y: margin, width: btnW - margin, height: btnH * 2 + margin)
        addSubview(btn)
    }
    func addOKBtn() {
        let btn = UIButton()
        btn.setTitle("OK", for: .normal)
        btn.setTitleColor(UIColor.black, for: .normal)
        btn.titleLabel?.font = HonybeeFont.h3_number
        btn.backgroundColor = UIColor.white
        btn.layer.cornerRadius = 5
        btn.addTarget(self, action: #selector(okBtnClicked), for: .touchUpInside)
        btn.frame = CGRect(x: frame.width - btnW, y: margin * 3 + btnH * 2, width: btnW - margin, height: btnH * 2 + margin)
        addSubview(btn)
    }
    
    func btnClicked(_ btn: UIButton) {
        guard let input = btn.titleLabel!.text else {
            return
        }
        inputString = input
        configResult(text: inputString)
    }
    func okBtnClicked() {
        if result.characters.last == "." {
            result.remove(at: result.index(before: result.endIndex))
        }
        delegate?.completed(text: result)
        result.removeAll()
    }
    func deleteClicked() {
        if result.characters.count > 0 {
            result.remove(at: result.index(before: result.endIndex))
        } else {
            result = ""
        }
        delegate?.deleted(text: result)
    }
    
    func configResult(text: String) {
        if result == "" && text == "." {
            result = "0."
        }
        if result.contains(".") {
            if text == "." {
                // do nothing
            } else {
                if result.components(separatedBy: ".").last!.characters.count >= 2 {
                    // 只计算小数点后两位
                    
                } else {
                    result += text
                }
            }
        } else {
            result += text
        }
        delegate?.inputing(text: result)
    }
}
