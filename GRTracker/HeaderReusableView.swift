//
//  HeaderReusableView.swift
//  collectionView
//
//  Created by Grandre on 16/6/28.
//  Copyright © 2016年 革码者. All rights reserved.
//

import UIKit

class HeaderReusableView: UICollectionReusableView {
    
    var label:UILabel!
    override func apply(_ layoutAttributes: UICollectionViewLayoutAttributes) {
//        print("------header----color")
        self.backgroundColor = UIColor.clear
        
        self.label = UILabel(frame: CGRect(x: 0, y: 0, width: self.bounds.width, height: self.bounds.height))
 
        label.textColor = UIColor.lightGray
        self.addSubview(label)
        
    }
}
