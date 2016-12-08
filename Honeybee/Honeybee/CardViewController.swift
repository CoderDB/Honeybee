//
//  CardViewController.swift
//  Honeybee
//
//  Created by Dongbing Hou on 30/11/2016.
//  Copyright © 2016 Dongbing Hou. All rights reserved.
//

import UIKit

class CardViewController: UIViewController {

    var cardView: UIView!
    
    let AnimateDuration: TimeInterval = 0.3
    
    var hb_keyboard: HBKeyboard!
    
    override func loadView() {
        super.loadView()
        
        /*
         let mask = UIBezierPath(roundedRect: cardView.bounds, byRoundingCorners: [.topLeft, .topRight], cornerRadii: CGSize(width: 10, height: 10))
         let shapeLayer = CAShapeLayer()
         shapeLayer.bounds = cardView.bounds
         shapeLayer.path = mask.cgPath
         cardView.layer.mask = shapeLayer
         */
        cardView = UIView()
        cardView.backgroundColor = UIColor.gray
        cardView.layer.cornerRadius = 8.0
        
        modalPresentationStyle = .overFullScreen
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.white
        
//        let tap = UITapGestureRecognizer(target: self, action: #selector(swipeDownGestureAction))
//        view.addGestureRecognizer(tap)
        
        let swipe = UISwipeGestureRecognizer(target: self, action: #selector(swipeDownGestureAction))
        swipe.direction = .down
        cardView.addGestureRecognizer(swipe)
        
        addHBKeyboardView()
        
        addResultLabel()
    }
    func swipeDownGestureAction() {
        removeCardView()
    }
    
    
    func addHBKeyboardView() {
        hb_keyboard = HBKeyboard()
        hb_keyboard.delegate = self
    }
    
    
    
    func addResultLabel() {
        let label = UILabel(frame: CGRect(x: 100, y: 100, width: 300, height: 30))
        label.backgroundColor = UIColor.orange
        label.tag = 1000
        cardView.addSubview(label)
    }
    
    
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        cardView.addSubview(hb_keyboard)
        view.addSubview(cardView)
        
        hb_keyboard.translatesAutoresizingMaskIntoConstraints = false
        cardView.translatesAutoresizingMaskIntoConstraints = false
        
        hb_keyboard.leftAnchor.constraint(equalTo: cardView.leftAnchor).isActive = true
        hb_keyboard.bottomAnchor.constraint(equalTo: cardView.bottomAnchor).isActive = true
        hb_keyboard.widthAnchor.constraint(equalTo: cardView.widthAnchor).isActive = true
        hb_keyboard.heightAnchor.constraint(equalToConstant: 280).isActive = true
        
        
        cardView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        cardView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 10).isActive = true
        cardView.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 1.0).isActive = true
        cardView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.9).isActive = true
        
        
        cardView.transform = CGAffineTransform(translationX: 0, y: ScreenH/2)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        
        if cardView != nil {
            addCardView()
        }
    }
    
    func addCardView() {
        UIView.animate(withDuration: AnimateDuration, delay: 0, usingSpringWithDamping: 0.8, initialSpringVelocity: 1, options: UIViewAnimationOptions(rawValue: 0), animations: {
            self.cardView.transform = CGAffineTransform.identity
        }, completion: nil)
    }
    func removeCardView() {
        UIView.animate(withDuration: AnimateDuration, delay: 0, options: .curveLinear, animations: {
            self.cardView.transform = CGAffineTransform(translationX: 0, y: ScreenH/2)
        }) { (_) in
            self.cardView.removeFromSuperview()
            self.cardView.transform = CGAffineTransform.identity
            self.dismiss(animated: false, completion: nil)
        }
    }
    
}


extension CardViewController: HBKeyboardProtocol {
    
    func callCamera() {
        print("---call camera")
    }
}
