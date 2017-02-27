//
//  Global.swift
//  Honeybee
//
//  Created by Dongbing Hou on 08/12/2016.
//  Copyright © 2016 Dongbing Hou. All rights reserved.
//

import UIKit

struct Theme {
    static let main = UIColor(rgb: [0, 187, 156])
    
}

struct HonybeeColor {
    static let main = UIColor(rgb: [250, 45, 66])
}

struct HonybeeConstant {
    static let cornerRadius: CGFloat = 10
    static let rowHeight: CGFloat = 60
}

struct HonybeeFont {
    
    static let h1 = UIFont(descriptor: UIFontDescriptor(fontAttributes: [UIFontDescriptorFamilyAttribute: "PingFang SC", UIFontDescriptorFaceAttribute: "Semibold"]), size: 48)
    static let h2 = UIFont(descriptor: UIFontDescriptor(fontAttributes: [UIFontDescriptorFamilyAttribute: "PingFang SC", UIFontDescriptorFaceAttribute: "Semibold"]), size: 36)
    static let h3 = UIFont(descriptor: UIFontDescriptor(fontAttributes: [UIFontDescriptorFamilyAttribute: "PingFang SC", UIFontDescriptorFaceAttribute: "Semibold"]), size: 30)
    static let h4 = UIFont(descriptor: UIFontDescriptor(fontAttributes: [UIFontDescriptorFamilyAttribute: "PingFang SC", UIFontDescriptorFaceAttribute: "Semibold"]), size: 20)
    static let h5 = UIFont(descriptor: UIFontDescriptor(fontAttributes: [UIFontDescriptorFamilyAttribute: "PingFang SC", UIFontDescriptorFaceAttribute: "Semibold"]), size: 18)
    static let h5_medium = UIFont(descriptor: UIFontDescriptor(fontAttributes: [UIFontDescriptorFamilyAttribute: "PingFang SC", UIFontDescriptorFaceAttribute: "Medium"]), size: 18)
    static let h6 = UIFont(descriptor: UIFontDescriptor(fontAttributes: [UIFontDescriptorFamilyAttribute: "PingFang SC", UIFontDescriptorFaceAttribute: "Medium"]), size: 16)
    static let h7 = UIFont(descriptor: UIFontDescriptor(fontAttributes: [UIFontDescriptorFamilyAttribute: "PingFang SC", UIFontDescriptorFaceAttribute: "Semibold"]), size: 12)
    
    
    static let h1_number = UIFont(name: "Silom", size: 70)!
    static let h2_number = UIFont(name: "Silom", size: 36)!
    static let h3_number = UIFont(name: "Silom", size: 30)!
    static let h4_number = UIFont(name: "Silom", size: 18)!
    
    static let h6_number = UIFont(name: "Silom", size: 8)!
}

struct HonybeePriority {
    static let `default` = 1000
    static let mid = 720
    static let low = 250
}

