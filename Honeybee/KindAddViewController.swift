//
//  KindAddViewController.swift
//  Honeybee
//
//  Created by Dongbing Hou on 07/03/2017.
//  Copyright © 2017 Dongbing Hou. All rights reserved.
//

import UIKit


class KindAddViewController: BaseCollectionViewController {

    
    var dataSource = ["衣", "食", "住", "行", "购物", "衣", "食", "住", "行", "购物"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setNavTitle("添加种类")
        addHeader()
        addCollectionView()
    }
    func addCollectionView() {
        layout.itemSize = CGSize(width: 45, height: 45)
        layout.minimumLineSpacing = 10      // 行间距
        layout.minimumInteritemSpacing = 10 // 列间距
        layout.sectionHeadersPinToVisibleBounds = true
        layout.headerReferenceSize = CGSize(width: view.bounds.width, height: 50)
        collectionView.contentInset = UIEdgeInsets(top: 0, left: 15, bottom: 50, right: 15)
        collectionView.snp.updateConstraints { (make) in
            make.top.equalTo(HB.Constant.headerH)
        }
        collectionView.register(KindAddCell.self)
        collectionView.register(IconManagerSectionHeader.self)
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
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "\(IconManagerSectionHeader.self)", for: indexPath) as! IconManagerSectionHeader
        header.titleLabel.text = "选择一种颜色"
        return header
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print("-------\(indexPath.section)----\(indexPath.row)")
    }
}
