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
        collectionView.snp.makeConstraints { (make) in
            make.top.equalTo(115)
            make.bottom.right.left.equalTo(view)
        }
        collectionView.register(KindCell.self)
    }
    func addHeader() {
        let header = KindAddHeader(frame: CGRect(x: 0, y: 64, width: view.bounds.width, height: 115))
        view.addSubview(header)
    }
}

// MARK: UICollectionViewDataSource
extension KindAddViewController {
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return dataSource.count
    }
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "\(KindCell.self)", for: indexPath) as! KindCell
        cell.titleLabel.text = dataSource[indexPath.item]
        return cell
    }
}


// MARK: UICollectionViewDelegateFlowLayout
extension KindAddViewController {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print("-------\(indexPath.section)----\(indexPath.row)")
    }
}
