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
        keyboard.delegate = self
        return keyboard
    }()
    var collectionView: UICollectionView!
    
    
    var lastOffsetY: CGFloat = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.cyan
        
        let swipe = UISwipeGestureRecognizer(target: self, action: #selector(swipeDownGestureAction))
        swipe.direction = .down
        view.addGestureRecognizer(swipe)
        
        updatePreferredContentSizeWithTraitCollection(traitCollection)
        
        collectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
        collectionView.backgroundColor = UIColor.white
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(UINib(nibName: "CollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "Cell")
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        view.addSubview(collectionView)
        view.addSubview(hb_keyboard)
        
        collectionView.snp.makeConstraints { (make) in
            make.left.right.bottom.equalTo(view)
            make.top.equalTo(view).offset(100)
        }
        
        hb_keyboard.snp.makeConstraints { (make) in
            make.left.right.bottom.equalTo(view)
            make.height.equalTo(280)
        }
//        hb_keyboard.translatesAutoresizingMaskIntoConstraints = false
    }
}


// MARK: UI Event
extension CardViewController {
    func swipeDownGestureAction() {
        dismiss(animated: true, completion: nil)
    }
}


extension CardViewController {
    func updatePreferredContentSizeWithTraitCollection(_ traitCollection: UITraitCollection) {
        preferredContentSize = CGSize(width: ScreenW, height: ScreenH * 0.9)
    }
    override func willTransition(to newCollection: UITraitCollection, with coordinator: UIViewControllerTransitionCoordinator) {
        super.willTransition(to: newCollection, with: coordinator)
        updatePreferredContentSizeWithTraitCollection(newCollection)
    }
}

// MARK: UICollectionViewDataSource
extension CardViewController: UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 500
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath)
        cell.backgroundColor = UIColor.randomColor()
        return cell
    }
}

// MARK: UICollectionViewDelegate
extension CardViewController: UICollectionViewDelegate {

}

// MARK: UIScrollViewDelegate
extension CardViewController: UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if scrollView.contentOffset.y > lastOffsetY {
//            hb_keyboard.frame.origin.y = ScreenH * 0.9 - 60
            UIView.animate(withDuration: 0.3, animations: {
                self.hb_keyboard.transform = CGAffineTransform(translationX: 0, y: 220)
            })
        } else {
//            hb_keyboard.frame.origin.y = ScreenH * 0.9 - 280
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
