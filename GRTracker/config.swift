//
//  config.swift
//  GRTracker
//
//  Created by Grandre on 17/4/14.
//  Copyright © 2017年 革码者. All rights reserved.
//

import Foundation
import UIKit

let ScreenWidth = UIScreen.main.bounds.width
let ScreenHeight = UIScreen.main.bounds.height


//let MAIN_RED = UIColor(colorLiteralRed: 235/255, green: 114/255, blue: 118/255, alpha: 1)

let MAIN_RED = #colorLiteral(red: 0.09574563056, green: 0.4620164633, blue: 0.95118016, alpha: 1)

var userNameGlobal:String!
var tokenGlobal:String!
extension UIViewController{
    var CommonRect:CGRect{
        get{
            return  CGRect(x: 0, y: (self.navigationController?.navigationBar.frame.height)! + UIApplication.shared.statusBarFrame.height, width: ScreenWidth, height: ScreenHeight - (self.navigationController?.navigationBar.frame.height)! - UIApplication.shared.statusBarFrame.height - (self.tabBarController?.tabBar.frame.height)!)
        }
    }
}
