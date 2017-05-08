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

class KindDetailController: BaseViewController {
    
    var kind: HoneybeeKind!
    fileprivate var header: KindDetailHeader!
    
    fileprivate var alertController: UIAlertController!
    fileprivate var kindName: String?
    
    fileprivate var dataSource: KindDetailDataSource! {
        didSet {
            collectionView.reloadData()
        }
    }
    
    lazy var layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
    var collectionView: UICollectionView!
//    let collectionView: UICollectionView = UICollectionView().then {
//        $0.backgroundColor = .white
//        $0.showsVerticalScrollIndicator = false
//        $0.showsHorizontalScrollIndicator = false
//        $0.collectionViewLayout = layout
////        view.dataSource = self
////        view.delegate = self
//    }
    
//    var notiToken: NotificationToken? = nil
    
    var viewModel: KindDetailViewModel!
    
    let bag = DisposeBag()
    
    var new_dataSource: ConfigurableDataSourceCollectionViewDataSource<KindDetailViewModel, KindDetailCell>!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        automaticallyAdjustsScrollViewInsets = false
        setNavTitle("衣")
        addHeader()
        addTipView()
        addCollectionView()
//        fetchData()
        
        configRx()
        
    }
    
    func configRx() {
        Observable.collection(from: kind.items)
            .bind(to: collectionView.rx.items(
                cellIdentifier: "\(KindDetailCell.self)",
                cellType: KindDetailCell.self)
                ) { row, item, cell in
                    cell.configWith(model: item, isEditing: false)
            }
            .disposed(by: bag)

    }
    fileprivate func fetchData() {
//        dataSource = KindDetailDataSource(items:kind.items)
        viewModel = KindDetailViewModel(kind: kind)
        new_dataSource = ConfigurableDataSourceCollectionViewDataSource<KindDetailViewModel, KindDetailCell>(model: viewModel)
        collectionView.dataSource = new_dataSource
        
//        notiToken = kind.items._addNotificationBlock { (changege) in
//            self.collectionView.reloadData()
//        }
    }
    deinit {
//        notiToken?.stop()
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
        
        header.addNewItemAction = { [unowned self] in
            let vc = KindAddItemController()
            vc.kind = self.kind
            self.navigationController?.pushViewController(vc, animated: true)
        }
        header.deleteBtnAction = { btn in
            if btn.isSelected {
                self.allCellEditing()
            } else {
                self.allCellEndEdit()
            }
        }
        header.rightButtonAction = { [unowned self] _ in
            self.showTextFieldAlert(completion: { [unowned self] in
                self.updateItem()
            })
        }
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
        dataSource = KindDetailDataSource(items: kind.items, isEditing: true)
        collectionView.dataSource = dataSource
    }
    func allCellEndEdit() {
        dataSource = KindDetailDataSource(items: kind.items, isEditing: false)
        collectionView.dataSource = dataSource
    }
    func longGestureAction(_ gesture: UILongPressGestureRecognizer) {
        switch gesture.state {
        case .began:
            allCellEditing()
            header.deleteBtn.isSelected = true
            
        case .ended:
            collectionView.endInteractiveMovement()
        default:
            collectionView.cancelInteractiveMovement()
        }
    }
}



// MARK: UICollectionViewDelegateFlowLayout

extension KindDetailController {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print("-------\(indexPath.section)----\(indexPath.row)")
    }
}
