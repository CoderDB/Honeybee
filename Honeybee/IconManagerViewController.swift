//
//  IconManagerViewController.swift
//  Honeybee
//
//  Created by Dongbing Hou on 24/02/2017.
//  Copyright © 2017 Dongbing Hou. All rights reserved.
//

import UIKit

class IconManagerViewController: BaseViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        setupNav(title: "图标管理")
        addCollectionView()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(false, animated: true)
    }
    func addCollectionView() {
        let layout = UICollectionViewFlowLayout()
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.backgroundColor = UIColor.white
        view.addSubview(collectionView)
        collectionView.snp.makeConstraints { (make) in
            make.top.equalTo(64)
            make.left.right.bottom.equalTo(view)
        }
        
        collectionView.dataSource = self
        collectionView.register(CollectionViewCell.self, forCellWithReuseIdentifier: "cell")
    }
}


extension IconManagerViewController: UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 10
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 10
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath)
        cell.backgroundColor = UIColor.randomColor()
        return cell        
    }
}
