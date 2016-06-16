//
//  WaterFlowLayout.swift
//  GA_CollectionView
//
//  Created by houjianan on 16/6/14.
//  Copyright © 2016年 houjianan. All rights reserved.
//

import UIKit


protocol WaterFallLayoutDelegate: NSObjectProtocol {
    // 用来设置每一个cell的高度
    func heightForItemAtIndexPath(indexPath: NSIndexPath) -> CGFloat
}


class WaterFlowLayout: UICollectionViewFlowLayout {
    
    weak var delegate: WaterFallLayoutDelegate!

    var attributes: [UICollectionViewLayoutAttributes] = []
    let spacing: CGFloat = 10
    var screenWidth: CGFloat = 0 //横屏/竖屏
    var maxContentSizeHeigh: CGFloat = 0
    var maxYOfColums: [CGFloat] = []
    var colum: Int = 3
    var currentClum = 0
    var columWidth: CGFloat = 0

    override func prepareLayout() {
        super.prepareLayout()
        
        screenWidth = UIScreen.mainScreen().bounds.width
        columWidth = screenWidth / CGFloat(colum)
        
        attributes.removeAll()
        maxYOfColums.removeAll()
        
        for _ in 0..<colum {
            maxYOfColums.append(0)
        }
        
        let allCount = collectionView!.numberOfItemsInSection(0)
        for i in 0..<allCount {
            
            attributes.append(getAttribute(i))
            
        }
    }
    
    //布局
    func getAttribute(i: Int) -> UICollectionViewLayoutAttributes {
        let indexPath = NSIndexPath(forRow: i, inSection: 0)
        let obj = UICollectionViewLayoutAttributes(forCellWithIndexPath: indexPath)
        var x: CGFloat = 0
        var y: CGFloat = 0
        
        let height = delegate.heightForItemAtIndexPath(indexPath)
        if i < colum {
            currentClum = i
        } else {
            let minObj = maxYOfColums.minElement()!
            currentClum = maxYOfColums.indexOf(minObj)!
        }
        x = CGFloat(currentClum) * (columWidth + spacing)
        y = maxYOfColums[currentClum] + spacing
        maxYOfColums[currentClum] = y + height
        obj.frame = CGRectMake(x , y, columWidth, height)
        return obj
    }
    
    override func layoutAttributesForElementsInRect(rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        return attributes
    }
 
    // 返回collectionView的ContentSize -> 滚动范围
    override func collectionViewContentSize() -> CGSize {
        return CGSize(width: 0.0, height: maxYOfColums.maxElement()!)
    }
    
    //对cell进程删除、增加等操作时候会调用
    override func layoutAttributesForItemAtIndexPath(indexPath: NSIndexPath) -> UICollectionViewLayoutAttributes? {
        return attributes[indexPath.row]
    }
    
    // collectionView的bounds发生改变的时候调用
    override func shouldInvalidateLayoutForBoundsChange(newBounds: CGRect) -> Bool {
        // 旋转屏幕后刷新视图
        return newBounds.width != screenWidth
    }
    
    
}