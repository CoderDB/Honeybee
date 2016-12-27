//
//  Extension.swift
//  Honeybee
//
//  Created by Dongbing Hou on 08/12/2016.
//  Copyright © 2016 Dongbing Hou. All rights reserved.
//

import UIKit

extension UIColor {
    
    class func RGB(r: Float, g: Float, b: Float) -> UIColor {
        return RGBA(r: r, g: g, b: b, a: 1)
    }
    class func RGBA(r: Float, g: Float, b: Float,a: Float) -> UIColor {
        return UIColor(colorLiteralRed: r / 255.0, green: g / 255.0, blue: b / 255.0, alpha: a)
    }
    class func randomColor() -> UIColor {
        return UIColor(colorLiteralRed: Float(arc4random() % 256) / 255.0, green: Float(arc4random() % 256) / 255.0, blue: Float(arc4random() % 256) / 255.0, alpha: 1)
    }
    
}

