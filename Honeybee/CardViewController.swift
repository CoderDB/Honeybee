//
//  CardViewController.swift
//  Honeybee
//
//  Created by Dongbing Hou on 30/11/2016.
//  Copyright © 2016 Dongbing Hou. All rights reserved.
//

import UIKit

class CardViewController: BaseViewController {

    
    ///
    var dataToWrite: [String: Any] = [:]
    
    lazy var hb_keyboard: HBKeyboard = {
        let keyboard = HBKeyboard()
        keyboard.calculateView.delegate = self
        keyboard.dateView.delegate = self
        keyboard.delegate = self
        return keyboard
    }()
    var collectionView: UICollectionView!
    var header: CardHeader!
    var dataSource = [Array(1...20), Array(1...20), Array(5...20), Array(5...20)]
    var headerTitles = ["生活日常", "每天吃饭", "住", "车"]
    var lastOffsetY: CGFloat = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNav(title: "记账")
        addLeftNavItem()
        addResultView()
        addCollectionView()
        addKeyboard()
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
        header.editButtonAction = {[unowned self] in
            self.navigationController?.pushViewController(IconManagerViewController(), animated: true)
        }
    }
    func addCollectionView() {
        let layout = UICollectionViewFlowLayout()
        layout.minimumLineSpacing = 10
        layout.minimumInteritemSpacing = 10
        layout.itemSize = CGSize(width: 45, height: 45)
        layout.sectionHeadersPinToVisibleBounds = true
        layout.headerReferenceSize = CGSize(width: view.frame.width, height: 50)
        collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.backgroundColor = UIColor.white
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.contentInset = UIEdgeInsets(top: 0, left: 15, bottom: 50, right: 15)
        collectionView.register(CardCollectionCell.self, forCellWithReuseIdentifier: "\(CardCollectionCell.self)")
        collectionView.register(IconManagerSectionHeader.self, forSupplementaryViewOfKind: UICollectionElementKindSectionHeader, withReuseIdentifier: "\(IconManagerSectionHeader.self)")
        view.addSubview(collectionView)
        collectionView.snp.makeConstraints { (make) in
            make.top.equalTo(view).offset(64+115)
            make.left.right.bottom.equalTo(view)
        }
    }
    func addKeyboard() {
        view.addSubview(hb_keyboard)
        hb_keyboard.snp.makeConstraints { (make) in
            make.left.right.equalTo(view)
            make.bottom.equalTo(view).offset(10)
            make.height.equalTo(280)
        }
    }
}


// MARK: UICollectionViewDataSource
extension CardViewController: UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return dataSource.count
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return dataSource[section].count
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "\(CardCollectionCell.self)", for: indexPath)
        cell.backgroundColor = UIColor.randomColor()
        return cell
    }
}


// MARK: UICollectionViewDelegateFlowLayout
extension CardViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "\(IconManagerSectionHeader.self)", for: indexPath) as! IconManagerSectionHeader
        header.titleLabel.text = headerTitles[indexPath.section]
        return header
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        header.containView.backgroundColor = UIColor.randomColor()
        header.categoryLabel.text = "电影票"
    }
}


// MARK: UIScrollViewDelegate
extension CardViewController: UIScrollViewDelegate {
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
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        lastOffsetY = scrollView.contentOffset.y
    }
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        if scrollView.contentOffset.y > lastOffsetY {
            UIView.animate(withDuration: 0.3, animations: {
                self.navigationController!.navigationBar.transform = CGAffineTransform(translationX: 0, y: -44)
                self.header.frame.origin.y = 20
                self.collectionView.frame.origin.y = 20 + 115
                self.setupNav(title: "")
            })
        } else {
            UIView.animate(withDuration: 0.3, animations: {
                self.navigationController!.navigationBar.transform = CGAffineTransform.identity
                self.header.frame.origin.y = 64
                self.collectionView.frame.origin.y = 64 + 115
                self.setupNav(title: "记账")
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
        
        header.numberLabel.text?.removeAll()
        
    }
    // Date
    func selected(date: String) {
        dataToWrite["date"] = date
    }
    func callCamera() {
        print("---call camera")
    }
}
