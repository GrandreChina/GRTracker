//
//  InfoAndSettingViewController.swift
//  GRTracker
//
//  Created by Grandre on 2017/5/26.
//  Copyright © 2017年 革码者. All rights reserved.
//

import UIKit
import SnapKit
import DGRunkeeperSwitch
class InfoAndSettingViewController: UIViewController,UIScrollViewDelegate
{

    
    var runkeeperSwitch:DGRunkeeperSwitch!
    var _scrollView:UIScrollView!
    var infoVC:InfoViewController!
    var settingDeviceVC:SettingDeviceViewController!

    var height:CGFloat!
    
    init() {
        super.init(nibName: nil, bundle: nil)
        self.infoVC = InfoViewController()
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        self.initUI()
        self.initSegment()
        self.initScrollView()
        
    
    }
    
    func initUI(){
        self.view.backgroundColor = UIColor.white
        self.automaticallyAdjustsScrollViewInsets = false
        
        self.navigationItem.setLeftBarButton(UIBarButtonItem(title: "<", style: .plain, target: self, action: #selector(self.backBtnPress)) , animated: true)
        
        self.navigationItem.leftBarButtonItem?.setTitleTextAttributes([NSForegroundColorAttributeName:UIColor.blue,NSFontAttributeName: UIFont(name: "Chalkduster", size: 20)!], for: UIControlState.normal)
        

    }
    
    func initSegment(){
        height = (self.navigationController?.navigationBar.frame.maxY)!
        runkeeperSwitch = DGRunkeeperSwitch(titles: ["信息", "设置"])
        runkeeperSwitch.backgroundColor = #colorLiteral(red: 0.36, green: 0.79, blue: 0.96, alpha: 1)
        runkeeperSwitch.selectedBackgroundColor = .white
        runkeeperSwitch.titleColor = .white
        runkeeperSwitch.selectedTitleColor = #colorLiteral(red: 0.36, green: 0.79, blue: 0.96, alpha: 1)
        runkeeperSwitch.titleFont = UIFont(name: "HelveticaNeue-Medium", size: 13.0)
        runkeeperSwitch.frame = CGRect(x: 30.0, y: 40.0, width: 200.0, height: 30.0)
        runkeeperSwitch.addTarget(self, action: #selector(self.switchValueDidChange(sender:)), for: .valueChanged)
        navigationItem.titleView = runkeeperSwitch
    }
    
    func initScrollView(){
        _scrollView = UIScrollView(frame: CGRect(x: 0, y: height, width: ScreenWidth, height: ScreenHeight - height ))
        _scrollView.delegate = self
        _scrollView.showsVerticalScrollIndicator = false
        _scrollView.showsHorizontalScrollIndicator = false
        
        _scrollView.contentSize = CGSize(width: ScreenWidth * CGFloat(2), height: ScreenHeight - height)
        //        _scrollView.isPagingEnabled = true
        //        _scrollView.bounces = true
        //        _scrollView.alwaysBounceHorizontal = true
        //        _scrollView.alwaysBounceVertical = false
        _scrollView.isScrollEnabled = false
        self.view.addSubview(_scrollView)
        
//        infoVC = InfoViewController()
        settingDeviceVC = SettingDeviceViewController()
        
        self.addChildViewController(infoVC)
        self.addChildViewController(settingDeviceVC)
        
        self.infoVC.view.frame = CGRect(x: 0, y: 0, width: ScreenWidth, height: ScreenHeight - height)
        self.settingDeviceVC.view.frame = CGRect(x: ScreenWidth, y: 0, width: ScreenWidth, height: ScreenHeight - height)
        
        self._scrollView.addSubview(infoVC.view)
        self._scrollView.addSubview(settingDeviceVC.view)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        print("---GR--infoAndSettingVC will appear--")
        self.tabBarController?.tabBar.isHidden = true
        if self.runkeeperSwitch.selectedIndex == 0{
            NetWork.socket.connect()
            showingInfoDetailVC = true
        }
        
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        print("---GR--infoAndSettingVC will disappear--")
        showingInfoDetailVC = false
        NetWork.socket.disconnect()
        
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    func backBtnPress(){
        self.navigationController?.popViewController(animated: true)
    }
    func switchValueDidChange(sender: DGRunkeeperSwitch!) {
//        print("valueChanged: \(sender.selectedIndex)")
        //判断是否在InfoViewController页面，才好在appdelegate中判断是否打开ws。
        if sender.selectedIndex == 1{
            showingInfoDetailVC = false
            NetWork.socket.disconnect()
        }else{
            showingInfoDetailVC = true
            NetWork.socket.connect()
        }
        
        self._scrollView.setContentOffset(CGPoint(x: ScreenWidth * CGFloat(sender.selectedIndex), y: 0), animated: true)
    }
    
    //目前取消了scrollView 的滚动
    func scrollViewDidScroll(_ scrollView: UIScrollView) {

        
    }
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        print("---GR--scrollViewDidEndDecelerating--")
        self.runkeeperSwitch.setSelectedIndex(Int(self._scrollView.contentOffset.x/ScreenWidth), animated: true)
    }
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        print("---GR--scrollViewDidEndDragging---")
        
        
    }
    deinit {
       
        print("----GR----infoAndSettingVC deinit--")
    }
}
