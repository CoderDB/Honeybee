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
    
    var managerKindBtn: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setNavTitle("类别管理")
//        setNavRightItem("添加种类")
        setNavRightItems()
        addCollectionView()
        fetchData()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(false, animated: true)
    }
    func setNavRightItems() {
        let addNewKindBtn = UIButton(type: .custom)
        addNewKindBtn.frame = CGRect(x: 0, y: 0, width: 40, height: 25)
        addNewKindBtn.setTitle("添加", for: .normal)
        addNewKindBtn.setTitleColor(HB.Color.nav, for: .normal)
        addNewKindBtn.titleLabel?.font = HB.Font.h5
        addNewKindBtn.contentHorizontalAlignment = .right
        addNewKindBtn.addTarget(self, action: #selector(addNewKindBtnClicked), for: .touchUpInside)
        
        managerKindBtn = UIButton(type: .custom)
        managerKindBtn.frame = CGRect(x: 0, y: 0, width: 40, height: 25)
        managerKindBtn.setTitle("编辑", for: .normal)
        managerKindBtn.setTitle("完成", for: .selected)
        managerKindBtn.setTitleColor(HB.Color.nav, for: .normal)
        managerKindBtn.titleLabel?.font = HB.Font.h5
        managerKindBtn.contentHorizontalAlignment = .right
        managerKindBtn.addTarget(self, action: #selector(managerKindBtnClicked(_:)), for: .touchUpInside)
        
        let items = [UIBarButtonItem(customView: addNewKindBtn), UIBarButtonItem(customView: managerKindBtn)]
        navigationItem.setRightBarButtonItems(items, animated: true)
    }
    
    func addCollectionView() {
        layout.itemSize = CGSize(width: 150, height: 165)
        layout.sectionInset = UIEdgeInsets(top: 0, left: 25, bottom: 25, right: 25)
        collectionView.register(KindCell.self)
        
        let longGesture = UILongPressGestureRecognizer(target: self, action: #selector(longGestureAction(_:)))
        collectionView.addGestureRecognizer(longGesture)
    }
    func addNewKindBtnClicked() {
        navigationController?.pushViewController(KindAddViewController(), animated: true)
    }
    func managerKindBtnClicked(_ btn: UIButton) {
        btn.isSelected = !btn.isSelected
        if let cells = collectionView.visibleCells as? [KindCell] {
            if btn.isSelected {
                _ = cells.map { $0.deleteBtn.isHidden = false; $0.shake() }
            } else {
                _ = cells.map { $0.deleteBtn.isHidden = true; $0.stop() }
            }
        }
    }
    
    
    func longGestureAction(_ gesture: UILongPressGestureRecognizer) {
        switch gesture.state {
        case .began:
            if let cells = collectionView.visibleCells as? [KindCell] {
                _ = cells.map { $0.deleteBtn.isHidden = false; $0.shake() }
                managerKindBtn.isSelected = true
            }
        case .ended:
            collectionView.endInteractiveMovement()
//            managerKindBtn.isSelected = false
        default:
            collectionView.cancelInteractiveMovement()
//            managerKindBtn.isSelected = false
        }
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
