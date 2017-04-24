//
//  SettingViewController.swift
//  GRTracker
//
//  Created by Grandre on 17/4/14.
//  Copyright © 2017年 革码者. All rights reserved.
//

import UIKit

class SettingViewController: UIViewController {

    var _segHead:MLMSegmentHead!
    var _segScroll:MLMSegmentScroll!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.initUI()
        self.initSegmentView()
    }

    func initUI(){
        self.title = "设置跟踪对象"
        self.view.backgroundColor = UIColor.white
        self.navigationController?.navigationBar.barTintColor = MAIN_RED
    }
    
    func initSegmentView(){
        let list:Array = ["设备1","设备2","设备3"]
        
        self._segHead = MLMSegmentHead(frame: CGRect(x:0, y:64, width:SCREEN_WIDTH,height: 40), titles: list, headStyle:MLMSegmentHeadStyle(rawValue: 0), layoutStyle: MLMSegmentLayoutStyle(rawValue: 0))
        self._segHead.fontScale = 1.1;
        self._segHead.backgroundColor = UIColor.white
        self._segHead.headColor = MAIN_RED.withAlphaComponent(0.2)
        self._segHead.showIndex = 0
        
        self._segScroll = MLMSegmentScroll(frame: CGRect(x:0, y:_segHead.frame.maxY , width:SCREEN_WIDTH, height:SCREEN_HEIGHT-_segHead.frame.maxY-(self.tabBarController?.tabBar.height)!), vcOrViews: self.vcArr(count: list.count))
        self._segScroll.loadAll = true
        self._segScroll.bounces = true
        

   
        
        MLMSegmentManager.associateHead(self._segHead, with: self._segScroll, contentChangeAni: false, completion: {
            self.view.addSubview(self._segHead)
            self.view.addSubview(self._segScroll)
        }) { (index:NSInteger) in
            NSLog("第%ld个视图,有什么操作?",index)
        }
    
    }
    
    func vcArr(count:Int)->[UIViewController]{
        var arr:Array = [UIViewController]()
        
            let vc = oneViewController()
            vc._index = 1
        
            let vc2 = twoViewController()
        
            let vc3 = threeViewController()
        arr = [vc,vc2,vc3]
        
        
        return arr
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
            }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
