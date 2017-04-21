//
//  topCollectButtomView.swift
//  GRTracker
//
//  Created by Grandre on 17/4/20.
//  Copyright © 2017年 革码者. All rights reserved.
//

import UIKit

class topCollectButtomView: UIView {

    override func layoutIfNeeded() {
        print("----layout if needed---")
    }
  
    override func layoutSubviews() {
        print("----layout Subviews----")
    }
    
    override func draw(_ rect: CGRect) {
        print("----drawRect-----------")
        
        //每次layoutSubviews时都会调用drawRect方法
        self.contentMode = .redraw
       
        let context = UIGraphicsGetCurrentContext()
        context?.setLineWidth(0.5)
        context?.setStrokeColor(MAIN_RED.cgColor)
        context?.move(to: CGPoint(x: 0, y: rect.size.height-15))
            
        context?.addLine(to: CGPoint(x: rect.size.width/2-30, y: rect.size.height-15))
            
        context?.strokePath()
        
        context?.move(to: CGPoint(x: rect.size.width/2 + 30, y: rect.size.height-15))
        
        context?.addLine(to: CGPoint(x: rect.size.width, y: rect.size.height-15))
        
        context?.strokePath()
        
        
    }
   

}
