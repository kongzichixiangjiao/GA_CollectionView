//
//  WaterFlowLayout.swift
//  GA_CollectionView
//
//  Created by houjianan on 16/6/14.
//  Copyright © 2016年 houjianan. All rights reserved.
//

import UIKit

class CellFrame {
    var x: CGFloat = 0
    var y: CGFloat = 0
    var w: CGFloat = 0
    var h: CGFloat = 0
    var maxY: CGFloat = 0
}

class CustomFlowLayout: UICollectionViewFlowLayout {
    
    var attributes: [UICollectionViewLayoutAttributes] = []
    var mFrames: [CellFrame] = []
    let spacing: CGFloat = 10
    var screenWidth: CGFloat = 0 //横屏/竖屏
    
    override func prepareLayout() {
        super.prepareLayout()
        screenWidth = UIScreen.mainScreen().bounds.width
        let allCount = collectionView!.numberOfItemsInSection(0)
        mFrames.removeAll()
        for i in 0..<allCount {
            
            attributes.append(getAttribute(i))
        
        }
    }
    
    //布局
    func getAttribute(i: Int) -> UICollectionViewLayoutAttributes {
        let indexPath = NSIndexPath(forRow: i, inSection: 0)
        let obj = UICollectionViewLayoutAttributes(forCellWithIndexPath: indexPath)
        let cW: CGFloat = screenWidth - 20
        let cellFrame = CellFrame()
        switch i {
        case 0:
            cellFrame.x = 0; cellFrame.y = 20
            cellFrame.w = cW; cellFrame.h = 100
            cellFrame.maxY = cellFrame.y + cellFrame.h + cellFrame.maxY
        case 1:
            cellFrame.x = 0; cellFrame.y = mFrames[i - 1].maxY + spacing
            cellFrame.w = cW / 2 - spacing / 2; cellFrame.h = 50
            cellFrame.maxY = cellFrame.y + cellFrame.h + cellFrame.maxY
        case 2:
            cellFrame.x = mFrames[i - 1].w + spacing; cellFrame.y = mFrames[i - 1].y
            cellFrame.w = cW / 2 - spacing / 2; cellFrame.h = 50
            cellFrame.maxY = cellFrame.y + cellFrame.h + cellFrame.maxY
        case 10:
            cellFrame.x = 0; cellFrame.y = mFrames[i - 1].maxY + spacing
            cellFrame.w = cW / 2 - spacing / 2; cellFrame.h = 50
            cellFrame.maxY = cellFrame.y + cellFrame.h + cellFrame.maxY
        case 11:
            cellFrame.x = mFrames[i - 1].w + spacing; cellFrame.y = mFrames[i - 1].y
            cellFrame.w = cW / 2 - spacing / 2; cellFrame.h = 50
            cellFrame.maxY = cellFrame.y + cellFrame.h + cellFrame.maxY
        default:
            cellFrame.x = 0;
            cellFrame.y = mFrames[i - 1].maxY + spacing
            cellFrame.w = cW
            cellFrame.h = 100
            cellFrame.maxY = cellFrame.maxY + cellFrame.y + cellFrame.h
            break
        }
        
        mFrames.append(cellFrame)
        obj.frame = CGRectMake(cellFrame.x , cellFrame.y, cellFrame.w, cellFrame.h)
//        obj.transform3D = CATransform3DMakeRotation(0.1, 0, 0, 1)
        return obj
    }
    
    override func layoutAttributesForElementsInRect(rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        return attributes
    }
    
    // 返回collectionView的ContentSize -> 滚动范围
    override func collectionViewContentSize() -> CGSize {
        return CGSize(width: 0.0, height: mFrames.last!.maxY)
    }
    
    //对cell进程删除、增加等操作时候会调用
    override func layoutAttributesForItemAtIndexPath(indexPath: NSIndexPath) -> UICollectionViewLayoutAttributes? {
        return attributes[indexPath.row]
    }
    
    // collectionView的bounds发生改变的时候调用
    override func shouldInvalidateLayoutForBoundsChange(newBounds: CGRect) -> Bool {
        return true
    }
    
}
