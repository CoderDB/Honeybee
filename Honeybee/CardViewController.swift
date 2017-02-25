//
//  CardViewController.swift
//  Honeybee
//
//  Created by Dongbing Hou on 30/11/2016.
//  Copyright © 2016 Dongbing Hou. All rights reserved.
//

import UIKit

class CardViewController: UIViewController {

    lazy var hb_keyboard: HBKeyboard = {
        let keyboard = HBKeyboard()
        keyboard.calculateView.delegate = self
        keyboard.delegate = self
        return keyboard
    }()
    var collectionView: UICollectionView!
    var lastOffsetY: CGFloat = 0
    
    lazy var currentSelectedImgView = UIImageView()
    lazy var resultLabel: UILabel = {
        let label = UILabel()
        label.font = HonybeeFont.h2_number
        label.text = "0"
        label.textAlignment = .right
        return label
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.white
        updatePreferredContentSizeWithTraitCollection(traitCollection)

        addSwipeDownGesture()
        
        addResultView()
        addCollectionView()
        addKeyboard()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: true)
    }
    deinit {
        print("-----CardViewController--deinit--")
    }
}

//MARK: Transition
extension CardViewController {
    func updatePreferredContentSizeWithTraitCollection(_ traitCollection: UITraitCollection) {
        preferredContentSize = CGSize(width: ScreenW, height: ScreenH * 0.95)
    }
    override func willTransition(to newCollection: UITraitCollection, with coordinator: UIViewControllerTransitionCoordinator) {
        super.willTransition(to: newCollection, with: coordinator)
        updatePreferredContentSizeWithTraitCollection(newCollection)
    }
}


// MARK: UI / Event
extension CardViewController {
    func addResultView() {
        let containerView = UIView(frame: CGRect(x: 10, y: 10, width: view.frame.width-20, height: 50))
        containerView.layer.cornerRadius = HonybeeConstant.cornerRadius
        containerView.layer.borderWidth = 2
        containerView.layer.borderColor = UIColor.black.cgColor
        view.addSubview(containerView)
        containerView.addSubview(currentSelectedImgView)
        containerView.addSubview(resultLabel)
        currentSelectedImgView.snp.makeConstraints { (make) in
            make.left.equalTo(containerView).offset(10)
            make.centerY.equalTo(containerView)
            make.width.height.equalTo(40)
        }
        resultLabel.snp.makeConstraints { (make) in
            make.right.equalTo(containerView).offset(-10)
            make.centerY.equalTo(containerView)
            make.left.equalTo(currentSelectedImgView.snp.right).offset(10)
        }
    }
    func addCollectionView() {
        let layout = UICollectionViewFlowLayout()
        layout.minimumLineSpacing = 10
        layout.minimumInteritemSpacing = 10
        layout.itemSize = CGSize(width: 45, height: 45)
        layout.sectionInset = UIEdgeInsets(top: 0, left: 10, bottom: 50, right: 10)
        collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.backgroundColor = UIColor.white
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(CardCollectionCell.self, forCellWithReuseIdentifier: "\(CardCollectionCell.self)")
        view.addSubview(collectionView)
        collectionView.snp.makeConstraints { (make) in
            make.top.equalTo(view).offset(70)
            make.left.right.bottom.equalTo(view)
        }
    }
    
    func addKeyboard() {
        view.addSubview(hb_keyboard)
        hb_keyboard.snp.makeConstraints { (make) in
            make.left.right.bottom.equalTo(view)
            make.height.equalTo(260)
        }
    }
    
    func addSwipeDownGesture() {
        let swipe = UISwipeGestureRecognizer(target: self, action: #selector(swipeDownGestureAction))
        swipe.direction = .down
        view.addGestureRecognizer(swipe)
    }
    
    func swipeDownGestureAction() {
        dismiss(animated: true, completion: nil)
    }
}


// MARK: UICollectionViewDataSource
extension CardViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 200
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "\(CardCollectionCell.self)", for: indexPath)
        cell.backgroundColor = UIColor.randomColor()
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        currentSelectedImgView.backgroundColor = UIColor.randomColor()
        navigationController?.pushViewController(IconManagerViewController(), animated: true)
    }
}


// MARK: UICollectionViewDelegateFlowLayout
extension CardViewController: UICollectionViewDelegateFlowLayout {
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
}

// MARK: HBKeyboardProtocol
extension CardViewController: HBKeyboardProtocol {
    func callCamera() {
        print("---call camera")
    }
}

// MARK: HBKeyboardProtocol
extension CardViewController: CalculateViewProtocol {
    func inputing(text: String) {
        resultLabel.text = text
    }
    
    func deleted(text: String) {
        resultLabel.text = text
    }
    
    func completed(text: String) {
        resultLabel.text = text
    }
}
