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
        collectionView.contentInset = UIEdgeInsets(top: 0, left: 15, bottom: 50, right: 15)
        collectionView.register(IncomeCell.self)
        collectionView.delegate = self
        
        view.addSubview(collectionView)
        collectionView.snp.makeConstraints { (make) in
            make.top.equalTo(view).offset(64)
            make.left.right.bottom.equalTo(view)
        }
    }
    
    func fetchData() {
        
        var incomes = Honeybee.default.all(HoneybeeIncome.self).toArray
        let last = HoneybeeIncome()
        last.color = "RRR"
        last.name = "+"
        incomes.append(last)
        
        dataSource = IncomeDataSource(items: incomes)
        collectionView.dataSource = dataSource
    }
}


extension IncomeViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        if indexPath.row == dataSource.items.count - 1 {
            print("最后")
        } else {
            
        }
    }
}
