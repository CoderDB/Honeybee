//
//  UITableViewExtension.swift
//  Honeybee
//
//  Created by Dongbing Hou on 27/02/2017.
//  Copyright © 2017 Dongbing Hou. All rights reserved.
//

import UIKit


protocol NibLoadableView: class {}
protocol ReuseableView: class {}

extension NibLoadableView where Self: UIView {
    static var nibName: String {
        return "\(self)"
    }
}

extension ReuseableView where Self: UIView {
    static var reuseIdentifier: String { return "\(self)" }
}

extension UITableView: ReuseableView {
    func register<T: UITableViewCell>(_: T.Type) where T: ReuseableView, T: NibLoadableView {
        let nib = UINib(nibName: T.nibName, bundle: nil)
        register(nib, forCellReuseIdentifier: T.reuseIdentifier)
    }
    
    func register<T: UITableViewCell>(_: T.Type) {
        register(T.self, forCellReuseIdentifier: "\(T.self)")
    }
}

//extension UITableViewCell {
//    static var className: String {
//        return String(describing: self)
//    }
//    static func className(obj: Any) -> String {
//        return String(describing: type(of: obj)).components(separatedBy: "__").last!
//    }
//}

extension UICollectionView: ReuseableView {
    
    func register<T: UICollectionViewCell>(_: T.Type) {
        register(T.self, forCellWithReuseIdentifier: "\(T.self)")
    }
    func register<T: UIView>(_: T.Type, kind: String? = UICollectionElementKindSectionHeader) {
        register(T.self, forSupplementaryViewOfKind: kind!, withReuseIdentifier: "\(T.self)")
    }
}

