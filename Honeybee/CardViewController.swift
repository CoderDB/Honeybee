//
//  CardViewController.swift
//  Honeybee
//
//  Created by Dongbing Hou on 30/11/2016.
//  Copyright © 2016 Dongbing Hou. All rights reserved.
//

import UIKit

class CardViewController: BaseCollectionViewController {

    
    ///
    var dataToWrite: [String: Any] = [:]
    
    lazy var hb_keyboard: HBKeyboard = {
        let keyboard = HBKeyboard()
        keyboard.calculateView.delegate = self
        keyboard.dateView.delegate = self
        keyboard.delegate = self
        return keyboard
    }()
    var header: CardHeader!
    var dataSource: CardDataSource!
    
    var headerTitles = ["生活日常", "每天吃饭", "住", "车"]
    var lastOffsetY: CGFloat = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        automaticallyAdjustsScrollViewInsets = false
        setNavTitle("记账")
        addLeftNavItem()
        addResultView()
        addCollectionView()
        addKeyboard()
        fetchData()
    }
    func fetchData() {
        let kinds = HBKindManager.manager.allKinds()
        dataSource = CardDataSource(items: kinds)
        collectionView.dataSource = dataSource
    }
    deinit {
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
        dismiss(animated: true, completion: nil)
    }
    func addResultView() {
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
        
        header.containerView.backgroundColor = UIColor(hex: dataSource.item(at: indexPath).color.name)
        let item = dataSource.item(at: indexPath).items![indexPath.row]
        
        header.categoryLabel.text = item.name
        header.imgView.image = UIImage(named: item.icon)
    }
}


// MARK: UIScrollViewDelegate

extension CardViewController {
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        lastOffsetY = scrollView.contentOffset.y
    }
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if scrollView.contentOffset.y > lastOffsetY {
            UIView.animate(withDuration: 0.3, animations: {
                self.hb_keyboard.transform = CGAffineTransform(translationX: 0, y: 220)
            })
        } else {
            UIView.animate(withDuration: 0.3, animations: {
                self.hb_keyboard.transform = CGAffineTransform.identity
            })
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

extension CardViewController: HBKeyboardProtocol {
    // result
    func inputing(text: String) {
        header.numberLabel.text = text
    }
    
    func deleted(text: String) {
        header.numberLabel.text = text
    }
    
    func completed(text: String) {
        header.numberLabel.text = text
        
        dataToWrite["superCategory"] = "superCategory"
        dataToWrite["category"] = "category"
        dataToWrite["money"] = text
        dataToWrite["color"] = "768925"
        dataToWrite["remark"] = "remark"
        
        let model = RLMRecorderSuper(JSON: ["style": "plain", "recorders": [dataToWrite]])
        DatabaseManager.manager.add(model: model!)
        
        header.numberLabel.text = "0"
        
    }
    // Date
    func selected(date: String) {
        dataToWrite["date"] = date
    }
    func callCamera() {
        print("---call camera")
    }
}
