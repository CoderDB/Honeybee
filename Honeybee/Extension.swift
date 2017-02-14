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
    
    func rotateY360() {
        let rotationAnimation = CABasicAnimation(keyPath: "transform.rotation.y")
        rotationAnimation.toValue = NSNumber(value: M_PI*2)
        rotationAnimation.duration = 0.4
        layer.add(rotationAnimation, forKey: "rotationAnimation")
    }
}


extension UIImage {
    
    static func image(color: UIColor,size: CGSize) -> UIImage {
        let rect = CGRect(x: 0, y: 0, width: size.width, height: size.height)
        UIGraphicsBeginImageContext(rect.size);
        let context = UIGraphicsGetCurrentContext();
        context?.setFillColor(color.cgColor);
        context?.fill(rect);
        
        let theImage = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
        return theImage!;
    }
    
    func roundedCornerImage(cornerRadius radius: CGFloat) -> UIImage {
        
        let w = self.size.width
        let h = self.size.height
        
        var targetCornerRadius = radius
        if radius < 0 {
            targetCornerRadius = 0
        }
        if radius > min(w, h) {
            targetCornerRadius = min(w,h)
        }
        
        let imageFrame = CGRect(x: 0, y: 0, width: w, height: h)
        UIGraphicsBeginImageContextWithOptions(self.size, false, UIScreen.main.scale)
        
        UIBezierPath(roundedRect: imageFrame, cornerRadius: targetCornerRadius).addClip()
        self.draw(in: imageFrame)
        
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        return image!
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
