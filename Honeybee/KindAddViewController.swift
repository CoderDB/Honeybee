//
//  KindAddViewController.swift
//  Honeybee
//
//  Created by Dongbing Hou on 07/03/2017.
//  Copyright © 2017 Dongbing Hou. All rights reserved.
//

import UIKit


class KindAddViewController: BaseCollectionViewController, HoneybeeViewProvider, AlertProvider {

    
    var dataSource: KindAddDataSource!
    var header: KindAddHeader!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        automaticallyAdjustsScrollViewInsets = false
        setNavTitle("添加种类")
        addHeader()
        addCollectionView()
        let frame = CGRect(x: HB.Screen.w - 50, y: 200, width: 50, height: 200)
        tipLabel(text: "选 择 一 种 颜 色", frame: frame)
        
        fetchData()
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
        header = KindAddHeader(frame: CGRect(x: 0, y: 64, width: view.bounds.width, height: HB.Constant.headerH))
        view.addSubview(header)
        header.rightButtonAction = { [unowned self] _ in
            self.showTextField(title: "设置类名", message: "不能超过四个字", textField: { (tf) in
                
            }, ok: {
                
            })
        }
    }
    func fetchData() {
        dataSource = KindAddDataSource()
        collectionView.dataSource = dataSource
    }
}



// MARK: UICollectionViewDelegateFlowLayout
extension KindAddViewController {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if let color = dataSource.item(at: indexPath) as? UIColor {
            header.containerView.backgroundColor = color
        }
        print("-------\(indexPath.section)----\(indexPath.row)")
    }
}
