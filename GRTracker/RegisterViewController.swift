//
//  RegisterViewController.swift
//  GRTracker
//
//  Created by Grandre on 17/4/18.
//  Copyright © 2017年 革码者. All rights reserved.
//

import UIKit

class RegisterViewController: UIViewController,KeyBoardDlegate {

    @IBAction func cancleBtn(_ sender: UIButton) {
        
        _ = self.navigationController?.popViewController(animated: true)
    }
    
    @IBOutlet weak var topLayout: NSLayoutConstraint!
    @IBOutlet weak var phoneNum: UITextField!
    
    @IBOutlet weak var passKey: UITextField!
    
    @IBOutlet weak var checkKey: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        XKeyBoard.registerHide(self)
        XKeyBoard.registerShow(self)
        
    }

    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        passKey.resignFirstResponder()
        phoneNum.resignFirstResponder()
        checkKey.resignFirstResponder()
        
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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


}
