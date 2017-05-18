//
//  RegisterViewController.swift
//  GRTracker
//
//  Created by Grandre on 17/4/18.
//  Copyright © 2017年 革码者. All rights reserved.
//

import UIKit

class RegisterViewController: UIViewController{

    @IBAction func cancleBtn(_ sender: UIButton) {
        
        _ = self.navigationController?.popViewController(animated: true)
    }
    
    @IBOutlet weak var topLayout: NSLayoutConstraint!
    @IBOutlet weak var phoneNum: UITextField!
    
    @IBOutlet weak var passKey: UITextField!
    
    @IBOutlet weak var checkKey: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }

    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    



}
