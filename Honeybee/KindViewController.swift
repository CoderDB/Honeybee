//
//  KindViewController.swift
//  Honeybee
//
//  Created by Dongbing Hou on 07/03/2017.
//  Copyright © 2017 Dongbing Hou. All rights reserved.
//

import UIKit
import RealmSwift
import RxRealmDataSources
import RxSwift
import RxCocoa

class KindViewController: BaseViewController, AlertProvider {

//    let rx_datasource = RxCollectionViewRealmDataSource(cellIdentifier: "") { (realm, collv, idx, obj) -> UICollectionViewCell in
//        
//    }
    var collectionView: UICollectionView!
    private let bag = DisposeBag()
    fileprivate let rx_datasource = RxCollectionViewRealmDataSource<HoneybeeKind>(cellIdentifier: "\(KindCell.self)", cellType: KindCell.self) { (cell, _, element) in
        cell.config(model: element)
    }
    
//    var dataSource: KindDataSource!
//    var notiToken: NotificationToken? = nil
    
    var managerKindBtn: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setNavTitle("类别管理")
        setNavRightItems()
        addCollectionView()
//        fetchData()
        
//        let realm = try! Realm(fileURL: FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!.appendingPathComponent("honeybee.realm"))
        
//        let kinds = Observable
//            .changeset(from: realm.objects(HoneybeeKind.self))
//            .share()
        
//        let kinds = Observable.changeset(from: Database.default.all(HoneybeeKind.self))
//        kinds.bind(to: collectionView.rx.realmChanges(rx_datasource)).disposed(by: bag)

//        collectionView.rx.setDataSource(rx_datasource).disposed(by: bag)
//        collectionView.rx.setDelegate(self).disposed(by: bag)
        
        let kinds = Database.default.all(HoneybeeKind.self)
        Observable.changeset(from: kinds)
            .bind(to: collectionView.rx.realmChanges(rx_datasource))
            .disposed(by: bag)
        
        collectionView.rx
            .itemSelected
            .map { idx in kinds[idx.row] }
            .subscribe { [unowned self] (kind) in
                let vc = KindDetailController()
                vc.kind = kind.element
                self.navigationController?.pushViewController(vc, animated: true)
            }
            .disposed(by: bag)
        
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        stopShake()
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
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: 150, height: 165)
        layout.sectionInset = UIEdgeInsets(top: 0, left: 25, bottom: 25, right: 25)
        collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.backgroundColor = .white
        collectionView.showsVerticalScrollIndicator = false
        collectionView.showsHorizontalScrollIndicator = false
        view.addSubview(collectionView)
        collectionView.snp.makeConstraints { (make) in
            make.edges.equalTo(view)
        }
        
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
                _ = cells.map({ (cell) in
                    cell.deleteBtn.isHidden = false; cell.shake()
                    deleteWith(cell: cell)
                })
            } else {
                _ = cells.map { $0.deleteBtn.isHidden = true; $0.stopShake() }
            }
        }
    }
    func stopShake() {
        if self.managerKindBtn.isSelected {
            self.managerKindBtnClicked(self.managerKindBtn)
        }
    }
    func deleteWith(cell: KindCell) {
        cell.deleteBtnAction = { [unowned self] in
            
            self.showWarning(message: "你要删除整个类别？？？😱", ok: { [unowned self] in
                self.stopShake()
//                if let idx = self.collectionView.indexPath(for: cell) {
//                    let kind = self.dataSource.item(at: idx)
//                    self.deleteFromDatabase(kind)
//                    self.collectionView.deselectItem(at: idx, animated: true)
//                }
            })
        }
    }
    func deleteFromDatabase(_ kind: HoneybeeKind) {
        do {
            let color = kind.color
            
            try Database.default.delete(item: kind, children: kind.items)
            do {
                try Database.default.update(HoneybeeColor.self, name: color, isUsed: false)
            } catch let error {
                print(error.localizedDescription)
                Reminder.error(msg: error.localizedDescription)
            }
        } catch {
            Reminder.error()
        }
        
    }
    
    func longGestureAction(_ gesture: UILongPressGestureRecognizer) {
        switch gesture.state {
        case .began:
            
            managerKindBtnClicked(managerKindBtn)
//            guard let selectedIdx = collectionView.indexPathForItem(at: gesture.location(in: collectionView)) else {
//                break
//            }
//            collectionView.beginInteractiveMovementForItem(at: selectedIdx)
            
//        case .changed:
//            collectionView.updateInteractiveMovementTargetPosition(gesture.location(in: collectionView))
            
//        case .ended:
//            collectionView.endInteractiveMovement()
//            break
//            collectionView.endInteractiveMovement()
//            managerKindBtnClicked(managerKindBtn)
//        case .cancelled:
//            collectionView.cancelInteractiveMovement()
//        case .failed:
//            collectionView.cancelInteractiveMovement()
//        case .possible:
//            collectionView.cancelInteractiveMovement()
        default:
//            collectionView.cancelInteractiveMovement()
            break
        }
    }
    
    func fetchData() {
//        let kinds = Honeybee.default.allKinds()
//        dataSource = KindDataSource(items: kinds.toArray)
//        collectionView.dataSource = dataSource
//        notiToken = kinds.addNotificationBlock { (change) in
//            self.collectionView.reloadData()
//        }
    }
    deinit {
//        notiToken?.stop()
    }
}


//// MARK: UICollectionViewDelegateFlowLayout
//extension KindViewController {
//    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
//        
////        print("-------\(indexPath.section)----\(indexPath.row)")
////        let vc = KindDetailController()
////        vc.kind = dataSource.item(at: indexPath)
////        navigationController?.pushViewController(vc, animated: true)
//    }
//}
