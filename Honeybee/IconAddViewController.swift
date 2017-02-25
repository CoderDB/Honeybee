//
//  IconAddViewController.swift
//  Honeybee
//
//  Created by Dongbing Hou on 25/02/2017.
//  Copyright © 2017 Dongbing Hou. All rights reserved.
//

import UIKit

class IconAddViewController: BaseViewController {
    
    var collectionView: UICollectionView!
    var dataSource = ["衣", "食", "住", "行", "购物", "衣", "食", "住", "行", "购物"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNav(title: "添加图标")
        addCollectionView()
    }
    
    func addCollectionView() {
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: 150, height: 165)
        layout.minimumLineSpacing = 25      // 行间距
        layout.minimumInteritemSpacing = 25 // 列间距
        layout.sectionInset = UIEdgeInsets(top: 0, left: 25, bottom: 25, right: 25)
        
        collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.backgroundColor = UIColor.white
        collectionView.dataSource = self
        collectionView.delegate = self
        view.addSubview(collectionView)
        collectionView.snp.makeConstraints { (make) in
            make.top.equalTo(64)
            make.left.right.bottom.equalTo(view)
        }
        collectionView.register(IconAddCell.self, forCellWithReuseIdentifier: "\(IconAddCell.self)")
    }
}


// MARK: UICollectionViewDataSource
extension IconAddViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return dataSource.count
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "\(IconAddCell.self)", for: indexPath) as! IconAddCell
        cell.titleLabel.text = dataSource[indexPath.item]
        return cell
    }
}


// MARK: UICollectionViewDelegateFlowLayout
extension IconAddViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print("-------\(indexPath.section)----\(indexPath.row)")
    }
}
