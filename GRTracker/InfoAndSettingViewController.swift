//
//  InfoAndSettingViewController.swift
//  GRTracker
//
//  Created by Grandre on 2017/5/26.
//  Copyright © 2017年 革码者. All rights reserved.
//

import UIKit
import SnapKit
class InfoAndSettingViewController: UIViewController,DYSegmentDelegate,UIScrollViewDelegate
{

    
    var _segMentView:DYSegmentView!
    var _scrollView:UIScrollView!
    var infoVC:InfoViewController!
    var settingDeviceVC:SettingDeviceViewController!
    var threeVC:Three3ViewController!
    var height:CGFloat!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.white
        self.automaticallyAdjustsScrollViewInsets = false

        self.navigationItem.setLeftBarButton(UIBarButtonItem(title: "<", style: .plain, target: self, action: #selector(self.backBtnPress)) , animated: true)
        
        self.navigationItem.leftBarButtonItem?.setTitleTextAttributes([NSForegroundColorAttributeName:UIColor.blue,NSFontAttributeName: UIFont(name: "Chalkduster", size: 20)!], for: UIControlState.normal)
        
    
        
//        print(self.navigationController?.navigationBar.frame.maxY)
        height = (self.navigationController?.navigationBar.frame.maxY)!

        _segMentView = DYSegmentView(frame: CGRect(x:ScreenWidth/2 - 100, y:height - 44, width:200, height:44))
        _segMentView.delegate = self
        _segMentView.backgroundColor = UIColor.clear
        _segMentView.titleNormalColor = UIColor.darkGray
        _segMentView.titleSelectColor = UIColor.black
        _segMentView.titleFont        = UIFont.systemFont(ofSize: 15)
        _segMentView.titleArray       = ["信息","设置"]
        (_segMentView.value(forKey: "bottomLine") as! UIView).backgroundColor = UIColor.white
        self.navigationItem.titleView = _segMentView
       
        
        _scrollView = UIScrollView(frame: CGRect(x: 0, y: height, width: ScreenWidth, height: ScreenHeight - height ))
        _scrollView.delegate = self
        _scrollView.showsVerticalScrollIndicator = false
        _scrollView.showsHorizontalScrollIndicator = false
        
        _scrollView.contentSize = CGSize(width: ScreenWidth * CGFloat(_segMentView.titleArray.count), height: ScreenHeight - height)
        _scrollView.isPagingEnabled = true
        _scrollView.bounces = true
        _scrollView.alwaysBounceHorizontal = true
        _scrollView.alwaysBounceVertical = false
        self.view.addSubview(_scrollView)
        
        infoVC = InfoViewController()
        settingDeviceVC = SettingDeviceViewController()
//        threeVC = Three3ViewController()
        
        self.addChildViewController(infoVC)
        self.addChildViewController(settingDeviceVC)
//        self.addChildViewController(threeVC)
        self.infoVC.view.frame = CGRect(x: 0, y: 0, width: ScreenWidth, height: ScreenHeight - height)
        self.settingDeviceVC.view.frame = CGRect(x: ScreenWidth, y: 0, width: ScreenWidth, height: ScreenHeight - height)
//        self.threeVC.view.frame = CGRect(x: ScreenWidth*2, y: 0, width: ScreenWidth, height: ScreenHeight - height)
        self._scrollView.addSubview(infoVC.view)
        self._scrollView.addSubview(settingDeviceVC.view)
//        self._scrollView.addSubview(threeVC.view)
        
        
    }
    override func viewWillAppear(_ animated: Bool) {
        self.tabBarController?.tabBar.isHidden = true
    }
    override func viewWillDisappear(_ animated: Bool) {
        print("---infoAndSettingVC will disappear--")
        
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    func backBtnPress(){
        self.navigationController?.popViewController(animated: true)
    }
    func dySegment(_ segment: DYSegmentView!, didSelect index: Int) {
        print(index)
        let notiStr:String
        
        notiStr = String(index)
        self._scrollView.setContentOffset(CGPoint(x: ScreenWidth * CGFloat(index - 1), y: 0), animated: true)
        
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: "MainViewScrollDidScroll"), object: notiStr)
    }
    
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        _segMentView.dyDidScrollChangeTheTitleColor(withContentOfSet: scrollView.contentOffset.x)
    }
    
    deinit {
       
        print("----GR----infoAndSettingVC deinit--")
    }
}
