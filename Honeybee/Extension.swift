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
        
        let padding: CGFloat = 10
        let minX = bounds.minX + padding
        let maxX = bounds.maxX - padding
        
        let minY = bounds.minY + padding
        let maxY = bounds.maxY - padding - radius
        
        context.move(to: CGPoint(x: minX+radius, y: minY))
        context.addArc(tangent1End: CGPoint(x: maxX, y: minY), tangent2End: CGPoint(x: maxX, y: maxY), radius: radius)
        context.addArc(tangent1End: CGPoint(x: maxX, y: maxY), tangent2End: CGPoint(x: minX, y: maxY), radius: radius)
        context.addArc(tangent1End: CGPoint(x: minX, y: maxY), tangent2End: CGPoint(x: minX, y: minY), radius: radius)
        context.addArc(tangent1End: CGPoint(x: minX, y: minY), tangent2End: CGPoint(x: maxX, y: minY), radius: radius)
        
        UIGraphicsGetCurrentContext()?.drawPath(using: .fillStroke)
        let output = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return output!
    }
}
