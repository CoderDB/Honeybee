//
//  CardViewController.swift
//  Honeybee
//
//  Created by Dongbing Hou on 30/11/2016.
//  Copyright © 2016 Dongbing Hou. All rights reserved.
//

import UIKit
import RealmSwift

class CardViewController: BaseCollectionViewController {

    var shouldReloadData: (() -> Void)?
    var notiToken: NotificationToken? = nil
    
    ///
//    var dataToWrite: [String: Any] = [:]
    ///
    var recorderToWrite: RLMRecorder!
    
    lazy var hb_keyboard: HBKeyboard = {
        let keyboard = HBKeyboard()
        keyboard.calculateView.delegate = self
        keyboard.dateView.delegate = self
        keyboard.delegate = self
        return keyboard
    }()
    var header: CardHeader!
    var dataSource: CardDataSource!
    
    var lastOffsetY: CGFloat = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        automaticallyAdjustsScrollViewInsets = false
        setNavTitle("记账")
        addLeftNavItem()
        addHeader()
        addCollectionView()
        addKeyboard()
        fetchData()
    }
    func fetchData() {
        let kinds = HoneybeeManager.manager.allKinds()
        
        dataSource = CardDataSource(items: kinds)
        collectionView.dataSource = dataSource
        
//        notiToken = dataSource.items._addNotificationBlock { (change) in
//            
//            
//            self.collectionView.reloadData()
//        }
        
        notiToken = DatabaseManager.manager.notification { [unowned self] (_, realm) in
            self.dataSource = CardDataSource(items: realm.objects(HoneybeeKind.self))
            self.collectionView.dataSource = self.dataSource
        }
//            .addNotificationBlock({ [weak self] (changes) in
//            switch changes {
//            case .initial:
//                self?.collectionView.reloadData()
//            case .update(_, let deletions, let insertions, let modifications):
//                
//                self?.collectionView.deleteItems(at: deletions.map { IndexPath(item: $0, section: 0) })
//                self?.collectionView.insertItems(at: insertions.map { IndexPath(item: $0, section: 0) })
//                self?.collectionView.reloadItems(at: modifications.map { IndexPath(item: $0, section: 0) })
//            
//            case .error(let err):
//                print(err.localizedDescription)
//            }
//        })
    }
    deinit {
        notiToken?.stop()
        print("-----CardViewController--deinit--")
    }
}


// MARK: UI / Event

extension CardViewController {
    func addLeftNavItem() {
        let btn = UIButton(frame: CGRect(x: 0, y: 0, width: 15, height: 25))
        btn.setImage(UIImage(named: "left_arrow"), for: .normal)
        btn.addTarget(self, action: #selector(navLeftItemAction), for: .touchUpInside)
        navigationItem.leftBarButtonItem = UIBarButtonItem(customView: btn)
    }
    func navLeftItemAction() {
        dismiss(animated: true) { [weak self] in
            self?.shouldReloadData?()
        }
    }
    func addHeader() {
        header = CardHeader(frame: CGRect(x: 0, y: 64, width: view.frame.width, height: 115))
        view.addSubview(header)
        header.rightButtonAction = {[unowned self] _ in
            self.navigationController?.pushViewController(KindViewController(), animated: true)
        }
    }
    func addCollectionView() {
        layout.itemSize = CGSize(width: 60, height: 70)
        layout.sectionHeadersPinToVisibleBounds = true
        layout.headerReferenceSize = CGSize(width: view.frame.width, height: 50)
        collectionView.contentInset = UIEdgeInsets(top: 0, left: 15, bottom: 50, right: 15)
        collectionView.register(CardCollectionCell.self)
        collectionView.register(CardSectionHeader.self)
        collectionView.snp.updateConstraints { (make) in
            make.top.equalTo(view).offset(64+115)
        }
    }
    func addKeyboard() {
        view.addSubview(hb_keyboard)
        hb_keyboard.snp.makeConstraints { (make) in
            make.left.right.equalTo(view)
            make.bottom.equalTo(view).offset(10)
            make.height.equalTo(250)
        }
    }
}


// MARK: UICollectionViewDelegateFlowLayout

extension CardViewController {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let kind = dataSource.item(at: indexPath)
        header.containerView.backgroundColor = UIColor(hex: kind.color)
        let item = kind.items[indexPath.row]
        
        header.categoryLabel.text = item.name
        header.imgView.image = UIImage(named: item.icon)
        
        recorderToWrite = RLMRecorder()
        recorderToWrite.category = item.name
        recorderToWrite.superCategory = kind.name
        recorderToWrite.imageName = item.icon
        recorderToWrite.color = kind.color
        
//        dataToWrite["category"] = item.name
//        dataToWrite["superCategory"] = kind.name
//        dataToWrite["imageName"] = item.icon
//        dataToWrite["color"] = kind.color
    }
}


// MARK: UIScrollViewDelegate

extension CardViewController {
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        lastOffsetY = scrollView.contentOffset.y
    }
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if scrollView.contentOffset.y > lastOffsetY {
            self.hb_keyboard.down()
        } else {
            self.hb_keyboard.up()
        }
    }
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        if scrollView.contentOffset.y > lastOffsetY {
            navigationController?.setNavigationBarHidden(true, animated: true)
            UIView.animate(withDuration: 0.3, animations: {
                self.header.frame.origin.y = 20
                self.collectionView.frame.origin.y = 20 + 115
            })
        } else {
            navigationController?.setNavigationBarHidden(false, animated: true)
            UIView.animate(withDuration: 0.3, animations: {
                self.header.frame.origin.y = 64
                self.collectionView.frame.origin.y = 64 + 115
            })
        }
    }
}


// MARK: HBKeyboardProtocol
import ObjectMapper
extension CardViewController: HBKeyboardProtocol, AlertProvider {
    // result
    func inputing(text: String) {
        header.numberLabel.text = text
    }
    func deleted(text: String) {
        header.numberLabel.text = text
    }
    func writeToDataBase() {
        let isExisted = DatabaseManager.manager.all(RLMRecorderSuper.self).filter("name == %@", recorderToWrite.superCategory)
        if isExisted.count > 0 {
            if let superModel = isExisted.first {
                do {
                    try superModel.realm?.write {
                        superModel.recorders.append(recorderToWrite)
                    }
                    Reminder.success()
                } catch {
                    Reminder.error()
                }
            }
        } else {
            if let superModel = Mapper<RLMRecorderSuper>()
                .map(JSON: [
                    "style": "plain",
                    "name": recorderToWrite.superCategory,
                    "color": recorderToWrite.color,
                    "totalPay": recorderToWrite.money,
                    "recorders": [recorderToWrite.toJSON()]
                    ]
                ) {
                do {
                    try DatabaseManager.manager.add(model: superModel)
                    Reminder.success()
                } catch {
                    Reminder.error()
                }
            }
        }
    }
    func completed(text: String) {
        header.numberLabel.text = text
        
        recorderToWrite.money = Int(text) ?? 0
        recorderToWrite.isPay = true
    
        writeToDataBase()
        
        recorderToWrite = nil
        header.numberLabel.text = "0"
    }
    
    // Date
    func selected(date: String) {
        recorderToWrite.date = date
//        dataToWrite["date"] = date
    }
    func callCamera() {
        print("---call camera")
    }
    func remarkBtnAction() {
        hb_keyboard.down()
        
        showTextField(title: "备注", textField: { (tf) in
            self.recorderToWrite.remark = tf.text ?? "\n\n"
//            self.dataToWrite["remark"] = tf.text ?? "\n\n"
            
        }, ok: { [unowned self] in
            self.hb_keyboard.up()
            
        }, cancel: { [unowned self] in
            self.hb_keyboard.up()
        })
    }
}
