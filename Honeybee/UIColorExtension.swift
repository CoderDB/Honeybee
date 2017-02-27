//
//  UIColorExtension.swift
//  Honeybee
//
//  Created by Dongbing Hou on 27/02/2017.
//  Copyright © 2017 Dongbing Hou. All rights reserved.
//

import UIKit

//******************************************************************************
// UIColor Extension
//******************************************************************************
extension UIColor {
    
    convenience init(pure: CGFloat) {
        self.init(red: pure / 255.0, green: pure / 255.0, blue: pure / 255.0, alpha: 1.0)
    }
    convenience init(rgb: [CGFloat]) {
        self.init(red: rgb[0] / 255.0, green: rgb[1] / 255.0, blue: rgb[2] / 255.0, alpha: 1.0)
    }
    convenience init(rgba: [CGFloat]) {
        self.init(red: rgba[0] / 255.0, green: rgba[1] / 255.0, blue: rgba[2] / 255.0, alpha: rgba[3] / 255.0)
    }
    convenience init(hex: String) {
        let hex = hex.trimmingCharacters(in: CharacterSet.alphanumerics.inverted)
        var int = UInt32()
        Scanner(string: hex).scanHexInt32(&int)
        let a, r, g, b: UInt32
        switch hex.characters.count {
        case 3: // RGB (12-bit)
            (a, r, g, b) = (255, (int >> 8) * 17, (int >> 4 & 0xF) * 17, (int & 0xF) * 17)
        case 6: // RGB (24-bit)
            (a, r, g, b) = (255, int >> 16, int >> 8 & 0xFF, int & 0xFF)
        case 8: // ARGB (32-bit)
            (a, r, g, b) = (int >> 24, int >> 16 & 0xFF, int >> 8 & 0xFF, int & 0xFF)
        default:
            (a, r, g, b) = (1, 1, 1, 0)
        }
        self.init(rgba: [CGFloat(r), CGFloat(g), CGFloat(b), CGFloat(a)])
    }
    
    static func randomColor() -> UIColor {
        return UIColor(colorLiteralRed: Float(arc4random() % 256) / 255.0, green: Float(arc4random() % 256) / 255.0, blue: Float(arc4random() % 256) / 255.0, alpha: 1)
    }
}
