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
    fileprivate var dataSource: KindAddItemDataSource!
    fileprivate var header: KindAddItemHeader!
    
    fileprivate var alertController: UIAlertController!
    
    // add item (HoneybeeItem)
    fileprivate var kindName: String?
    fileprivate var iconName: String? = "meal" // default image
    
    override func viewDidLoad() {
        super.viewDidLoad()
        automaticallyAdjustsScrollViewInsets = false
//        kind.delegate = self
        setNavTitle(kind.name)
        addHeader()
        addCollectionView()
        addTipView()
        fetchData()
    }
    private func addCollectionView() {
        
        layout.itemSize = CGSize(width: 45, height: 45)
        collectionView.contentInset = UIEdgeInsets(top: 10, left: 10, bottom: 50, right: 0)
        collectionView.snp.updateConstraints { (make) in
            make.top.equalTo(115+64)
            make.right.equalTo(view).offset(-60)
        }
        collectionView.register(KindAddItemCell.self)
    }
    private func fetchData() {
        let items = Honeybee.default.allIcons()
        dataSource = KindAddItemDataSource(items: items.toArray)
        collectionView.dataSource = dataSource
    }
}

// MARK: Alert
//import RealmSwift
//: HoneybeeKindProtocol
extension KindAddItemController {
    
    func addHeader() {
        header = KindAddItemHeader(frame: CGRect(x: 0, y: 64, width: HB.Screen.w, height: HB.Constant.headerH))
        view.addSubview(header)
        header.rightButtonAction = { [unowned self] _ in
            self.showTextFieldAlert(completion: { 
                self.header.titleLabel.text = self.kindName
                self.insertItem()
            })
        }
    }
    func insertItem() {
        if let name = kindName, let icon = iconName {
            let model = HoneybeeItem()
            model.icon = icon
            model.name = name
            
//            self.kind.insert(item: model)
            
            do {
                try Database.default.insert(item: model, to: kind.items)
            } catch let error {
                print(error.localizedDescription)
            }
        }
    }
    
    func showTextFieldAlert(completion: @escaping () -> Void) {
        alertController = UIAlertController(title: "设置项目名", message: nil, preferredStyle: .alert)
        alertController.addTextField { (tf) in
            tf.placeholder = "不超过4个字哦"
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
}


// MARK: HoneybeeViewsProtocol

extension KindAddItemController: HoneybeeViewProvider {
    func addTipView() {
        let frame = CGRect(x: HB.Screen.w - 50, y: 200, width: 50, height: 260)
        tipLabel(text: "名 字 最 长 不 能 超 过 四 个 字", frame: frame)
    }
}


// MARK: UICollectionViewDelegateFlowLayout

extension KindAddItemController {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let name = dataSource.items[indexPath.item].name
        header.imgView.image = UIImage(named: name)
        iconName = name
    }
}


