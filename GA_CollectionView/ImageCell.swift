//
//  ImageCell.swift
//  GA_CollectionView
//
//  Created by houjianan on 16/6/14.
//  Copyright © 2016年 houjianan. All rights reserved.
//

import UIKit

class ImageCell: UICollectionViewCell {

    @IBOutlet weak var imageView: UIImageView!
    var image: UIImage! {
        didSet {
            imageView.image = image
        }
    }
    /*
    override func drawRect(rect: CGRect) {
        let context = UIGraphicsGetCurrentContext()
        CGContextTranslateCTM(context, 0, rect.height)
        CGContextScaleCTM(context, 1, -1)
        CGContextRotateCTM(context, 0.1)
        CGContextDrawImage(context, CGRectMake(25, 25, rect.width - 50
            , rect.height - 50), image.CGImage)
    }
 */
}
