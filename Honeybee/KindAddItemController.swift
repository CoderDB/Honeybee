//
//  KindAddItemController.swift
//  Honeybee
//
//  Created by Dongbing Hou on 10/03/2017.
//  Copyright © 2017 Dongbing Hou. All rights reserved.
//

import UIKit



class KindAddItemController: BaseCollectionViewController {

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
//        let items = HBKindManager.manager.allIcons()
        dataSource = KindAddItemDataSource()
        collectionView.dataSource = dataSource
    }
}

// MARK: AlertProvider

extension KindAddItemController: AlertProvider {
    func addHeader() {
        header = KindAddItemHeader(frame: CGRect(x: 0, y: 64, width: HB.Screen.w, height: HB.Constant.headerH))
        header.titleLabel.text = kind.name
        view.addSubview(header)
        header.rightButtonAction = { [unowned self] _ in
            self.showTextField(title: "设置类名", message: "不能超过四个字", textField: { (tf) in
                
            }, ok: {
                
            })
        }
    }
}


// MARK: HoneybeeViewsProtocol

extension KindAddItemController: HoneybeeViewsProtocol {
    func addTipView() {
        let frame = CGRect(x: HB.Screen.w - 50, y: 200, width: 50, height: 260)
        tipLabel(text: "名 字 最 长 不 能 超 过 四 个 字", frame: frame)

    }
}


// MARK: UICollectionViewDelegateFlowLayout

extension KindAddItemController {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        header.imgView.image = nil
    }
}


