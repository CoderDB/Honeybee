//
//  KindDetailController.swift
//  Honeybee
//
//  Created by Dongbing Hou on 08/03/2017.
//  Copyright © 2017 Dongbing Hou. All rights reserved.
//

import UIKit

class KindDetailController: BaseCollectionViewController {
    
    var dataSource = Array(1...100)
    

    override func viewDidLoad() {
        super.viewDidLoad()
        setNavTitle("衣")
        addHeader()
        addCollectionView()
    }
    func addCollectionView() {
        layout.itemSize = CGSize(width: 45, height: 45)
        layout.minimumLineSpacing = 10      // 行间距
        layout.minimumInteritemSpacing = 10 // 列间距
        collectionView.snp.updateConstraints { (make) in
            make.top.equalTo(115+64)
        }
        collectionView.register(KindCell.self)
    }
    func addHeader() {
        let header = KindDetailHeader(frame: CGRect(x: 0, y: 64, width: HB.Screen.w, height: 115))
        view.addSubview(header)
    }
}




// MARK: UICollectionViewDataSource
extension KindDetailController {
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return dataSource.count
    }
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "\(KindCell.self)", for: indexPath) as! KindCell
        cell.titleLabel.text = "\(dataSource[indexPath.item])"
        return cell
    }
}


// MARK: UICollectionViewDelegateFlowLayout
extension KindDetailController {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print("-------\(indexPath.section)----\(indexPath.row)")
    }
}
