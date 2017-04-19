//
//  LoginViewController.swift
//  GRTracker
//
//  Created by Grandre on 17/4/18.
//  Copyright © 2017年 革码者. All rights reserved.
//

import UIKit

extension UIScrollView{
    override open func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.next?.touchesBegan(touches, with: event)
 
    }
    
}

class LoginViewController: UIViewController,KeyBoardDlegate{

    @IBOutlet weak var loginBtn: UIButton!
    @IBOutlet weak var scrollView: UIScrollView!
    
    @IBOutlet weak var topLayout: NSLayoutConstraint!
    
    @IBOutlet weak var userName: UITextField!
    
    
    @IBOutlet weak var passKey: UITextField!
    
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
        
        
                
        self.userName.layer.borderWidth = 1
        self.userName.layer.borderColor = MAIN_RED.cgColor
        self.userName.layer.cornerRadius = 3
        self.userName.layer.masksToBounds = true
        
        
        self.loginBtn.layer.cornerRadius = 3
        self.loginBtn.layer.masksToBounds = true
        
        XKeyBoard.registerHide(self)
        XKeyBoard.registerShow(self)
      
    }

    
    @IBAction func loginBtnPressed(_ sender: UIButton) {
        
        
        UserDefaults.standard.set("Grandre", forKey: "user")
            UserDefaults.standard.synchronize()
        self.dismiss(animated: true) { 
            
        }
    }
    
   
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.passKey.resignFirstResponder()
       self.userName.resignFirstResponder()
    }
 
    func keyboardWillHide(_ notification: Notification!) {
        UIView.animate(withDuration:0.3) { () -> Void in
            self.topLayout.constant = 10
            self.view.layoutIfNeeded()
        }
       
    }
    
    func keyboardWillShow(_ notification: Notification!) {
        UIView.animate(withDuration:0.3) { () -> Void in
            
          
            self.topLayout.constant = -150
            self.view.layoutIfNeeded()
        }
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    


}
