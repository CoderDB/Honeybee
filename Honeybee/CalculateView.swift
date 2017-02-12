//
//  CalculateView.swift
//  Honeybee
//
//  Created by Dongbing Hou on 01/12/2016.
//  Copyright © 2016 Dongbing Hou. All rights reserved.
//

import UIKit


enum operation {
    case binaryOperation((Double, Double) -> Double, (String, String) -> String, Int)
    case equal
}

class CalculateView: UIView {
    
    private var input = ""
    private var history = ""

    private let btnTitles = [["7", "8", "9", "⬅️"], ["4", "5", "6", "+"], ["1", "2", "3", "-"], [".", "0"]]
    private let btnW: CGFloat
    private var btnH: CGFloat
    private let margin: CGFloat = 1
    
    override init(frame: CGRect) {
        btnH = (frame.height - margin * 3) / 4
        btnW = (frame.width - margin * 3) / 4
        super.init(frame: frame)
        
        setupButtons()
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    private func setupButtons() {
        for i in 0..<4 {
            for j in 0..<4 {
                let x = CGFloat(i) * (btnW + margin)
                let y = CGFloat(j) * (btnH + margin)
                if i == 2 && j == 3 {
                    // btnW * 2 + margin 
                    let btn_0 = UIButton(frame: CGRect(x: x, y: y, width: btnW * 2 + margin, height: btnH))
                    btn_0.setTitle("OK", for: .normal)
                    btn_0.backgroundColor = Theme.main
                    btn_0.addTarget(self, action: #selector(okBtnClcked), for: .touchDown)
                    addSubview(btn_0)
                } else if i == 3 && j == 3 {}
                else {
                    
                    let btn = UIButton(frame: CGRect(x: x, y: y, width: btnW, height: btnH))
                    btn.backgroundColor = Theme.main
                    btn.setTitle(btnTitles[j][i], for: .normal)
                    addSubview(btn)

                    if i == 3 && j == 0 {
                        btn.addTarget(self, action: #selector(backBtnClicked(_:)), for: .touchUpInside)
                    } else if i == 3 && j == 1 {
                        btn.addTarget(self, action: #selector(addBtnClicked(_:)), for: .touchUpInside)
                    }
                    else if i == 3 && j == 2 {
                        btn.addTarget(self, action: #selector(subtractBtnClicked(_:)), for: .touchUpInside)
                    }
                    else {
                        btn.addTarget(self, action: #selector(btnClicked(_:)), for: .touchUpInside)
                    }
                }
                
                
            }
        }
    }
    func backBtnClicked(_ btn: UIButton) {
        print("___backBtnClicked")
    }
    
    func addBtnClicked(_ btn: UIButton) {
        print("addBtnClicked")
        
    }
    func subtractBtnClicked(_ btn: UIButton) {
        print("subtractBtnClicked")
        
    }
    
    func okBtnClcked() {
        print("-----history---\(history)")
    }
    
    func btnClicked(_ btn: UIButton) {
        print("---btnClicked---\(btn.titleLabel?.text)")
        switch btn.titleLabel!.text! {
        case "7":
            print(7)
            input = "7"
        case "8":
            print(8)
            input = "8"
        case "9":
            print(9)
            input = "9"
        case "4":
            print(4)
            input = "4"
        case "5":
            print(5)
            input = "5"
        case "6":
            print(6)
            input = "6"
        case "1":
            print(1)
            input = "1"
        case "2":
            print(2)
            input = "2"
        case "3":
            print(3)
            input = "3"
        case "0":
            print(0)
        case ".":
            input = "."
        case "⬅️":
            input.removeAll()
            print(input)
            history.remove(at: history.index(before: history.endIndex))
            
            print("--\(history)")
        case "+":
            input = "+"
            print("+")
        case "-":
            input = "-"
            print("-")
        default:
            break
        }
        history += input
    }
    
    
    private var operations: Dictionary<String, operation> = [
        "+": operation.binaryOperation({ (a, b) -> Double in
            return a + b
        }, { (a, b) -> String in
            return a + b
        }, 0),
        "-": operation.binaryOperation(-, {$0 + "-" + $1}, 0),
        "=": operation.equal
    ]
}
