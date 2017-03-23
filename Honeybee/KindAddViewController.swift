//
//  KindAddViewController.swift
//  Honeybee
//
//  Created by Dongbing Hou on 07/03/2017.
//  Copyright © 2017 Dongbing Hou. All rights reserved.
//

import UIKit


class KindAddViewController: BaseCollectionViewController {

    fileprivate var dataSource: KindAddDataSource!
    fileprivate var header: KindAddHeader!
    
    fileprivate var alertController: UIAlertController!
    
    // add new kind
    fileprivate var kindName: String?
    fileprivate var kindColor: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        automaticallyAdjustsScrollViewInsets = false
        setNavTitle("添加种类")
        addHeader()
        addCollectionView()
        addTipLabel()
        
        fetchData()
    }
    
    func fetchData() {
        dataSource = KindAddDataSource()
        collectionView.dataSource = dataSource
    }
}


// MARK: UI
import RealmSwift
extension KindAddViewController {
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
            self.showTextFieldAlert(completion: { [unowned self] in
                self.createNewKind()
            })
        }
    }
    func createNewKind() {
        if let name = kindName, let color = kindColor {
            let kind = HoneybeeKind()
            kind.color = color
            kind.name = name
            kind.items = List<HoneybeeItem>()
            DatabaseManager.manager.create(HoneybeeKind.self, value: kind)
        }
    }
    func showTextFieldAlert(completion: @escaping () -> Void) {
        alertController = UIAlertController(title: "设置类名", message: "", preferredStyle: .alert)
        alertController.addTextField { (tf) in
            tf.placeholder = "不能超过四个字"
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


// MARK: HoneybeeViewProvider

extension KindAddViewController: HoneybeeViewProvider {
    func addTipLabel() {
        let frame = CGRect(x: HB.Screen.w - 50, y: 200, width: 50, height: 200)
        tipLabel(text: "选 择 一 种 颜 色", frame: frame)
    }
}


// MARK: UICollectionViewDelegateFlowLayout

extension KindAddViewController {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let name = dataSource.item(at: indexPath).name
        header.containerView.backgroundColor = UIColor(hex: name)
        kindColor = name
        print("-------\(indexPath.section)----\(indexPath.row)")
    }
}
