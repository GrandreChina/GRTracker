//
//  topBtnCollectView.swift
//  GRTracker
//
//  Created by Grandre on 2017/5/23.
//  Copyright © 2017年 革码者. All rights reserved.
//

import UIKit
import SnapKit

protocol topBtnCollectViewDelegate:class{
    func topBtnCollectViewTouch(_ sender:UIButton)
}
class topBtnCollectView: UIView {
    weak var delegate:topBtnCollectViewDelegate!
    var onLineBtn:UIButton!
    var offLineBtn:UIButton!
    var lowBatteryBtn:UIButton!
    var weilanBtn:UIButton!
    
//    var onLineLabel:UILabel!
//    var offLineLabel:UILabel!
//    var lowBatteryLabel:UILabel!
//    var weilanLabel:UILabel!
    

    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = UIColor.clear
        onLineBtn = UIButton()
        onLineBtn.backgroundColor = #colorLiteral(red: 0.2588235438, green: 0.7568627596, blue: 0.9686274529, alpha: 1)
        onLineBtn.layer.cornerRadius = (self.bounds.height )/2
        onLineBtn.layer.masksToBounds = true
        onLineBtn.tag = 1
        onLineBtn.setTitle("10", for: .normal)
        onLineBtn.addTarget(self, action: #selector(self.btnTouch(_:)), for: .touchUpInside)
        self.addSubview(onLineBtn)
        onLineBtn.snp.makeConstraints { (make) in
            make.width.height.equalTo(self.bounds.height  )
            make.top.equalTo(self)
            make.centerX.equalTo(ScreenWidth/4/2)
            
        }
        
//        onLineLabel = UILabel()
//        onLineLabel.backgroundColor = #colorLiteral(red: 0.2588235438, green: 0.7568627596, blue: 0.9686274529, alpha: 1).withAlphaComponent(0.3)
//        onLineLabel.text = "在线"
//        onLineLabel.textAlignment = .center
//        self.addSubview(onLineLabel)
//        
//        onLineLabel.snp.makeConstraints { (make) in
//            make.width.equalTo(50)
//            make.height.equalTo(20)
//            make.bottom.equalTo(self.snp.bottom)
//            make.centerX.equalTo(onLineBtn)
//        }
        
        
        offLineBtn = UIButton()
        offLineBtn.backgroundColor = #colorLiteral(red: 0.501960814, green: 0.501960814, blue: 0.501960814, alpha: 1)
        offLineBtn.layer.cornerRadius = (self.bounds.height )/2
        offLineBtn.layer.masksToBounds = true
        offLineBtn.tag = 2
        offLineBtn.setTitle("1", for: .normal)
        offLineBtn.addTarget(self, action: #selector(self.btnTouch(_:)), for: .touchUpInside)
        self.addSubview(offLineBtn)
        
        offLineBtn.snp.makeConstraints { (make) in
            make.width.height.equalTo(self.bounds.height  )
            make.top.equalTo(self)
            make.centerX.equalTo(ScreenWidth/4/2 + ScreenWidth/4)
        }
        
//        offLineLabel = UILabel()
//        offLineLabel.backgroundColor = #colorLiteral(red: 0.501960814, green: 0.501960814, blue: 0.501960814, alpha: 1).withAlphaComponent(0.3)
//        offLineLabel.text = "离线"
//        offLineLabel.textAlignment = .center
//        self.addSubview(offLineLabel)
//        
//        offLineLabel.snp.makeConstraints { (make) in
//            make.width.equalTo(50)
//            make.height.equalTo(20)
//            make.bottom.equalTo(self.snp.bottom)
//            make.centerX.equalTo(offLineBtn)
//        }
        
        lowBatteryBtn = UIButton()
        lowBatteryBtn.backgroundColor = #colorLiteral(red: 0.9686274529, green: 0.78039217, blue: 0.3450980484, alpha: 1)
        lowBatteryBtn.layer.cornerRadius = self.bounds.height/2
        lowBatteryBtn.layer.masksToBounds = true
        lowBatteryBtn.tag = 3
        lowBatteryBtn.setTitle("3", for: .normal)
        lowBatteryBtn.addTarget(self, action: #selector(self.btnTouch(_:)), for: .touchUpInside)
        self.addSubview(lowBatteryBtn)
        
        lowBatteryBtn.snp.makeConstraints { (make) in
            make.width.height.equalTo(self.bounds.height )
            make.top.equalTo(self)
            make.centerX.equalTo(ScreenWidth/4/2 + ScreenWidth/4*2)
        }
        
//        lowBatteryLabel = UILabel()
//        lowBatteryLabel.backgroundColor = #colorLiteral(red: 0.9686274529, green: 0.78039217, blue: 0.3450980484, alpha: 1).withAlphaComponent(0.3)
//        lowBatteryLabel.text = "低电量"
//        lowBatteryLabel.textAlignment = .center
//        self.addSubview(lowBatteryLabel)
//        
//        lowBatteryLabel.snp.makeConstraints { (make) in
//            make.width.equalTo(50)
//            make.height.equalTo(20)
//            make.bottom.equalTo(self.snp.bottom)
//            make.centerX.equalTo(lowBatteryBtn)
//        }
        
        weilanBtn = UIButton()
        weilanBtn.backgroundColor = #colorLiteral(red: 0.4392156899, green: 0.01176470611, blue: 0.1921568662, alpha: 1)
        weilanBtn.layer.cornerRadius = (self.bounds.height )/2
        weilanBtn.layer.masksToBounds = true
        weilanBtn.tag = 4
        weilanBtn.setTitle("6", for: .normal)
        weilanBtn.addTarget(self, action: #selector(self.btnTouch(_:)), for: .touchUpInside)
        self.addSubview(weilanBtn)
        
        weilanBtn.snp.makeConstraints { (make) in
            make.width.height.equalTo(self.bounds.height )
            make.top.equalTo(self)
            make.centerX.equalTo(ScreenWidth/4/2 + ScreenWidth/4*3)
        }
        
//        weilanLabel = UILabel()
//        weilanLabel.backgroundColor = #colorLiteral(red: 0.4392156899, green: 0.01176470611, blue: 0.1921568662, alpha: 1).withAlphaComponent(0.3)
//        weilanLabel.text = "闯围栏"
//        weilanLabel.textAlignment = .center
//        self.addSubview(weilanLabel)
//        
//        weilanLabel.snp.makeConstraints { (make) in
//            make.width.equalTo(50)
//            make.height.equalTo(20)
//            make.bottom.equalTo(self.snp.bottom)
//            make.centerX.equalTo(weilanBtn)
//        }
    }
    
    
    func btnTouch(_ sender:UIButton){
        delegate.topBtnCollectViewTouch(sender)
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    deinit {
        print("----GR----topCollectiveView deinit----")
    }

}
