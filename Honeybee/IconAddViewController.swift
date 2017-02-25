//
//  IconAddViewController.swift
//  Honeybee
//
//  Created by Dongbing Hou on 25/02/2017.
//  Copyright © 2017 Dongbing Hou. All rights reserved.
//

import UIKit

class IconAddViewController: BaseViewController {

    
    var animator: UIDynamicAnimator!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        var btns = [UIButton]()
        
        animator = UIDynamicAnimator(referenceView: view)
        
//        
//        let btn = UIButton(frame: CGRect(x: 100, y: 100, width: 100, height: 100))
//        btn.backgroundColor = UIColor.randomColor()
//        view.addSubview(btn)
//        btns.append(btn)
//        
//        
//        let pushBe = UIPushBehavior(items: [btn], mode: .instantaneous)
//        pushBe.addItem(btn)
//        pushBe.angle = 10
//        pushBe.magnitude = 0.1
//        pushBe.active = true
//        animator.addBehavior(pushBe)

        for i in 0..<5 {
            let btn = UIButton(frame: CGRect(x: 100, y: 100, width: 100, height: 100))
            btn.backgroundColor = UIColor.randomColor()
            view.addSubview(btn)
            btns.append(btn)
            
            
            let pushBe = UIPushBehavior(items: [btn], mode: .instantaneous)
            pushBe.addItem(btn)
            pushBe.angle = CGFloat(i) * 15
            pushBe.magnitude = 10
            pushBe.active = true
            animator.addBehavior(pushBe)
        }
        
        let itemBe = UIDynamicItemBehavior(items: btns)
        itemBe.elasticity = 1
        itemBe.friction = 0
        itemBe.density = 0.1
        itemBe.resistance = 0
        itemBe.allowsRotation = true
        animator.addBehavior(itemBe)
        
        let collisionBe = UICollisionBehavior(items: btns)
        collisionBe.collisionMode = .everything
        collisionBe.translatesReferenceBoundsIntoBoundary = true
        animator.addBehavior(collisionBe)
        
        
    }

}
