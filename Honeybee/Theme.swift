//
//  Global.swift
//  Honeybee
//
//  Created by Dongbing Hou on 08/12/2016.
//  Copyright © 2016 Dongbing Hou. All rights reserved.
//

import UIKit

struct Theme {
    static let main = UIColor.RGB(r: 0, g: 187, b: 156)
    
    
}

struct HonybeeColor {
    static let main = UIColor.RGB(r: 250, g: 45, b: 66)
}

struct HonybeeFont {
    
    static let titleFont = UIFont(descriptor: UIFontDescriptor(fontAttributes: [UIFontDescriptorFamilyAttribute: "PingFang SC", UIFontDescriptorFaceAttribute: "Semibold"]), size: 36)
    
    
    static let recordDetailMainTitle = UIFont(descriptor: UIFontDescriptor(fontAttributes: [UIFontDescriptorFamilyAttribute: "PingFang SC", UIFontDescriptorFaceAttribute: "Semibold"]), size: 30)
    
    static let subTitleFont = UIFont(descriptor: UIFontDescriptor(fontAttributes: [UIFontDescriptorFamilyAttribute: "PingFang SC", UIFontDescriptorFaceAttribute: "Semibold"]), size: 18)
    
    static let weekFont = UIFont(descriptor: UIFontDescriptor(fontAttributes: [UIFontDescriptorFamilyAttribute: "PingFang SC", UIFontDescriptorFaceAttribute: "Semibold"]), size: 12)
    
//    static let recordDateFont = UIFont(descriptor: UIFontDescriptor(fontAttributes: [UIFontDescriptorFamilyAttribute: "PingFang SC", UIFontDescriptorFaceAttribute: "Semibold"]), size: 20)
    
    static let recordNumberFont = UIFont(name: "Silom", size: 30)
    static let recordDateFont = UIFont(name: "Silom", size: 18)
}

struct HonybeePriority {
    static let `default` = 1000
    static let mid = 720
    static let low = 250
}

