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
}


// MARK: UI / Event
extension CardViewController {
    func addResultView() {
        let containerView = UIView(frame: CGRect(x: 10, y: 10, width: view.frame.width-20, height: 60))
        containerView.backgroundColor = UIColor.cyan
        view.addSubview(containerView)
        containerView.addSubview(currentSelectedImgView)
        containerView.addSubview(resultLabel)
        currentSelectedImgView.snp.makeConstraints { (make) in
            make.left.centerY.equalTo(containerView)
            make.width.height.equalTo(45)
        }
        resultLabel.snp.makeConstraints { (make) in
            make.right.centerY.equalTo(containerView)
            make.left.equalTo(currentSelectedImgView.snp.right)
        }
        
        
    }
    func addCollectionView() {
        collectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
        collectionView.backgroundColor = UIColor.white
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(UINib(nibName: "CollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "Cell")
        view.addSubview(collectionView)
        collectionView.snp.makeConstraints { (make) in
            make.left.right.bottom.equalTo(view)
            make.top.equalTo(view).offset(100)
        }
    }
    
    func addKeyboard() {
        view.addSubview(hb_keyboard)
        hb_keyboard.snp.makeConstraints { (make) in
            make.left.right.bottom.equalTo(view)
            make.height.equalTo(280)
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


extension CardViewController {
    func updatePreferredContentSizeWithTraitCollection(_ traitCollection: UITraitCollection) {
        preferredContentSize = CGSize(width: ScreenW, height: ScreenH * 0.95)
    }
    override func willTransition(to newCollection: UITraitCollection, with coordinator: UIViewControllerTransitionCoordinator) {
        super.willTransition(to: newCollection, with: coordinator)
        updatePreferredContentSizeWithTraitCollection(newCollection)
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
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath)
        cell.backgroundColor = UIColor.randomColor()
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        currentSelectedImgView.image = nil
        
        currentSelectedImgView.backgroundColor = UIColor.randomColor()
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
