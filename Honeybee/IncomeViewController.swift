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
    var dataSource: IncomeDataSource!
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        fetchData()
    }
    
    func setupUI() {
        
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: 80, height: 40)
        collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.backgroundColor = .white
        collectionView.register(IncomeCell.self)
        
        view.addSubview(collectionView)
        collectionView.snp.makeConstraints { (make) in
            make.top.equalTo(view).offset(64)
            make.left.right.bottom.equalTo(view)
        }
    }
    
    func fetchData() {
        let incomes = Honeybee.default.all(HoneybeeIncome.self)
        dataSource = IncomeDataSource(items: incomes.toArray)
        collectionView.dataSource = dataSource
    }
}
