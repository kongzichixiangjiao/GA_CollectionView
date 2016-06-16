//
//  ViewController.swift
//  GA_CollectionView
//
//  Created by houjianan on 16/6/14.
//  Copyright © 2016年 houjianan. All rights reserved.
//

import UIKit

class Data {
    var type = 0
    init(type: Int) {
        self.type = type
    }
}

class ViewController: UIViewController {
    
    let cellCount: Int = 40
    
    private lazy var cellHeight:[CGFloat] = {
        var arr:[CGFloat] = []
        for _ in 0..<self.cellCount {
            arr.append(CGFloat(arc4random() % 150 + 40))
        }
        return arr
    }()
    
    @IBOutlet weak var collectionView: UICollectionView!
    var data: [Data] = []
    override func viewDidLoad() {
        super.viewDidLoad()
        
        data = [Data(type: 0), Data(type: 1), Data(type: 1),  Data(type: 0), Data(type: 0), Data(type: 0), Data(type: 0), Data(type: 0), Data(type: 0), Data(type: 0), Data(type: 1), Data(type: 1), Data(type: 0)]
        
        collectionView?.collectionViewLayout = CustomFlowLayout()
        
//        let water = WaterFlowLayout()
//        water.delegate = self
//        water.colum = 3
//        collectionView?.collectionViewLayout = water
        
        collectionView.registerNib(UINib(nibName: "MyCell", bundle: nil), forCellWithReuseIdentifier: "MyCell")
        collectionView.registerNib(UINib(nibName: "MyImageCell", bundle: nil), forCellWithReuseIdentifier: "MyImageCell")
    }
    
}

extension ViewController: WaterFallLayoutDelegate {
    func heightForItemAtIndexPath(indexPath: NSIndexPath) -> CGFloat {
        return cellHeight[indexPath.row]
    }
}

extension ViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
//        if data[indexPath.row].type == 1 {
//            let cell = collectionView.dequeueReusableCellWithReuseIdentifier("MyImageCell", forIndexPath: indexPath)
//            cell.contentView.backgroundColor = UIColor.whiteColor()
//            return cell
//        } else {
            let cell = collectionView.dequeueReusableCellWithReuseIdentifier("MyCell", forIndexPath: indexPath)
            cell.contentView.backgroundColor = UIColor.orangeColor()
            return cell
//        }
    }
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        //        return data.count
        return cellCount
    }
    
    
    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return 1
    }
}