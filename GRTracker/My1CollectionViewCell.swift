//
//  My1CollectionViewCell.swift
//  GRTracker
//
//  Created by Grandre on 17/4/20.
//  Copyright © 2017年 革码者. All rights reserved.
//

import UIKit
//import Shimmer
class My1CollectionViewCell: UICollectionViewCell {
    
    var keyLable:UILabel!
    var valueLable:UILabel!
//    var shimmerView:FBShimmeringView!
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        keyLable = UILabel(frame: CGRect(x: 0, y: 0, width: self.bounds.width*0.5, height: self.bounds.height))
        keyLable.text = "在线:"
    
        self.addSubview(keyLable)
        
        valueLable = UILabel(frame: CGRect(x: self.bounds.width*0.5, y: 0, width: self.bounds.width*0.5, height: self.bounds.height))
        valueLable.text = "3台"
        self.addSubview(valueLable)
        
//        shimmerView = FBShimmeringView(frame: CGRect(x: 0, y: 0, width: self.bounds.width*0.5, height: self.bounds.height))
//        shimmerView.shimmeringBeginFadeDuration = 0.5
//        shimmerView.shimmeringEndFadeDuration = 0.5
//        shimmerView.shimmeringOpacity = 0.6
//        shimmerView.shimmeringAnimationOpacity = 1
//        shimmerView.shimmeringSpeed = 70
//        shimmerView.shimmeringPauseDuration = 0
//        shimmerView.shimmeringHighlightLength = 0.5
        
//        shimmerView.isShimmering = true
//        shimmerView.contentView = keyLable
//        self.addSubview(shimmerView)
        
        
      
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
