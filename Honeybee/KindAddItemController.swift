//
//  KindAddItemController.swift
//  Honeybee
//
//  Created by Dongbing Hou on 10/03/2017.
//  Copyright © 2017 Dongbing Hou. All rights reserved.
//

import UIKit
import Then

class KindAddItemController: BaseCollectionViewController {

    
    var dataSource: KindAddItemDataSource!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        addHeader()
        addCollectionView()
    }
    
    func addHeader() {
        
        let header = KindAddItemHeader(frame: CGRect(x: 0, y: 64, width: HB.Screen.w, height: HB.Constant.headerH))
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

    func fetchData() {
        dataSource = KindAddItemDataSource(items: [])
        collectionView.dataSource = dataSource
    }
}
