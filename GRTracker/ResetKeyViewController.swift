//
//  ResetKeyViewController.swift
//  GRTracker
//
//  Created by Grandre on 17/4/19.
//  Copyright © 2017年 革码者. All rights reserved.
//

import UIKit

class ResetKeyViewController: UIViewController {

    @IBOutlet weak var topLayout: NSLayoutConstraint!
    
    @IBOutlet weak var phoneNum: UITextField!
    
    @IBOutlet weak var newKey: UITextField!
    @IBOutlet weak var checkKey: UITextField!
    
    @IBOutlet weak var changeKeyBtn: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        

            }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
  
    @IBAction func cancleBtn(_ sender: UIButton) {
        
        _ = self.navigationController?.popViewController(animated: true)
    }
    
 

}
