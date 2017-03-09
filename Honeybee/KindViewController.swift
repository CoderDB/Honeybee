//
//  KindViewController.swift
//  Honeybee
//
//  Created by Dongbing Hou on 07/03/2017.
//  Copyright © 2017 Dongbing Hou. All rights reserved.
//

import UIKit

class KindViewController: BaseCollectionViewController {

    
    var dataSource: KindDataSource!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setNavTitle("添加图标")
        setNavRightItem("添加种类")
        addCollectionView()
        fetchData()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(false, animated: true)
    }
    func addCollectionView() {
        layout.itemSize = CGSize(width: 150, height: 165)
        layout.sectionInset = UIEdgeInsets(top: 0, left: 25, bottom: 25, right: 25)
        collectionView.register(KindCell.self)
    }
    override func navRightItemClicked() {
        navigationController?.pushViewController(KindAddViewController(), animated: true)
    }
    func fetchData() {
        let kinds = HBKindManager.manager.allKinds()
        dataSource = KindDataSource(id: "\(KindCell.self)", items: kinds)
        collectionView.dataSource = dataSource
    }
}


// MARK: UICollectionViewDelegateFlowLayout
extension KindViewController {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print("-------\(indexPath.section)----\(indexPath.row)")
        let vc = KindDetailController()
        vc.kind = dataSource.item(at: indexPath) as! HoneybeeKind
        navigationController?.pushViewController(vc, animated: true)
    }
}
