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

    var collectionView: UICollectionView!
    var kinds: Results<HoneybeeKind>!
    private let bag = DisposeBag()
    fileprivate let rx_datasource = RxCollectionViewRealmDataSource<HoneybeeKind>(cellIdentifier: "\(KindCell.self)", cellType: KindCell.self) { (cell, _, element) in
        cell.config(model: element)
    }
    
    lazy var managerKindBtn: UIButton = {
        $0.frame = CGRect(x: 0, y: 0, width: 40, height: 25)
        $0.setTitle("编辑", for: .normal)
        $0.setTitle("完成", for: .selected)
        $0.setTitleColor(HB.Color.nav, for: .normal)
        $0.titleLabel?.font = HB.Font.h5
        $0.contentHorizontalAlignment = .right
        return $0
    }(UIButton())
    lazy var addNewKindBtn: UIButton = {
        $0.frame = CGRect(x: 0, y: 0, width: 40, height: 25)
        $0.setTitle("添加", for: .normal)
        $0.setTitleColor(HB.Color.nav, for: .normal)
        $0.titleLabel?.font = HB.Font.h5
        $0.contentHorizontalAlignment = .right
        return $0
    }(UIButton())
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setNavTitle("类别管理")
        setNavRightItems()
        addCollectionView()
        
        configRx()
    }
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        stopShake()
    }
    
    func configRx() {
        kinds = Database.default.all(HoneybeeKind.self)
        
        Observable.changeset(from: kinds)
            .bind(to: collectionView.rx.realmChanges(rx_datasource))
            .disposed(by: bag)
        
        collectionView.rx
            .itemSelected
            .map { [unowned self] idx in self.kinds[idx.row] }
            .subscribe { [unowned self] (kind) in
                let vc = KindDetailController()
                vc.kind = kind.element
                self.navigationController?.pushViewController(vc, animated: true)
            }
            .disposed(by: bag)
        
        
        addNewKindBtn.rx
            .tap
            .subscribe(onNext: { [weak self] _ in
                self?.navigationController?.pushViewController(KindAddViewController(), animated: true)
            })
            .disposed(by: bag)
        
        managerKindBtn.rx
            .tap
            .scan(false) { lastState, newValue in
                !lastState
            }
            .bind(to: managerKindBtn.rx.isSelected)
            .disposed(by: bag)
        
        managerKindBtn.rx
            .tap
            .scan(false) { lastState, _ in
                !lastState
            }
            .subscribe(onNext: { [unowned self] (state) in
                if let cells = self.collectionView.visibleCells as? [KindCell] {
                    if state {
                        _ = cells.map({ (cell) in
                            cell.deleteBtn.isHidden = false; cell.shake()
                            self.deleteWith(cell: cell)
                        })
                    } else {
                        _ = cells.map { $0.deleteBtn.isHidden = true; $0.stopShake() }
                    }
                }
            })
            .disposed(by: bag)
        
//        managerKindBtn.rx.tap.subscribe(onNext: { [weak self] in
//            
//        })
    }
    
    func setNavRightItems() {
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
                if let idx = self.collectionView.indexPath(for: cell) {
                    
                    self.deleteFromDatabase(self.kinds[idx.row])
                    self.collectionView.deselectItem(at: idx, animated: true)
                }
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
    
    deinit {
//        notiToken?.stop()
    }
}
