//
//  KindAddViewController.swift
//  Honeybee
//
//  Created by Dongbing Hou on 07/03/2017.
//  Copyright © 2017 Dongbing Hou. All rights reserved.
//

import UIKit


class KindAddViewController: BaseCollectionViewController, HoneybeeViewsProtocol {

    
    var dataSource = ["衣", "食", "住", "行", "购物", "衣", "食", "住", "行", "购物", "衣", "食", "住", "行", "购物", "衣", "食", "住", "行", "购物", "衣", "食", "住", "行", "购物", "衣", "食", "住", "行", "购物", "衣", "食", "住", "行", "购物", "衣", "食", "住", "行", "购物"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        automaticallyAdjustsScrollViewInsets = false
        setNavTitle("添加种类")
        addHeader()
        addCollectionView()
        let frame = CGRect(x: HB.Screen.w - 50, y: 200, width: 50, height: 200)
        let label = tipLabel(text: "选 择 一 种 颜 色", frame: frame)
        view.addSubview(label)
        
    }
    func addCollectionView() {
        layout.itemSize = CGSize(width: 45, height: 45)
        collectionView.contentInset = UIEdgeInsets(top: 10, left: 10, bottom: 50, right: 0)
        collectionView.snp.updateConstraints { (make) in
            make.top.equalTo(115+64)
            make.right.equalTo(view).offset(-60)
        }
        collectionView.register(KindAddCell.self)
    }
    func addHeader() {
        let header = KindAddHeader(frame: CGRect(x: 0, y: 64, width: view.bounds.width, height: HB.Constant.headerH))
        view.addSubview(header)
    }
    
    func randomHSVColor() -> UIColor {
        let golden = 0.618033988749895
        var h = Double(arc4random())
        h *= golden
        h *= golden
        h.formTruncatingRemainder(dividingBy: 1)
        var s = Double(arc4random())
        s += golden
        s *= golden
        s.formTruncatingRemainder(dividingBy: 1)
        var v = Double(arc4random())
        v += golden
        v.formTruncatingRemainder(dividingBy: 1)
        
        
        return UIColor(hue: CGFloat(h), saturation: 0.3, brightness: 0.99, alpha: 1)
    }
}

// MARK: UICollectionViewDataSource
extension KindAddViewController {
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return dataSource.count
    }
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "\(KindAddCell.self)", for: indexPath) as! KindAddCell
        cell.backgroundColor = randomHSVColor()
        return cell
    }
}


// MARK: UICollectionViewDelegateFlowLayout
extension KindAddViewController {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print("-------\(indexPath.section)----\(indexPath.row)")
    }
}
