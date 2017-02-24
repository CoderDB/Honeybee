//
//  IconManagerLayout.swift
//  Honeybee
//
//  Created by Dongbing Hou on 24/02/2017.
//  Copyright © 2017 Dongbing Hou. All rights reserved.
//

import UIKit

class IconManagerLayout: UICollectionViewFlowLayout {
    
    
//    override func layoutAttributesForSupplementaryView(ofKind elementKind: String, at indexPath: IndexPath) -> UICollectionViewLayoutAttributes? {
//        let attrs = super.layoutAttributesForSupplementaryView(ofKind: elementKind, at: indexPath)!
//        if elementKind == UICollectionElementKindSectionHeader {
//            var nextHeaderOrigin: CGPoint = .zero
//            if indexPath.section + 1 < collectionView!.numberOfSections {
//                let nextHeaderAttr = super.layoutAttributesForSupplementaryView(ofKind: elementKind, at: IndexPath(item: 0, section: indexPath.section + 1))
//                nextHeaderOrigin = nextHeaderAttr!.frame.origin
//            }
//            var newFrame = attrs.frame
//            newFrame.origin.y = min(max(collectionView!.contentOffset.y, newFrame.origin.y), nextHeaderOrigin.y - newFrame.height)
//            attrs.zIndex = 10
//            attrs.frame = newFrame
//            
//        }
//        return attrs
//    }
    
    override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        var attrs = super.layoutAttributesForElements(in: rect)!
        
        var noHeaderSections = IndexSet()
        
        for attr in attrs {
            if attr.representedElementCategory == .cell {
                noHeaderSections.insert(attr.indexPath.section)
            }
            if attr.representedElementKind == UICollectionElementKindSectionHeader {
                noHeaderSections.remove(attr.indexPath.section)
            }
        }
        if noHeaderSections.count > 0 {
            for (idx, _) in noHeaderSections.enumerated() {
                let idx0 = IndexPath(item: 0, section: idx)
                if let attr = layoutAttributesForSupplementaryView(ofKind: UICollectionElementKindSectionHeader, at: idx0) {
                    attrs.append(attr)
                }
            }
        }
        
        for attr in attrs {
            if attr.representedElementKind == UICollectionElementKindSectionHeader {
                let numberOfItemsInSection = collectionView!.numberOfItems(inSection: attr.indexPath.section)
                let firstIdx = IndexPath(item: 0, section: attr.indexPath.section)
                let lastIdx = IndexPath(item: max(0, numberOfItemsInSection-1), section: attr.indexPath.section)
                
                var firstItemAttr, lastItemAttr: UICollectionViewLayoutAttributes
                
                if numberOfItemsInSection > 0 {
                    firstItemAttr = layoutAttributesForItem(at: firstIdx)!
                    lastItemAttr = layoutAttributesForItem(at: lastIdx)!
                } else {
                    firstItemAttr = UICollectionViewLayoutAttributes()
                    let y = attr.frame.maxY + sectionInset.top
                    firstItemAttr.frame = CGRect(x: 0, y: y, width: 0, height: 0)
                    lastItemAttr = firstItemAttr
                }
                
                var headerFrame = attr.frame
                let offset = collectionView!.contentOffset.y
                let headerY = firstItemAttr.frame.origin.y - headerFrame.height
                let maxY = max(offset, headerY)
                let headerMissingY = lastItemAttr.frame.maxY + sectionInset.bottom - headerFrame.height
                headerFrame.origin.y = min(maxY, headerMissingY)
                
                attr.frame = headerFrame
                attr.zIndex = 7
            }
        }
        return attrs
    }
    
    override func shouldInvalidateLayout(forBoundsChange newBounds: CGRect) -> Bool {
        return true
    }
    
//    override func initialLayoutAttributesForAppearingSupplementaryElement(ofKind elementKind: String, at elementIndexPath: IndexPath) -> UICollectionViewLayoutAttributes? {
//        return super.initialLayoutAttributesForAppearingSupplementaryElement(ofKind: elementKind, at: elementIndexPath)
//    }
//    override func finalLayoutAttributesForDisappearingSupplementaryElement(ofKind elementKind: String, at elementIndexPath: IndexPath) -> UICollectionViewLayoutAttributes? {
//        return super.finalLayoutAttributesForDisappearingSupplementaryElement(ofKind: elementKind, at: elementIndexPath)
//    }
}
