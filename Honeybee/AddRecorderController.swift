//
//  AddViewController.swift
//  Honeybee
//
//  Created by Dongbing Hou on 21/04/2017.
//  Copyright © 2017 Dongbing Hou. All rights reserved.
//

import UIKit

class AddRecorderController: BaseViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        automaticallyAdjustsScrollViewInsets = false
        navTitleView()
        addLeftNavItem()
        addVCs()
    }
    
    
    func navTitleView() {
        let segment = UISegmentedControl(items: ["支出", "收入"])
        segment.frame = CGRect(x: 0, y: 0, width: 250, height: 25)
        segment.selectedSegmentIndex = 0
        segment.addTarget(self, action: #selector(segmentChanged(_:)), for: .valueChanged)
        navigationItem.titleView = segment
    }
    func segmentChanged(_ seg: UISegmentedControl) {
        if seg.selectedSegmentIndex == 1 {
            replaceController(from: currentVC!, to: incomeVC)
        } else {
            replaceController(from: currentVC!, to: payoutVC)
        }
    }
    func replaceController(from: UIViewController, to: UIViewController) {
        addChildViewController(to)
        
        transition(from: from, to: to, duration: 0.5, options: .allowAnimatedContent, animations: {
//            from.view.transform = CGAffineTransform(translationX: HB.Screen.w, y: 1)
        }) { (isFinished) in
            if isFinished {
                from.view.transform = .identity
                to.didMove(toParentViewController: self)
                from.willMove(toParentViewController: nil)
                from.removeFromParentViewController()
                self.currentVC = to
                
            }
        }
    }
    
    func addLeftNavItem() {
        let btn = UIButton(frame: CGRect(x: 0, y: 0, width: 15, height: 25))
        btn.setImage(UIImage(named: "left_arrow"), for: .normal)
        btn.addTarget(self, action: #selector(navLeftItemAction), for: .touchUpInside)
        navigationItem.leftBarButtonItem = UIBarButtonItem(customView: btn)
    }
    func navLeftItemAction() {
        dismiss(animated: true, completion: nil)
        //        dismiss(animated: true) { [weak self] in
        //            self?.shouldReloadData?()
        //        }
    }
    
    
    var currentVC: UIViewController? = nil
    let payoutVC = PayoutViewController()
    let incomeVC = IncomeViewController()
    func addVCs() {
        addChildViewController(payoutVC)
        addChildViewController(incomeVC)
        
        view.addSubview(payoutVC.view)
        currentVC = payoutVC
    }
    
}
