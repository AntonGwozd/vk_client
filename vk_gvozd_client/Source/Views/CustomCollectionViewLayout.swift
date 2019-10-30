//
//  CustomCollectionViewLayout.swift
//  vk_gvozd_client
//
//  Created by Anton Gvozdanov on 08/10/2019.
//  Copyright © 2019 Anton Gvozdanov. All rights reserved.
//

import UIKit

class CustomCollectionViewLayout:  UICollectionViewLayout {
    
    var cacheAttribute = [IndexPath : UICollectionViewLayoutAttributes]()
    
    @IBInspectable let columnCount = 2
    
    @IBInspectable var cellHeight: CGFloat = 150
    
    private var totalCellsHeight: CGFloat = 0
    
    override func prepare() {
        
        self.cacheAttribute = [:]
        guard let collectionView = self.collectionView else {return}
        let itemCount =  collectionView.numberOfItems(inSection: 0)
        guard itemCount > 0 else {return}
        
        let bigCellWidth = collectionView.frame.width
        let smallCellWidth = collectionView.frame.width / CGFloat(columnCount)
        
        var lastX: CGFloat = 0.0
        var lastY: CGFloat = 0.0
        
        for index in 0..<itemCount {
            let indexPatch = IndexPath(item: index, section: 0)
            let attributes = UICollectionViewLayoutAttributes(forCellWith: indexPatch)
            
            let isBigSel = ((index + 1) % (columnCount + 1)) == 0
            
            if isBigSel {
                attributes.frame = CGRect(x: 0, y: lastY, width: bigCellWidth, height: cellHeight)
                lastY += cellHeight
            } else {
                attributes.frame = CGRect(x: lastX, y: lastY, width: smallCellWidth, height: cellHeight)
                
                let isLastColumn = (index + 2) % (columnCount + 1) == 0 || index == itemCount - 1
                if isLastColumn {
                    lastX = 0
                    lastY += cellHeight
                } else {
                    lastX += smallCellWidth
                }
            }
            cacheAttribute[indexPatch] = attributes
        }
        totalCellsHeight = lastY
    }
    
    override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        return cacheAttribute.values.filter({ attributes in
            rect.intersects(attributes.frame)
        })
    }
    
    override func layoutAttributesForItem(at indexPath: IndexPath) -> UICollectionViewLayoutAttributes? {
        return cacheAttribute[indexPath]
    }
     
    override var collectionViewContentSize: CGSize {
        return CGSize(width: collectionView?.frame.width ?? 0 , height: totalCellsHeight)
    }
}
