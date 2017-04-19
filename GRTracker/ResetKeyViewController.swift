//
//  ResetKeyViewController.swift
//  GRTracker
//
//  Created by Grandre on 17/4/19.
//  Copyright © 2017年 革码者. All rights reserved.
//

import UIKit

class ResetKeyViewController: UIViewController,KeyBoardDlegate {

    @IBOutlet weak var topLayout: NSLayoutConstraint!
    
    @IBOutlet weak var phoneNum: UITextField!
    
    @IBOutlet weak var newKey: UITextField!
    @IBOutlet weak var checkKey: UITextField!
    
    @IBOutlet weak var changeKeyBtn: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        XKeyBoard.registerShow(self)
        XKeyBoard.registerHide(self)

            }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
  
    @IBAction func cancleBtn(_ sender: UIButton) {
        
        _ = self.navigationController?.popViewController(animated: true)
    }
    
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        phoneNum.resignFirstResponder()
        newKey.resignFirstResponder()
        checkKey.resignFirstResponder()
    }
    func keyboardWillShow(_ notification: Notification!) {
        UIView.animate(withDuration: 0.3) { 
            self.topLayout.constant = -150
            self.view.layoutIfNeeded()
        }
    }

    func keyboardWillHide(_ notification: Notification!) {
        self.topLayout.constant = 10
        self.view.layoutIfNeeded()
    }
}
