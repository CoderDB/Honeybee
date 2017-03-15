//
//  KindDetailController.swift
//  Honeybee
//
//  Created by Dongbing Hou on 08/03/2017.
//  Copyright © 2017 Dongbing Hou. All rights reserved.
//

import UIKit

class KindDetailController: BaseCollectionViewController {
    
    var kind: HoneybeeKind!
    private var dataSource: KindDetailDataSource!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        automaticallyAdjustsScrollViewInsets = false
        setNavTitle("衣")
        addHeader()
        addTipView()
        addCollectionView()
        fetchData()
        
    }
    
    func fetchData() {
        dataSource = KindDetailDataSource(
        items:kind.items!)
        { (cell, model) in
            if let cell = cell as? KindDetailCell, let model = model as? HoneybeeItem {
                cell.configWith(model: model)
            }
        }
        collectionView.dataSource = dataSource
    }
}

extension KindDetailController: HoneybeeViewsProtocol {
    func addCollectionView() {
        layout.itemSize = CGSize(width: 65, height: 65)
        collectionView.contentInset = UIEdgeInsets(top: 10, left: 10, bottom: 50, right: 0)
        collectionView.snp.updateConstraints { (make) in
            make.top.equalTo(115+64)
            make.right.equalTo(view).offset(-60)
        }
        collectionView.register(KindDetailCell.self)
        let longGesture = UILongPressGestureRecognizer(target: self, action: #selector(longGestureAction(_:)))
        collectionView.addGestureRecognizer(longGesture)
        
    }
    func longGestureAction(_ gesture: UILongPressGestureRecognizer) {
        switch gesture.state {
        case .began:
            guard let selectedIdx = collectionView.indexPathForItem(at: gesture.location(in: collectionView)) else {
                break
            }
            let cell = collectionView.cellForItem(at: selectedIdx) as! KindDetailCell
            cell.deleteBtn.isHidden = false
            
            //            let cells = allCells(KindDetailCell.self)
            //            for cell in cells {
            //                cell.deleteBtn.isHidden = false
            //            }
            
            
            //            dataSource.remove(at: selectedIdx.item)
            //            collectionView.deleteItems(at: [selectedIdx])
            //        case .changed:
        //            collectionView.updateInteractiveMovementTargetPosition(gesture.location(in: gesture.view))
        case .ended:
            collectionView.endInteractiveMovement()
        default:
            collectionView.cancelInteractiveMovement()
        }
    }
    func addHeader() {
        let header = KindDetailHeader(frame: CGRect(x: 0, y: 64, width: HB.Screen.w, height: 115))
        header.titleLabel.text = kind.name
        view.addSubview(header)
        let vc = KindAddItemController()
        vc.kind = kind
        header.addNewItemAction = { [unowned self] in
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
    func addTipView() {
        let frame = CGRect(x: HB.Screen.w - 50, y: 200, width: 50, height: 130)
        tipLabel(text: "长 按 可 删 除", frame: frame)
    }
}

// MARK: UICollectionViewDelegateFlowLayout
extension KindDetailController {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print("-------\(indexPath.section)----\(indexPath.row)")
    }
}
