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
        containerView.layer.cornerRadius = 10
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
        collectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
        collectionView.backgroundColor = UIColor.white
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(UINib(nibName: "CollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "Cell")
        view.addSubview(collectionView)
        collectionView.snp.makeConstraints { (make) in
            make.left.equalTo(view).offset(10)
            make.right.equalTo(view).offset(-10)
            make.top.equalTo(view).offset(70)
            make.bottom.equalTo(view)
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
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath)
        cell.backgroundColor = UIColor.randomColor()
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        currentSelectedImgView.backgroundColor = UIColor.randomColor()
    }
}


// MARK: UICollectionViewDelegateFlowLayout
extension CardViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 10
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 0, bottom: 1000, right: 0)
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
