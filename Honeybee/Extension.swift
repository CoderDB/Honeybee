//
//  Extension.swift
//  Honeybee
//
//  Created by Dongbing Hou on 08/12/2016.
//  Copyright © 2016 Dongbing Hou. All rights reserved.
//

import UIKit

//******************************************************************************
// UITableView Extension
//******************************************************************************
//protocol NibLoadableView: class {}
//extension NibLoadableView where Self: UIView {
//    static var nibName: String {
//        return "\(self)"
//    }
//}
//protocol ReuseableView: class {}
//extension ReuseableView where Self: UIView {
//    static var reuseIdentifier: String { return "\(self)" }
//}
//extension UITableView {
//    func register<T: UITableViewCell>(_: T.Type) where T: ReuseableView, T: NibLoadableView {
//        let nib = UINib(nibName: T.nibName, bundle: nil)
//        register(nib, forCellReuseIdentifier: T.reuseIdentifier)
//    }
//}


//******************************************************************************
// UIColor Extension
//******************************************************************************
extension UIColor {
    static func hex(_ hex: String) -> UIColor {
        let hex = hex.trimmingCharacters(in: CharacterSet.alphanumerics.inverted)
        var int = UInt32()
        Scanner(string: hex).scanHexInt32(&int)
        let r, g, b, a: UInt32
        switch hex.characters.count {
        case 3:
            (r, g, b, a) = ((int >> 8) * 17, (int >> 4 & 0xF) * 17, (int & 0xF), 255)
        case 6:
            (r, g, b, a) = (int >> 16, int >> 8 & 0xF, int & 0xF, 255)
        case 8:
            (r, g, b, a) = (int >> 24, int >> 16 & 0xF, int >> 8 & 0xF, int & 0xF)
        default:
            (r, g, b, a) = (1, 1, 1, 0)
        }
        return rgba(r: Float(r), g: Float(g), b: Float(b), a: Float(a))
    }
    static func rgb(pure: Float) -> UIColor {
        return rgb(r: pure, g: pure, b: pure)
    }
    static func rgb(r: Float, g: Float, b: Float) -> UIColor {
        return rgba(r: r, g: g, b: b, a: 1)
    }
    static func rgba(r: Float, g: Float, b: Float,a: Float) -> UIColor {
        return UIColor(colorLiteralRed: r / 255.0, green: g / 255.0, blue: b / 255.0, alpha: a)
    }
    static func randomColor() -> UIColor {
        return UIColor(colorLiteralRed: Float(arc4random() % 256) / 255.0, green: Float(arc4random() % 256) / 255.0, blue: Float(arc4random() % 256) / 255.0, alpha: 1)
    }
    
}


//******************************************************************************
// UIView Extension
//******************************************************************************
extension UIView {
    
    func rotateY360() {
        let rotationAnimation = CABasicAnimation(keyPath: "transform.rotation.y")
        rotationAnimation.toValue = NSNumber(value: M_PI*2)
        rotationAnimation.duration = 0.4
        layer.add(rotationAnimation, forKey: "rotationAnimation")
    }
    
    
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


//******************************************************************************
// UIImage Extension
//******************************************************************************
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


//******************************************************************************
// CAGradientLayer
//******************************************************************************

extension CAGradientLayer {
    
    static func gradient(colors: [UIColor]) -> CAGradientLayer {
        let layer = CAGradientLayer()
        let cgColors = colors.map{ $0.cgColor }
        layer.colors = cgColors
        layer.locations = [0.0, 1.0]
        return layer
    }
}



//    override func draw(_ rect: CGRect) {
//        super.draw(rect)
//        guard let context = UIGraphicsGetCurrentContext() else {
//            return
//        }
//        context.saveGState()
//
//        let colorSpace = CGColorSpaceCreateDeviceRGB()
//
//        let startColor = UIColor.red
//        let startComponents = startColor.cgColor.components!
//        let endColor = UIColor.orange
//        let endComponents = endColor.cgColor.components!
//
//        let colorComponents = startComponents + endComponents
//        let location: [CGFloat] = [0, 1]
//        let gradient = CGGradient(colorSpace: colorSpace, colorComponents: colorComponents, locations: location, count: 2)
//
//        let startPoint = CGPoint(x: 0, y: rect.height)
//        let endPoint = CGPoint(x: rect.width, y: 0)
//
//        context.drawLinearGradient(gradient!, start: startPoint, end: endPoint, options: .drawsBeforeStartLocation)
//
//        context.restoreGState()
//    }
