//
//  CalculateView.swift
//  Honeybee
//
//  Created by Dongbing Hou on 01/12/2016.
//  Copyright © 2016 Dongbing Hou. All rights reserved.
//

import UIKit

extension UIColor {
    class func randomColor() -> UIColor {
        return UIColor(colorLiteralRed: Float(arc4random() % 256) / 255.0, green: Float(arc4random() % 256) / 255.0, blue: Float(arc4random() % 256) / 255.0, alpha: 1)
    }
}

class CalculateView: UIView {
    
    var resultString = ""

    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = UIColor.cyan
        setupButtons()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    func setupButtons() {
        let btnTitles = [["7", "8", "9", "⬅️"], ["4", "5", "6", "+"], ["1", "2", "3", "-"], [".", "0"]]
        let btnW = CGFloat(ScreenW / 4)
        let btnH: CGFloat = 40
        for i in 0..<4 {
            for j in 0..<4 {
                if (i == 2 || i == 3) && j == 3 {
                    let btn_0 = UIButton(frame: CGRect(x: 2 * btnW, y: 3 * btnH, width: btnW * 2, height: btnH))
                    btn_0.setTitle("OK", for: .normal)
                    btn_0.backgroundColor = UIColor.red
                    btn_0.addTarget(self, action: #selector(okBtnClcked), for: .touchDown)
                    addSubview(btn_0)
                } else {
                    let btn = UIButton(frame: CGRect(x: CGFloat(i) * btnW, y: CGFloat(j) * btnH, width: btnW, height: btnH))
                    btn.backgroundColor = UIColor.randomColor()
                    btn.setTitle(btnTitles[j][i], for: .normal)
                    btn.addTarget(self, action: #selector(btnClicked(_:)), for: .touchUpInside)
                    addSubview(btn)
                }
            }
        }
    }
    
    func okBtnClcked() {
        print("---okBtnClcked")
    }
    
    func btnClicked(_ btn: UIButton) {
        print("---btnClicked---\(btn.titleLabel?.text)")
        switch btn.titleLabel!.text! {
        case "7":
            print(7)
            resultString += "7"
        case "8":
            print(8)
            resultString += "8"
        case "9":
            print(9)
            resultString += "9"
        case "4":
            print(4)
            resultString += "4"
        case "5":
            print(5)
            resultString += "5"
        case "6":
            print(6)
            resultString += "6"
        case "1":
            print(1)
            resultString += "1"
        case "2":
            print(2)
            resultString += "2"
        case "3":
            print(3)
            resultString += "3"
            
        case "0":
            print(0)
        case ".":
            print(".")
            
        case "⬅️":
            print("删除")
        case "+":
            print("+")
        case "-":
            print("-")
        default:
            print(100)
        }
//        let label = self.superview!.viewWithTag(1000) as! UILabel
//        label.text = resultString

       
    }
}
