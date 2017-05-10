//
//  AppDelegate.swift
//  GRTracker
//
//  Created by Grandre on 17/4/12.
//  Copyright © 2017年 革码者. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate,BMKGeneralDelegate{

    var window: UIWindow?
    var bmkManager:BMKMapManager?
    var tabbarController:UITabBarController!

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        
        bmkManager = BMKMapManager()
        let ret:Bool = (bmkManager?.start("mz7LIgdjbz94yon7LdzcZUHweVb7DtZi", generalDelegate: self))!
        if (ret != false){
            NSLog("manager start success!")
        }

        self.window = UIWindow(frame: CGRect(x: 0, y: 0, width: ScreenWidth, height: ScreenHeight))
        
        self.tabbarController = UITabBarController()
        
        let monitorController = UINavigationController(rootViewController: MonitorViewController())
        let settingController = UINavigationController(rootViewController: SettingViewController())
        let mineController = UINavigationController(rootViewController: MineViewController())
    
        monitorController.tabBarItem = UITabBarItem(title: "监控", image: UIImage(named:"tabbar_discover"), selectedImage: UIImage(named: "tabbar_discoverHL"))
        settingController.tabBarItem = UITabBarItem(title: "设置", image: UIImage(named: "bio"), selectedImage: UIImage(named: "bio_red"))
        mineController.tabBarItem = UITabBarItem(title: "我", image: UIImage(named: "users two-2"), selectedImage: UIImage(named: "users two-2_red"))
       
        
        tabbarController.tabBar.tintColor = MAIN_RED
        
        
        tabbarController.viewControllers = [monitorController,settingController,mineController]
        
        self.window?.rootViewController = tabbarController
        self.window?.makeKeyAndVisible()
        
        return true
    }

    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }


}

