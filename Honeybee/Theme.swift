//
//  Global.swift
//  Honeybee
//
//  Created by Dongbing Hou on 08/12/2016.
//  Copyright © 2016 Dongbing Hou. All rights reserved.
//

import UIKit

struct HB {
    struct Screen {
        static let w = UIScreen.main.bounds.width
        static let h = UIScreen.main.bounds.height
    }
    
    struct Color {
        static let nav = UIColor(rgb: [250, 45, 66])
        static let main = UIColor(hex: "#00BEAD")//UIColor(rgb: [250, 45, 66])
    }
    
    struct Constant {
        static let cornerRadius: CGFloat = 10
        static let rowHeight: CGFloat = 60
        static let headerH: CGFloat = 115
    }
    
    struct Font {
        private static let attr_semibold = [
            UIFontDescriptorFamilyAttribute: "PingFang SC",
            UIFontDescriptorFaceAttribute: "Semibold"
        ]
        static let h1 = UIFont(descriptor: UIFontDescriptor(fontAttributes: attr_semibold), size: 48)
        static let h2 = UIFont(descriptor: UIFontDescriptor(fontAttributes: attr_semibold), size: 36)
        static let h3 = UIFont(descriptor: UIFontDescriptor(fontAttributes: attr_semibold), size: 30)
        static let h4 = UIFont(descriptor: UIFontDescriptor(fontAttributes: attr_semibold), size: 20)
        static let h5 = UIFont(descriptor: UIFontDescriptor(fontAttributes: attr_semibold), size: 18)
        static let h6 = UIFont(descriptor: UIFontDescriptor(fontAttributes: attr_semibold), size: 16)
        static let h7 = UIFont(descriptor: UIFontDescriptor(fontAttributes: attr_semibold), size: 12)
        
        private static let attr_medium = [
            UIFontDescriptorFamilyAttribute: "PingFang SC",
            UIFontDescriptorFaceAttribute: "Medium"
        ]
        static let h5_medium = UIFont(descriptor: UIFontDescriptor(fontAttributes: attr_medium), size: 18)
        static let h6_medium = UIFont(descriptor: UIFontDescriptor(fontAttributes: attr_medium), size: 16)
        
        private static let attr_light = [
            UIFontDescriptorFamilyAttribute: "PingFang SC",
            UIFontDescriptorFaceAttribute: "Light"
        ]
        static let h5_light = UIFont(descriptor: UIFontDescriptor(fontAttributes: attr_light), size: 18)
        
        
        static let h1_number = UIFont(name: "Silom", size: 70)!
        static let h2_number = UIFont(name: "Silom", size: 36)!
        static let h3_number = UIFont(name: "Silom", size: 30)!
        static let h4_number = UIFont(name: "Silom", size: 18)!
        
        static let h6_number = UIFont(name: "Silom", size: 8)!
    }
    
    struct Priority {
        static let high = 1000
        static let mid = 750
        static let low = 250
    }
}

