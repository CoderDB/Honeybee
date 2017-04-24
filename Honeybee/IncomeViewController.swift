//
//  IncomeViewController.swift
//  Honeybee
//
//  Created by Dongbing Hou on 21/04/2017.
//  Copyright © 2017 Dongbing Hou. All rights reserved.
//

import UIKit
import RealmSwift

class IncomeViewController: BaseViewController {
    
    var collectionView: UICollectionView!
    var dataSource: IncomeDataSource!
    
    var notiToken: NotificationToken? = nil
    
    fileprivate var alertController: UIAlertController!
    var newKindName: String! = nil
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        fetchData()
    }
    
    func setupUI() {
        
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: 80, height: 40)
        collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.backgroundColor = .white
        collectionView.contentInset = UIEdgeInsets(top: 0, left: 15, bottom: 50, right: 15)
        collectionView.register(IncomeCell.self)
        collectionView.delegate = self
        
        view.addSubview(collectionView)
        collectionView.snp.makeConstraints { (make) in
            make.top.equalTo(view).offset(64)
            make.left.right.bottom.equalTo(view)
        }
    }
    
    func fetchData() {
        
        
        var incomes = Honeybee.default.all(HoneybeeIncome.self).toArray
        
        let last = HoneybeeIncome()
        last.color = "RRR"
        last.name = "+"
        incomes.append(last)
        
        dataSource = IncomeDataSource(items: incomes)
        collectionView.dataSource = dataSource
        
        
        
        notiToken = Database.default.notification({ [unowned self] (_, realm) in
            var incomes = realm.objects(HoneybeeIncome.self).toArray
            
            let last = HoneybeeIncome()
            last.color = "RRR"
            last.name = "+"
            incomes.append(last)
            
            self.dataSource = IncomeDataSource(items: incomes)
            self.collectionView.dataSource = self.dataSource
        })
       
    }
    
    deinit {
        notiToken = nil
    }
}


extension IncomeViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        if indexPath.row == dataSource.items.count - 1 {
            print("最后")
            addNewIncomeKind()
        } else {
            
        }
    }
    
    
    func addNewIncomeKind() {
        showTextFieldAlert { 
            self.insertItem()
        }
    }
    
    
    
    func insertItem() {
        if let name = newKindName {
            let model = HoneybeeIncome()
            model.color = "CCC"
            model.name = name
            
            do {
                try Database.default.add(model: model)
            } catch let error {
                print(error.localizedDescription)
            }
        }
    }
    
    func showTextFieldAlert(completion: @escaping () -> Void) {
        alertController = UIAlertController(title: "添加新类", message: nil, preferredStyle: .alert)
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
                newKindName = targetText
            }
        }
    }
}
