
//
//  CardViewController.swift
//  Honeybee
//
//  Created by Dongbing Hou on 30/11/2016.
//  Copyright © 2016 Dongbing Hou. All rights reserved.
//
import UIKit
import RealmSwift

class PayoutViewController: BaseCollectionViewController {
    
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
    var header: PayoutHeader!
    var dataSource: PayoutDataSource!
    
    var lastOffsetY: CGFloat = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        addHeader()
        addCollectionView()
        addKeyboard()
        fetchData()
    }
    func fetchData() {
        let kinds = Honeybee.default.allKinds()
        
        dataSource = PayoutDataSource(items: Array(kinds))
        collectionView.dataSource = dataSource
        
        //        notiToken = dataSource.items._addNotificationBlock { (change) in
        //
        //
        //            self.collectionView.reloadData()
        //        }
        
        notiToken = Database.default.notification { [unowned self] (_, realm) in
            self.dataSource = PayoutDataSource(items: Array(realm.objects(HoneybeeKind.self)))
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
extension PayoutViewController {
    func addHeader() {
        header = PayoutHeader(frame: CGRect(x: 0, y: 64, width: view.frame.width, height: 115))
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
        collectionView.register(PayoutCell.self)
        collectionView.register(PayoutSectionHeader.self)
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
extension PayoutViewController {
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
        
    }
}


// MARK: UIScrollViewDelegate
extension PayoutViewController {
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
extension PayoutViewController: HBKeyboardProtocol, AlertProvider {
    
    // result
    func inputing(text: String) {
        header.numberLabel.text = text
    }
    func deleted(text: String) {
        header.numberLabel.text = text
    }
    func writeToDataBase() {
        let isExisted = Database.default.all(RLMRecorderSuper.self).filter("name == %@", recorderToWrite.superCategory)
        
        if isExisted.count > 0 {
            if let superModel = isExisted.first {
                recorderToWrite.owner = superModel
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
            let superModel = RLMRecorderSuper()
            superModel.name = recorderToWrite.superCategory
            superModel.color = recorderToWrite.color
            recorderToWrite.owner = superModel
            
            do {
                try Database.default.add(model: superModel)
                do {
                    try Database.default.append(item: recorderToWrite, to: superModel.recorders)
                    Reminder.success()
                } catch {
                    Reminder.error()
                }
            } catch {
                Reminder.error()
            }
        }
    }
    func completed(text: Double) {
        guard recorderToWrite != nil else { return }
        header.numberLabel.text = "\(text)"
        
        recorderToWrite.money = text
        recorderToWrite.isPay = true
        
        writeToDataBase()
        
        recorderToWrite = nil
        //        recorderToWrite = RLMRecorder()
        header.numberLabel.text = "0"
    }
    
    // Date
    func selected(date: String) {
        recorderToWrite.date = date
    }
    func callCamera() {
        print("---call camera")
    }
    func remarkBtnAction() {
        hb_keyboard.down()
        
        showTextField(title: "备注", textField: { (tf) in
            self.recorderToWrite.remark = tf.text ?? "\n\n"
            
        }, ok: { [unowned self] in
            self.hb_keyboard.up()
            
            }, cancel: { [unowned self] in
                self.hb_keyboard.up()
        })
    }
}
