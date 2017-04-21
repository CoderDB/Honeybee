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
        
        navTitleView()
        addVCs()
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
    
    func navTitleView() {
        let segment = UISegmentedControl(items: ["支出", "收入"])
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
        transition(from: from, to: to, duration: 1, options: .curveLinear, animations: nil) { (isFinished) in
            if isFinished {
                to.didMove(toParentViewController: self)
                from.willMove(toParentViewController: nil)
                from.removeFromParentViewController()
                self.currentVC = to
            }
        }
    }
}
