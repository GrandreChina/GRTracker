//
//  Extension.swift
//  GRTracker
//
//  Created by Grandre on 2017/5/27.
//  Copyright © 2017年 革码者. All rights reserved.
//

import UIKit

@IBDesignable
class GRLabel:UILabel{
    @IBInspectable var cornerRadius1:CGFloat = 0{
        didSet{
            self.layer.cornerRadius = cornerRadius1
            self.layer.masksToBounds = true
        }
    }
 
    
}
extension GRLabel{
    func setOffline(){
        self.backgroundColor = #colorLiteral(red: 0.6465656757, green: 0.6425724626, blue: 0.6422541142, alpha: 1)
        self.alpha = 0.3
    }
}
extension UIView {
    func findController() -> UIViewController! {
        return self.findControllerWithClass(UIViewController.self)
    }
    func findNavigator() -> UINavigationController! {
        return self.findControllerWithClass(UINavigationController.self)
    }
    func findControllerWithClass<T>(_ clzz: AnyClass) -> T? {
        var responder = self.next
        while(responder != nil) {
            if (responder!.isKind(of: clzz)) {
                return responder as? T
            }
            responder = responder?.next
        }
        return nil
    }
}
