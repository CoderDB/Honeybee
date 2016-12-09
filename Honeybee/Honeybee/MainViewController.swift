//
//  MainViewController.swift
//  Honeybee
//
//  Created by Dongbing Hou on 30/11/2016.
//  Copyright © 2016 Dongbing Hou. All rights reserved.
//

import UIKit

let ScreenW = UIScreen.main.bounds.width
let ScreenH = UIScreen.main.bounds.height


class MainViewController: UIViewController {

    lazy var cardVC: CardViewController = CardViewController()
    lazy var customPresentationController: HBPresentationController = HBPresentationController(presentedViewController: self.cardVC, presenting: self)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.white
        
        addNavLeftItem()
        addNavRightItem()
        
        addAddBtn()
        
        cardVC.transitioningDelegate = customPresentationController
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}


// MARK: UI

extension MainViewController {
    
    func addNavLeftItem() {
        let nicknameBtn = UIButton(frame: CGRect(x: 0, y: 0, width: 100, height: 30))
        nicknameBtn.backgroundColor = UIColor.red
        nicknameBtn.setTitle("honeybee", for: .normal)
        nicknameBtn.addTarget(self, action: #selector(leftItemAction), for: .touchUpInside)
        navigationItem.leftBarButtonItem = UIBarButtonItem(customView: nicknameBtn)
    }
    func addNavRightItem() {
        let btn = UIButton(type: .contactAdd)
        btn.sizeToFit()
        navigationItem.rightBarButtonItem = UIBarButtonItem(customView: btn)
        btn.addTarget(self, action: #selector(rightItemAction), for: .touchUpInside)
    }
    func addAddBtn() {
        let addBtn = UIButton(type: .custom)
        addBtn.setImage(UIImage(named: "add"), for: .normal)
        addBtn.frame = CGRect(x: (ScreenW - 60) * 0.5, y: ScreenH - 80, width: 60, height: 60)
        addBtn.addTarget(self, action: #selector(addBtnClicked), for: .touchUpInside)
        view.addSubview(addBtn)
    }
}


// MARK: UI Event

extension MainViewController {
    
    func leftItemAction() {
        let nav = UINavigationController(rootViewController: SetupViewController())
        present(nav, animated: true, completion: nil)
    }
    func rightItemAction() {
        navigationController?.pushViewController(CurveViewController(), animated: true)
    }
    
    func addBtnClicked() {
        present(cardVC, animated: true, completion: nil)
    }
}
