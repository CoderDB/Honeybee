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
        automaticallyAdjustsScrollViewInsets = false
        setNavTitle("衣")
        addHeader()
        addTipView()
        addCollectionView()
    }
    func addCollectionView() {
        layout.itemSize = CGSize(width: 45, height: 45)
        layout.minimumLineSpacing = 10      // 行间距
        layout.minimumInteritemSpacing = 10 // 列间距
        collectionView.contentInset = UIEdgeInsets(top: 15, left: 15, bottom: 50, right: 0)
        collectionView.snp.updateConstraints { (make) in
            make.top.equalTo(115+64-2)
            make.right.equalTo(view).offset(-58)
        }
        collectionView.register(KindCell.self)
    }
    func addHeader() {
        let header = KindDetailHeader(frame: CGRect(x: 0, y: 64, width: HB.Screen.w, height: 115))
        view.addSubview(header)
    }
    
    func addTipView() {
        let label = UILabel(frame: CGRect(x: HB.Screen.w - 50 - 40, y: 230, width: 130, height: 50))
        label.text = "长 按 可 删 除"
        label.font = HB.Font.h5_light
        label.textColor = UIColor.gray
        let tsf = CGAffineTransform()
        tsf.scaledBy(x: 1, y: -1)
        tsf.rotated(by: -90 * CGFloat.pi/180)
        
//        label.transform = CGAffineTransform(scaleX: -1, y: 1)
//        label.transform = CGAffineTransform(rotationAngle: -(CGFloat)(M_PI_2))
//        label.transform = label.transform.scaledBy(x: 1, y: -1)
        let t1 = CGAffineTransform(scaleX: -1, y: 1)//.rotated(by: -(CGFloat)(M_PI_2))
        let t2 = CGAffineTransform(rotationAngle: -(CGFloat)(M_PI_2))
        
        label.transform = t1.concatenating(t2)
        view.addSubview(label)
        
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
