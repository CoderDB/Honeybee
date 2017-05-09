//
//  KindDetailController.swift
//  Honeybee
//
//  Created by Dongbing Hou on 08/03/2017.
//  Copyright © 2017 Dongbing Hou. All rights reserved.
//

import UIKit
import RealmSwift
import RxSwift
import RxCocoa
//import Then
import RxRealmDataSources

class KindDetailController: BaseViewController {
    
    var kind: HoneybeeKind!
    fileprivate var header: KindDetailHeader!
    
    fileprivate var alertController: UIAlertController!
    fileprivate var kindName: String?
    
    lazy var layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
    var collectionView: UICollectionView!
    
    let bag = DisposeBag()
    
    var rx_dataSource = RxCollectionViewRealmDataSource<HoneybeeItem>(cellIdentifier: "\(KindDetailCell.self)", cellType: KindDetailCell.self) { (cell, _, item) in
        cell.configWith(model: item, isEditing: false)
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        automaticallyAdjustsScrollViewInsets = false
        setNavTitle("衣")
        addHeader()
        addTipView()
        addCollectionView()
        
        configRx()
        
    }
    
    func configRx() {
        
        
        Observable.changeset(from: kind.items)
            .share()
            .bind(to: collectionView.rx.realmChanges(rx_dataSource))
            .disposed(by: bag)
        
        header.addBtn.rx
            .tap
            .subscribe(onNext: { [unowned self] in
                let vc = KindAddItemController()
                vc.kind = self.kind
                self.navigationController?.pushViewController(vc, animated: true)
            })
            .disposed(by: bag)
        
        let scan = header.deleteBtn.rx
            .tap
            .scan(false) { lastState, _ in
                !lastState
        }
        scan.bind(to: header.deleteBtn.rx.isSelected)
            .disposed(by: bag)
        
        scan.subscribe(onNext: { [unowned self] (isSelected) in
            if isSelected {
                self.allCellEditing()
            } else {
                self.allCellEndEdit()
            }
        }).disposed(by: bag)
        
        header.rightBtn.rx
            .tap
            .subscribe(onNext: { [unowned self] in
                self.showTextFieldAlert(completion: { [unowned self] in
                    self.updateItem()
                })
            })
            .disposed(by: bag)

    }
    deinit {
        print("KindDetailController---deinit")
    }
}


// MARK: UI

extension KindDetailController: HoneybeeViewProvider, AlertProvider {
    func addCollectionView() {
        collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        view.addSubview(collectionView)
        collectionView.backgroundColor = .white
        collectionView.showsVerticalScrollIndicator = false
        collectionView.showsHorizontalScrollIndicator = false
        layout.itemSize = CGSize(width: 65, height: 65)
        collectionView.contentInset = UIEdgeInsets(top: 10, left: 10, bottom: 50, right: 0)
        collectionView.snp.makeConstraints { (make) in
            make.top.equalTo(115+64)
            make.right.equalTo(view).offset(-60)
            make.left.bottom.equalTo(view)
        }
        collectionView.register(KindDetailCell.self)
        let longGesture = UILongPressGestureRecognizer(target: self, action: #selector(longGestureAction(_:)))
        collectionView.addGestureRecognizer(longGesture)
    }
    func addHeader() {
        header = KindDetailHeader(frame: CGRect(x: 0, y: 64, width: HB.Screen.w, height: 115))
        header.titleLabel.text = kind.name
        header.titleLabel.backgroundColor = UIColor(hex: kind.color)
        view.addSubview(header)
    }
    func updateItem() {
        if let name = kindName {
            header.titleLabel.text = name
            
            do {
                try Database.default.update(item: kind, name: name)
            } catch let error {
                print(error)
            }
        }
    }
    
    func showTextFieldAlert(completion: @escaping () -> Void) {
        alertController = UIAlertController(title: "设置类名", message: nil, preferredStyle: .alert)
        alertController.addTextField { (tf) in
            tf.placeholder = "不超过4个字"
            NotificationCenter.default.addObserver(self, selector: #selector(self.alertTextFieldTextDidChange(_:)), name: .UITextFieldTextDidChange, object: tf)
        }
        let cancelAction = UIAlertAction(title: "取消", style: .cancel) { _ in }
        let okAction = UIAlertAction(title: "确定", style: .default) { (_) in
            NotificationCenter.default.removeObserver(self, name: .UITextFieldTextDidChange, object: nil)
            completion()
        }
        okAction.isEnabled = false
        alertController.addAction(cancelAction)
        alertController.addAction(okAction)
        present(alertController, animated: true, completion: nil)
    }
    func alertTextFieldTextDidChange(_ noti: Notification) {
        if let textField = noti.object as? UITextField {
            if let text = textField.text, let okAction = alertController.actions.last {
                okAction.isEnabled = text.characters.count > 0
                var targetText = ""
                if text.characters.count > 4 {
                    let offset = text.index(text.startIndex, offsetBy: 4)
                    targetText = text.substring(to: offset)
                } else {
                    targetText = text
                }
                print(targetText)
                kindName = targetText
            }
        }
    }
    
    func addTipView() {
    let frame = CGRect(x: HB.Screen.w - 50, y: 200, width: 50, height: 130)
        tipLabel(text: "长 按 可 删 除", frame: frame)
    }
}


// MARK: long press to delete

extension KindDetailController {
    func allCellEditing() {
        rx_dataSource = RxCollectionViewRealmDataSource<HoneybeeItem>(cellIdentifier: "\(KindDetailCell.self)", cellType: KindDetailCell.self, cellConfig: { (cell, _, item) in
            cell.configWith(model: item, isEditing: true)
            
            cell.deleteBtn.rx.tap.subscribe(onNext: { [unowned self] in
                self.delete(item: item)
            }).disposed(by: self.bag)
        })
        Observable.changeset(from: kind.items)
            .share()
            .bind(to: collectionView.rx.realmChanges(rx_dataSource))
            .disposed(by: bag)
    }
    func allCellEndEdit() {
        rx_dataSource = RxCollectionViewRealmDataSource<HoneybeeItem>(cellIdentifier: "\(KindDetailCell.self)", cellType: KindDetailCell.self, cellConfig: { (cell, _, item) in
            cell.configWith(model: item, isEditing: false)
        })
        Observable.changeset(from: kind.items)
            .share()
            .bind(to: collectionView.rx.realmChanges(rx_dataSource))
            .disposed(by: bag)
    }
    
    
    func delete(item: HoneybeeItem) {
        do {
            try Database.default.delete(item: item, in: kind.items)
        } catch let err {
            Reminder.error(msg: err.localizedDescription)
        }
    }


    func longGestureAction(_ gesture: UILongPressGestureRecognizer) {
        switch gesture.state {
        case .began:
            allCellEditing()
//            header.deleteBtn.isSelected = true
            
        case .ended:
            collectionView.endInteractiveMovement()
        default:
            collectionView.cancelInteractiveMovement()
        }
    }
}
