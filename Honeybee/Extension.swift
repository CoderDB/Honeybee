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
    
    static func image(color: UIColor) -> UIImage {
        let rect = CGRect(x: 0, y: 0, width: 10, height: 10)
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



//******************************************************************************
// Date
//******************************************************************************


extension Date {
    
    /// "2017-02-26 09:30:18 +0000" -> 2017-02-26 09:30:18 +0000
    static func date(str: String) -> Date {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd HH:mm:ss Z"
        return formatter.date(from: str)!
    }
    
    /// 2017-02-26 10:48:11 +0000 -> 2017-02-26 18:48:11 +0000
    static func currentTimeZoneDateFrom(aDate date: Date) -> Date {
        let sourceTZ = TimeZone(abbreviation: "GMT")!
        let destTZ = TimeZone.current
        let sourceOffset = sourceTZ.secondsFromGMT(for: date)
        let destOffset = destTZ.secondsFromGMT(for: date)
        let interval = TimeInterval(destOffset - sourceOffset)
        return Date(timeInterval: interval, since: date)
    }
    /// 2017-02-26 18:35:52 +0000 -> ("2017-02-26", "18:35")  //("2017", "02", "26")
    static func yearMonthDayHourMinute(date: Date) -> (String, String) {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd MM:ss"
        formatter.timeZone = TimeZone(abbreviation: "GMT")
        let dateStr = formatter.string(from: date)
        let components = dateStr.components(separatedBy: " ")
        return (components[0], components[1])
    }
    
    
    
    /// 2017-02-26 18:35:52 +0000 -> ("2017", "02", "26")
    static func yearMonthDay(date: Date) -> (year: String, month: String, day: String) {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        formatter.timeZone = TimeZone(abbreviation: "GMT")
        let dateStr = formatter.string(from: date)
        let components = dateStr.components(separatedBy: "-")
        return (components[0], components[1], components[2])
    }
//    /// 2017-02-26 18:35:52 +0000 -> "02月26日")
//    static func monthDay(date: Date) -> String {
//        let formatter = DateFormatter()
//        formatter.dateFormat = "MM月dd日"
//        formatter.timeZone = TimeZone(abbreviation: "GMT")
//        let dateStr = formatter.string(from: date)
//        return dateStr
//    }
    /// 2017-02-26 18:35:52 +0000 -> "2-26"
    static func monthDay(date: Date) -> String {
        var cal = Calendar(identifier: .gregorian)
        cal.timeZone = TimeZone(identifier: "GMT")!
        let day = cal.component(.day, from: date)
        let month = cal.component(.month, from: date)
//        let year = cal.component(.year, from: date)
        //        let ymd = cal.dateComponents([.year, .month, .day], from: date)
        return "\(month)月-\(day)日"
    }
    
    static func weekday(date: Date) -> String {
        // "EEEE, MMMM, dd, yyyy"
        var cal = Calendar(identifier: .gregorian)
        cal.timeZone = TimeZone(identifier: "GMT")!
        let weekday = cal.component(.weekday, from: date)
        switch weekday {
        case 1:
            return "星期一"
        case 2:
            return "星期二"
        case 3:
            return "星期三"
        case 4:
            return "星期四"
        case 5:
            return "星期五"
        case 6:
            return "星期六"
        case 7:
            return "星期日"
        default:
            return ""
        }
    }
}
