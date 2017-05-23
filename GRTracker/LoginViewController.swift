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

        NetWork.login(userName: self.userName.text!, passKey: self.passKey.text!)
    }
    
   

    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
     
    }
    deinit{
        print("--GR--LoginViewController deinit--")
    }


}
