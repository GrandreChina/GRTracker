//
//  LoginViewController.swift
//  GRTracker
//
//  Created by Grandre on 17/4/18.
//  Copyright © 2017年 革码者. All rights reserved.
//

import UIKit
import SVProgressHUD
import Alamofire
import SwiftyJSON

//extension UIScrollView{
//    override open func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
//        self.next?.touchesBegan(touches, with: event)
// 
//    }
//    
//}

class LoginViewController: UIViewController{

    @IBOutlet weak var loginBtn: UIButton!
    @IBOutlet weak var scrollView: UIScrollView!
    
    @IBOutlet weak var topLayout: NSLayoutConstraint!
    
    @IBOutlet weak var userName: UITextField!
    
    
    @IBOutlet weak var passKey: UITextField!
    

    var alamofireManager:SessionManager!
    override func viewWillAppear(_ animated: Bool) {
      self.navigationController?.isNavigationBarHidden = true
    }
   
    override func viewDidLoad() {
        super.viewDidLoad()
    
        self.scrollView.showsVerticalScrollIndicator = false
        self.automaticallyAdjustsScrollViewInsets = false
        self.passKey.layer.borderWidth = 1
        self.passKey.layer.borderColor = MAIN_RED.cgColor
        self.passKey.layer.cornerRadius = 3
        self.passKey.layer.masksToBounds = true
        self.passKey.isSecureTextEntry = true
        
                
        self.userName.layer.borderWidth = 1
        self.userName.layer.borderColor = MAIN_RED.cgColor
        self.userName.layer.cornerRadius = 3
        self.userName.layer.masksToBounds = true
        self.userName.clearButtonMode = .always
        
        self.loginBtn.layer.cornerRadius = 3
        self.loginBtn.layer.masksToBounds = true

    }

    
    @IBAction func loginBtnPressed(_ sender: UIButton) {

        self.alamofireLogin()
    }
    
    func alamofireLogin(){
        SVProgressHUD.setDefaultMaskType(.black)
        SVProgressHUD.show(withStatus: "Login ...")
        
        let parameters: Parameters = [
            "username": userName.text!,
            "password": passKey.text!
        ]
//
//        Alamofire.request("http://210.75.20.143:5080/web/loginApp", method: .post, parameters: parameters, encoding: JSONEncoding.default).responseJSON { (response) in
//            print(response.data!)
//            SVProgressHUD.dismiss()
//            if let JSON1 = response.result.value {
//                print(JSON1)
//                let loginSuccess = JSON(JSON1)["success"].boolValue
//                print(loginSuccess)
//                if loginSuccess {
//                    print("登录成功")
//                    SVProgressHUD.dismiss()
//                    SVProgressHUD.setMinimumDismissTimeInterval(2)
//                    SVProgressHUD.showSuccess(withStatus: "登录成功")
//                    userNameGlobal = self.userName.text!
//                    UserDefaults.standard.set(userNameGlobal, forKey: "username")
//                        UserDefaults.standard.synchronize()
//                    self.dismiss(animated: true) {
//                        
//                    }
//                    
//                
//                }else{
//                    SVProgressHUD.dismiss()
//                    SVProgressHUD.setMinimumDismissTimeInterval(2)
//                    SVProgressHUD.showError(withStatus: "登录失败")
//                    print("登录失败")
//                }
//               
//                
//            }
//            
//        }
//        
//        
        
        let config = URLSessionConfiguration.default
        config.timeoutIntervalForRequest = 8
        self.alamofireManager = SessionManager(configuration:config)
        self.alamofireManager.request("http://210.75.20.143:5080/web/loginApp", method: .post, parameters: parameters, encoding: JSONEncoding.default, headers: nil).responseJSON { (response) in
            SVProgressHUD.dismiss()

            if let data = response.result.value{
                let jsonData = JSON(data)
                let loginSuccess = jsonData["success"].boolValue
                if loginSuccess{
                    print("----success---")
                    SVProgressHUD.dismiss()
                    SVProgressHUD.setMinimumDismissTimeInterval(1)
                    SVProgressHUD.showSuccess(withStatus: "登录成功")
                    userNameGlobal = self.userName.text!
                    
                    tokenGlobal = (jsonData["entity"].dictionary!)["token"]?.string
                    
                    UserDefaults.standard.set(userNameGlobal, forKey: "username")
                    UserDefaults.standard.set(tokenGlobal, forKey: "token")
                    
                    print(tokenGlobal)
                    UserDefaults.standard.synchronize()
                    
                    let appDelegate = UIApplication.shared.delegate as! AppDelegate
                    appDelegate.checkLogin()
                    
                    
                }else{
                    let jsonData = JSON(data)
                    let message =  jsonData["message"].stringValue
                    SVProgressHUD.dismiss()
                    SVProgressHUD.setMinimumDismissTimeInterval(1)
                    SVProgressHUD.showError(withStatus: message)
                    print("登录失败")
                }
            }
        }
    }
    

    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
     
    }
    deinit{
        print("--LoginViewController deinit--")
    }


}
