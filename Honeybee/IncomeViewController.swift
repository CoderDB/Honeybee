//
//  IncomeViewController.swift
//  Honeybee
//
//  Created by Dongbing Hou on 21/04/2017.
//  Copyright © 2017 Dongbing Hou. All rights reserved.
//

import UIKit

class IncomeViewController: BaseViewController {
    
    var collectionView: UICollectionView!
    

    lazy var salaryBtn: UIButton = {
        let btn = UIButton()
        btn.titleLabel?.font = HB.Font.h3
        btn.layer.cornerRadius = HB.Constant.cornerRadius * 0.5
        btn.backgroundColor = .green
        btn.setTitle("工资", for: .normal)
        return btn
    }()
    lazy var partTimeBtn: UIButton = {
        let btn = UIButton()
        btn.titleLabel?.font = HB.Font.h3
        btn.layer.cornerRadius = HB.Constant.cornerRadius * 0.5
        btn.backgroundColor = .orange
        btn.setTitle("兼职", for: .normal)
        return btn
    }()
    lazy var otherBtn: UIButton = {
        let btn = UIButton()
        btn.titleLabel?.font = HB.Font.h3
        btn.layer.cornerRadius = HB.Constant.cornerRadius * 0.5
        btn.backgroundColor = .gray
        btn.setTitle("其他", for: .normal)
        return btn
    }()
    lazy var addBtn: UIButton = {
        let btn = UIButton()
        btn.titleLabel?.font = HB.Font.h3
        btn.layer.cornerRadius = HB.Constant.cornerRadius * 0.5
        btn.backgroundColor = .green
        btn.setTitle("+", for: .normal)
        return btn
    }()
    override func viewDidLoad() {
        super.viewDidLoad()
//        automaticallyAdjustsScrollViewInsets = false
//        let stackTop = UIStackView(arrangedSubviews: [salaryBtn, partTimeBtn])
//        stackTop.alignment = .center
//        stackTop.distribution = .fillEqually
//        stackTop.axis = .horizontal
//        
//        let stackBottom = UIStackView(arrangedSubviews: [otherBtn, addBtn])
//        stackBottom.alignment = .center
//        stackBottom.distribution = .fillEqually
//        stackBottom.axis = .horizontal
//        
//        let stackContainer = UIStackView(arrangedSubviews: [stackTop, stackBottom])
//        stackContainer.alignment = .center
//        stackContainer.distribution = .fillEqually
//        stackContainer.axis = .vertical
        
//        view.addSubview(stackContainer)
//        stackContainer.snp.makeConstraints { (make) in
//            make.top.equalTo(view).offset(62+20)
//            make.left.right.equalTo(view)
//            make.height.equalTo(200)
//        }
        
        setupUI()
    }
    
    func setupUI() {
        
        let layout = UICollectionViewFlowLayout()
        
        collectionView = UICollectionView(frame: view.bounds, collectionViewLayout: layout)
        collectionView.register(IncomeCell.self)
        
        view.addSubview(collectionView)
        
        
//        view.addSubview(salaryBtn)
//        view.addSubview(partTimeBtn)
//        view.addSubview(otherBtn)
//        view.addSubview(addBtn)
//        salaryBtn.addTarget(self, action: #selector(salaryBtnClicked), for: .touchUpInside)
//        partTimeBtn.addTarget(self, action: #selector(partTimeBtnClicked), for: .touchUpInside)
//        otherBtn.addTarget(self, action: #selector(otherBtnClicked), for: .touchUpInside)
//        addBtn.addTarget(self, action: #selector(addBtnClicked), for: .touchUpInside)
//        
//        salaryBtn.snp.makeConstraints { (make) in
//            make.top.equalTo(view).offset(64+20)
//            make.right.equalTo(view.snp.centerX).offset(-20)
//            make.width.equalTo(100)
//            make.height.equalTo(50)
//        }
//        partTimeBtn.snp.makeConstraints { (make) in
//            make.left.equalTo(view.snp.centerX).offset(20)
//            make.top.height.width.equalTo(salaryBtn)
//        }
//        otherBtn.snp.makeConstraints { (make) in
//            make.top.equalTo(salaryBtn.snp.bottom).offset(10)
//            make.left.height.width.equalTo(salaryBtn)
//        }
//        addBtn.snp.makeConstraints { (make) in
//            make.left.height.width.equalTo(partTimeBtn)
//            make.top.equalTo(otherBtn)
//        }
    }
    func salaryBtnClicked() {
        
    }
    func partTimeBtnClicked() {
        
    }
    func otherBtnClicked() {
        
    }
    func addBtnClicked() {
        
    }

    func createBtn(title: String) -> UIButton {
        let btn = UIButton()
        btn.setTitle(title, for: .normal)
        return btn
    }
}
