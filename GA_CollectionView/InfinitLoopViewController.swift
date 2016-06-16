//
//  InfinitLoopViewController.swift
//  GA_CollectionView
//
//  Created by houjianan on 16/6/14.
//  Copyright © 2016年 houjianan. All rights reserved.
//

import UIKit

class InfinitLoopViewController: UIViewController {
    
    @IBOutlet weak var collectionView: UICollectionView!
    var images: [UIImage] = [] // 数据源
    var animation = true //timer方法是否执行
    
    override func viewDidLoad() {
        //获取数据源
        for i in 0..<5 {
            let image = UIImage(named: "00" + String(i + 1) + ".jpg")
            images.append(image!)
        }
        //001
        /// UICollectionViewFlowLayout 设置滚动方向，设置item大小
        let layout = UICollectionViewFlowLayout()
        layout.minimumLineSpacing = 0
        layout.scrollDirection = .Horizontal
        layout.itemSize = CGSizeMake(self.view.frame.size.width, self.view.frame.size.height - 20)
        //002
//        let layout = ScrollFlowLayout()
        
        collectionView.collectionViewLayout = layout
        // 注册cell
        collectionView.registerNib(UINib(nibName: "ImageCell", bundle: nil), forCellWithReuseIdentifier: "ImageCell")
        // 定时器
        let timer = NSTimer.scheduledTimerWithTimeInterval(1, target: self, selector: #selector(InfinitLoopViewController.timerAction), userInfo: nil, repeats: true)
        NSRunLoop.mainRunLoop().addTimer(timer, forMode: NSDefaultRunLoopMode)
        // 将collectionview滚动到中间的section位置
        self.performSelector(#selector(InfinitLoopViewController.setScrollPostion), withObject: nil, afterDelay: 0.1)
    }
    
    func timerAction() {
        if animation {
            // 获得看到的indexPath
            let currentIndexPath = collectionView.indexPathsForVisibleItems().last!
            // 计算新的row
            let newRow = (currentIndexPath.row + 1) % self.images.count
            // 计算新的section
            let newSection = currentIndexPath.section + (newRow == 0 ? 1 : 0);
            // 获得新的indexpath
            let newIndexPath = NSIndexPath(forRow: newRow, inSection: newSection)
            // 执行scrollToItemAtIndexPath
            collectionView.scrollToItemAtIndexPath(newIndexPath, atScrollPosition: .Left, animated: true)
        }
    }
    
    func setScrollPostion() {
        let newIndexPath = NSIndexPath(forRow: 1, inSection: 2000)
        // 执行scrollToItemAtIndexPath 不要动画
        collectionView.scrollToItemAtIndexPath(newIndexPath, atScrollPosition: .Left, animated: false)
    }
}

extension InfinitLoopViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    // 999999999
    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return 9999
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("ImageCell", forIndexPath: indexPath) as! ImageCell
        cell.image = images[indexPath.row]
        return cell
    }
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return images.count
    }
    //将要手动滚动视图 停止计时器
    func scrollViewWillBeginDragging(scrollView: UIScrollView) {
        animation = false
    }
    //结束手动滚动视图 停止计时器
    func scrollViewDidEndDecelerating(scrollView: UIScrollView) {
        animation = true
    }
}