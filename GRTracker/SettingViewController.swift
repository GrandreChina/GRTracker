//
//  SettingViewController.swift
//  GRTracker
//
//  Created by Grandre on 17/4/14.
//  Copyright © 2017年 革码者. All rights reserved.
//

import UIKit

// MARK:- LXFMenuPageControllerDelegate
extension SettingViewController: LXFMenuPageControllerDelegate {
    func lxf_MenuPageCurrentSubController(index: NSInteger, menuPageController: LXFMenuPageController) {
        print("第\(index)个子控制器")
    }
}

class SettingViewController: UIViewController {

    var topHeight:CGFloat!
    var lxfMenuVc: LXFMenuPageController!
    var controllers:[UIViewController] = [UIViewController]()
    /// 子标题
    lazy var subTitleArr:[String] = {
        return ["设备列表", "轨迹", "设备信息"]
    }()
    

    
    func initUI(){
      self.navigationController?.navigationBar.barTintColor = MAIN_RED
        self.view.backgroundColor = UIColor.white
        self.title = "设置追踪器"
    }
    
    func initLXFMenVC(){

        self.topHeight = (self.navigationController?.navigationBar.frame.maxY)!
//      愚蠢的获取方法：
//      self.topHeight = (self.navigationController?.navigationBar.frame.height)! + UIApplication.shared.statusBarFrame.height
    
        let oneController = oneViewController(Bounds: ScreenHeight - topHeight! - (self.tabBarController?.tabBar.bounds.height)! - 40)
        let twoController = twoViewController(Bounds: ScreenHeight - topHeight! - (self.tabBarController?.tabBar.bounds.height)! - 40)
        let threeController = threeViewController()

    
        self.controllers = [oneController,twoController,threeController]
       

      self.lxfMenuVc = LXFMenuPageController(controllers: self.controllers, titles: self.subTitleArr, inParentController: self)
        self.lxfMenuVc.delegate = self
        
    
    
        lxfMenuVc.view.frame = self.CommonRect
        
        lxfMenuVc.sliderColor = MAIN_RED
        lxfMenuVc.tipBtnNormalColor = #colorLiteral(red: 0.2513027191, green: 0.2464391589, blue: 0.241748631, alpha: 1)
        lxfMenuVc.tipBtnHighlightedColor = MAIN_RED
        lxfMenuVc.headerColor = MAIN_RED.withAlphaComponent(0.2)
        lxfMenuVc.view.backgroundColor = UIColor.white
        lxfMenuVc.tipBtnFontSize = 15
        
        self.view.addSubview(lxfMenuVc.view)
        
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.initUI()
        self.initLXFMenVC()
      
       
    }
    
    
    /// 隐藏状态栏
//    override var prefersStatusBarHidden: Bool {
//        return true
//    }



    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
    
    deinit {
        print("----GR----SettingViewVC 退出了---")
    }

}
