//
//  BaseCollectionViewController.swift
//  Honeybee
//
//  Created by Dongbing Hou on 06/03/2017.
//  Copyright © 2017 Dongbing Hou. All rights reserved.
//

import UIKit

class BaseCollectionViewController: BaseViewController {

    lazy var layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
    lazy var collectionView: UICollectionView = {
        let view = UICollectionView(frame: .zero, collectionViewLayout: self.layout)
        view.backgroundColor = UIColor.white
        view.showsVerticalScrollIndicator = false
        view.showsHorizontalScrollIndicator = false
        view.dataSource = self
        view.delegate = self
        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(collectionView)
    }
}
extension BaseCollectionViewController: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 0
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        return UICollectionViewCell()
    }
}
