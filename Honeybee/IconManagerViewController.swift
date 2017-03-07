//
//  IconManagerViewController.swift
//  Honeybee
//
//  Created by Dongbing Hou on 24/02/2017.
//  Copyright © 2017 Dongbing Hou. All rights reserved.
//

import UIKit


class IconManagerViewController: BaseCollectionViewController {
    
    var dataSource = [Array(1...20), Array(1...20), Array(5...20), Array(5...20)]
    var headerTitles = ["生活日常", "每天吃饭", "住", "车"]
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNav(title: "图标管理")
        addNavRightItem()
        addCollectionView()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(false, animated: true)
    }
}

//MARK: UI
extension IconManagerViewController {
    func addCollectionView() {
        collectionView.snp.makeConstraints { (make) in
            make.edges.equalTo(view)
        }
        collectionView.register(IconManagerCell.self)
        collectionView.register(IconManagerSectionHeader.self)
        let longGesture = UILongPressGestureRecognizer(target: self, action: #selector(longGestureAction(_:)))
        collectionView.addGestureRecognizer(longGesture)
        
    }
    
    func longGestureAction(_ gesture: UILongPressGestureRecognizer) {
        switch gesture.state {
        case .began:
            guard let selectedIdx = collectionView.indexPathForItem(at: gesture.location(in: collectionView)) else {
                break
            }
            collectionView.beginInteractiveMovementForItem(at: selectedIdx)
        case .changed:
            collectionView.updateInteractiveMovementTargetPosition(gesture.location(in: gesture.view))
        case .ended:
            collectionView.endInteractiveMovement()
        default:
            collectionView.cancelInteractiveMovement()
        }
    }
    
    func addNavRightItem() {
        let btn = UIButton(frame: CGRect(x: 0, y: 0, width: 40, height: 25))
        btn.setTitle("添加", for: .normal)
        btn.setTitleColor(HB.Color.nav, for: .normal)
        btn.titleLabel?.font = HB.Font.h5
        btn.addTarget(self, action: #selector(navRightItemAction), for: .touchUpInside)
        navigationItem.rightBarButtonItem = UIBarButtonItem(customView: btn)
    }
    func navRightItemAction() {
        navigationController?.pushViewController(IconAddViewController(), animated: true)
    }
}


// MARK: UICollectionViewDataSource
extension IconManagerViewController {
    
    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return dataSource.count
    }
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return dataSource[section].count
    }
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "\(IconManagerCell.self)", for: indexPath) as! IconManagerCell
        
        cell.titleLabel.text = "\(dataSource[indexPath.section][indexPath.item])"
        return cell        
    }
}


// MARK: UICollectionViewDelegateFlowLayout
extension IconManagerViewController {
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
//        if kind == UICollectionElementKindSectionHeader {
            let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "\(IconManagerSectionHeader.self)", for: indexPath) as! IconManagerSectionHeader
            header.titleLabel.text = headerTitles[indexPath.section]
            return header
            
//        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print("-------\(indexPath.section)----\(indexPath.row)")
    }
    
    func collectionView(_ collectionView: UICollectionView, moveItemAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
        let moved = dataSource[sourceIndexPath.section].remove(at: sourceIndexPath.item)
        dataSource[destinationIndexPath.section].insert(moved, at: destinationIndexPath.item)
        
        let cell = collectionView.cellForItem(at: destinationIndexPath) as! IconManagerCell
        cell.titleLabel.text = "哈哈"
        cell.backgroundColor = UIColor.red
    }
}
