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

extension UIView {

    func roundRect(cornerRadius radius: CGFloat) -> UIImage {
        
        let size = CGSize(width: bounds.width, height: bounds.height)
        UIGraphicsBeginImageContextWithOptions(size, false, UIScreen.main.scale)
        let context = UIGraphicsGetCurrentContext()!
        context.setLineWidth(1.0)
        context.setStrokeColor(UIColor.black.cgColor)
        context.setFillColor(UIColor.white.cgColor)
        let width = size.width, height = size.height
        
        context.move(to: CGPoint(x: 10+5, y: 10))

        context.addArc(tangent1End: CGPoint(x: 10+5, y: 10), tangent2End: CGPoint(x: width - 10, y: 10), radius: radius)
        context.addArc(tangent1End: CGPoint(x: width - 10, y: 10), tangent2End: CGPoint(x: width-10, y: height-10), radius: radius)
        
        context.addArc(tangent1End: CGPoint(x: width-10, y: height-10), tangent2End: CGPoint(x: 10, y: height-10), radius: radius)
        context.addArc(tangent1End: CGPoint(x: 10, y: height-10), tangent2End: CGPoint(x: 10, y: 10), radius: radius)
        context.addArc(tangent1End: CGPoint(x: 10, y: 10), tangent2End: CGPoint(x: width-10, y: 10), radius: radius)
        
        
        UIGraphicsGetCurrentContext()?.drawPath(using: .fillStroke)
        let output = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return output!
    }
}
