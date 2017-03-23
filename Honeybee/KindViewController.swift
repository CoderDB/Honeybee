//
//  KindViewController.swift
//  Honeybee
//
//  Created by Dongbing Hou on 07/03/2017.
//  Copyright © 2017 Dongbing Hou. All rights reserved.
//

import UIKit
import RealmSwift

class KindViewController: BaseCollectionViewController {

    
    var dataSource: KindDataSource!
    var notiToken: NotificationToken? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setNavTitle("类别管理")
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
    override func navRightItemClicked(_ btn: UIButton) {
        navigationController?.pushViewController(KindAddViewController(), animated: true)
    }
    func fetchData() {
        let kinds = HoneybeeManager.manager.allKinds()
        dataSource = KindDataSource(items: kinds)
        collectionView.dataSource = dataSource
        notiToken = kinds.addNotificationBlock { (change) in
            self.collectionView.reloadData()
        }
    }
    deinit {
        notiToken?.stop()
    }
}


// MARK: UICollectionViewDelegateFlowLayout
extension KindViewController {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print("-------\(indexPath.section)----\(indexPath.row)")
        let vc = KindDetailController()
        vc.kind = dataSource.item(at: indexPath)
        navigationController?.pushViewController(vc, animated: true)
    }
}
