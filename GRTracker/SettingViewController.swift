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

   
    /// 子标题
    lazy var subTitleArr:[String] = {
        return ["推荐推荐", "设备1", "设备2", "设备3", "设备3"]
    }()
    
    /// 子控制器
    var controllers:[UIViewController] = {
        // 创建5个子控制器
        var cons:[UIViewController] = [UIViewController]()
        for _ in 0..<5 {
            // 创建随机颜色
            let red = CGFloat(arc4random_uniform(255))/CGFloat(255.0)
            let green = CGFloat( arc4random_uniform(255))/CGFloat(255.0)
            let blue = CGFloat(arc4random_uniform(255))/CGFloat(255.0)
            let colorRun = UIColor.init(red:red, green:green, blue:blue , alpha: 1)
            
            let subController = UIViewController()
            subController.view.backgroundColor = colorRun
            cons.append(subController)
        }
        return cons
    }()
    
    
    
    
    /// 菜单分类控制器
    lazy var lxfMenuVc: LXFMenuPageController = {
        let pageVc = LXFMenuPageController(controllers: self.controllers, titles: self.subTitleArr, inParentController: self)
        pageVc.delegate = self
        self.view.addSubview(pageVc.view)
        return pageVc
    }()
    
    func initUI(){
        self.navigationController?.navigationBar.barTintColor = MAIN_RED
        self.title = "设置追踪器"
    }
    
    func initLXFMenVC(){
        
        lxfMenuVc.sliderColor = MAIN_RED
        lxfMenuVc.tipBtnNormalColor = UIColor.black
        lxfMenuVc.tipBtnHighlightedColor = MAIN_RED
        lxfMenuVc.headerColor = MAIN_RED.withAlphaComponent(0.2)
        lxfMenuVc.view.backgroundColor = UIColor.white
        lxfMenuVc.tipBtnFontSize = 15
        
        let topHeight = (self.navigationController?.navigationBar.frame.height)! + UIApplication.shared.statusBarFrame.height
        lxfMenuVc.view.frame = CGRect(x: 0, y: topHeight, width: SCREEN_WIDTH, height: SCREEN_HEIGHT - topHeight - (self.tabBarController?.tabBar.bounds.height)!)
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
    

}
