//
//  KindAddItemController.swift
//  Honeybee
//
//  Created by Dongbing Hou on 10/03/2017.
//  Copyright © 2017 Dongbing Hou. All rights reserved.
//

import UIKit

protocol HoneybeeViewsProtocol {}
extension HoneybeeViewsProtocol {
    func tipLabel(text: String, frame: CGRect) -> UILabel {
        let label = UILabel()
        label.text = text
        label.font = HB.Font.h5_light
        label.textColor = UIColor.gray
        let t1 = CGAffineTransform(scaleX: -1, y: 1)//.rotated(by: -(CGFloat)(M_PI_2))
        let t2 = CGAffineTransform(rotationAngle: -90 * CGFloat.pi/180)
        label.transform = t1.concatenating(t2)
        label.frame = frame
        return label
    }
}

class KindAddItemController: BaseCollectionViewController, HoneybeeViewsProtocol {

    var kind: HoneybeeKind!
    var dataSource: KindAddItemDataSource!
    var header: KindAddItemHeader!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        automaticallyAdjustsScrollViewInsets = false
        
        setNavTitle(kind.name)
        addHeader()
        addCollectionView()
        addTipView()
        fetchData()
    }
    
    func addHeader() {
        header = KindAddItemHeader(frame: CGRect(x: 0, y: 64, width: HB.Screen.w, height: HB.Constant.headerH))
        header.titleLabel.text = kind.name
        view.addSubview(header)
    }
    func addCollectionView() {
        
        layout.itemSize = CGSize(width: 45, height: 45)
        collectionView.contentInset = UIEdgeInsets(top: 10, left: 10, bottom: 50, right: 0)
        collectionView.snp.updateConstraints { (make) in
            make.top.equalTo(115+64)
            make.right.equalTo(view).offset(-60)
        }
        collectionView.register(KindAddItemCell.self)
    }
    func addTipView() {
        let frame = CGRect(x: HB.Screen.w - 50, y: 200, width: 50, height: 260)
        let label = tipLabel(text: "名 字 最 长 不 能 超 过 四 个 字", frame: frame)
        view.addSubview(label)
    }
    func fetchData() {
        let items = HBKindManager.manager.allIcons()
        dataSource = KindAddItemDataSource(items: items)
        collectionView.dataSource = dataSource
    }
}

// MARK: UICollectionViewDelegateFlowLayout

extension KindAddItemController {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        header.imgView.image = nil
    }
}
