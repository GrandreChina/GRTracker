//
//  MineViewController.swift
//  GRTracker
//
//  Created by Grandre on 17/4/14.
//  Copyright © 2017年 革码者. All rights reserved.
//

import UIKit

class MineViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {

    var tableView:UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.initUI()
        self.initTableView()
    }

    func initUI(){
        self.title = "个人信息"
        self.view.backgroundColor = UIColor.white
        self.navigationController?.navigationBar.barTintColor = MAIN_RED
        
    }
    func initTableView(){
        self.tableView                                        = UITableView(frame: self.view.frame, style: .grouped)
        self.tableView?.delegate                              = self
        self.tableView?.dataSource                            = self
        self.tableView.register(UITableViewCell.classForCoder(), forCellReuseIdentifier: "cell2")
   
        self.tableView?.register( userImage_NameCell.classForCoder(),forCellReuseIdentifier: "usercell")
        self.tableView?.tableFooterView                       = UIView()
        self.tableView?.backgroundColor                       = UIColor.darkGray
        self.view.addSubview(self.tableView!)
        
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0:
            return 1
        case 1:
            return 4
        default:
            return 1
        }
    }
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        //        NSLog("----GR----height")
        let cellPosition = (row:indexPath.row,section:indexPath.section)
        switch cellPosition {
        case (0,0):
            return 90
        case (0,2):
            return 40
        default:
            return 45
        }
        
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        var cell:UITableViewCell!
        
        let cellPosition = (row:indexPath.row,section:indexPath.section)
        /**
         *  @author 革码者, 16-05-27 09:05:51
         *
         *  (0,0)即是第一个cell，这个cell使用自定义的userImage_NameCell类
         */
        switch cellPosition {
        case (0,0):
            
            cell = self.tableView?.dequeueReusableCell(withIdentifier: "usercell", for: indexPath) as! userImage_NameCell
            
        default:
            cell = self.tableView?.dequeueReusableCell(withIdentifier: "cell2", for: indexPath)
            for subView in cell.contentView.subviews{
                subView.removeFromSuperview()
            }
        }
        if cellPosition != (0,2){
            cell.accessoryType = .disclosureIndicator
        }
        //应该这样获取cell，这时候cell的frame的height才是heightForRowAtIndexPath里面设置的。
        //        if indexPath.row == 0 && indexPath.section == 0{
        //            cell = self.tableView?.dequeueReusableCellWithIdentifier("usercell", forIndexPath: indexPath) as! userImage_NameCell
        //        }else{
        //            cell = (self.tableView?.dequeueReusableCellWithIdentifier("cell", forIndexPath: indexPath))! as UITableViewCell
        //        }
        //
        /// 下面这句这样获取的cell，cell的frame并不是heightforrow里面设置的。
        //        let cell = UITableViewCell(style: .Value1, reuseIdentifier: "cell")
        
        switch cellPosition {
        case (0,0):
            break
        case (0,1):
            cell.imageView?.image = UIImage(named: "ff_IconShowAlbum")
        case (1,1):
            cell.imageView?.image = UIImage(named: "MoreMyFavorites")
        case (2,1):
            cell.imageView?.image = UIImage(named: "MoreMyBankCard")
        case (3,1):
            cell.imageView?.image = UIImage(named: "MoreSetting")
            break
        case (0,2):
            let logoutButton = UIButton(frame: CGRect(x:10,y:5,width:self.view.width-20,height:cell.frame.height-10))
            logoutButton.backgroundColor = UIColor(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
            logoutButton.setTitle("退出", for: .normal)
            logoutButton.setTitleColor(UIColor.black, for: .normal)
            logoutButton.addTarget(self, action: #selector(self.logoutBtnTapped), for: UIControlEvents.touchUpInside)
            cell.addSubview(logoutButton)
        default:
            break
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        
        let cellPosition = (row:indexPath.row,section:indexPath.section)
        switch cellPosition {
        case (0,0):
//            GeneralFactory.readImageFile(  (cell  as! userImage_NameCell).logoImageView!)
            //            if let touXiang = AVUser.currentUser()["touXiangFile"] as? AVFile{
            //                print("--------1-------")
            //
            //                 (cell  as! userImage_NameCell).logoImageView?.sd_setImageWithURL(NSURL(string:touXiang.url), placeholderImage: UIImage(named: "Action_Moments"), completed: { (image, error,type, url) in
            //                    self.userTouXiang = UIImageView(image: image)
            //                    print(self.userTouXiang)
            //                 })
            //
            //
            //            }else{
            //                print("--------2-------")
            //                 (cell  as! userImage_NameCell).logoImageView?.image = UIImage(named: "Avatar")
            //                self.userTouXiang = UIImageView(image: UIImage(named: "Avatar"))
            //            }
            
            break
        default:
            break
        }
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
   
        self.tableView?.deselectRow(at: indexPath as IndexPath, animated: true)
        let cellPosition = (row:indexPath.row,section:indexPath.section)
        switch cellPosition {
        case (0,0):
//            let personInfoVC = personInfoViewController()
//            personInfoVC.userTouXiang = self.userTouXiang
//            personInfoVC.hidesBottomBarWhenPushed = true
//            self.navigationController?.pushViewController(personInfoVC, animated: true)
            break
        case (0,1):
            break
        default:
            break
        }
    }
    
    
    
   
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {

        switch section {
        case 2:
            return "真的要离开了吗？"
        default:
            return nil
        }
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        switch section {
        case 2:
            return 50
        default:
            return 10
        }
    }
    
    func logoutBtnTapped(){
        
        let alertVC = UIAlertController(title: "客官", message: "真的要注销退出用户吗", preferredStyle: .alert)
        
        let alertAc1 = UIAlertAction(title: "确定", style: .default) { (_) in
            UserDefaults.standard.removeObject(forKey: "user")
            UserDefaults.standard.synchronize()
            
            if UserDefaults.standard.object(forKey: "user") == nil{
                let storyBoard = UIStoryboard(name: "Login", bundle: nil)
                let loginVC = storyBoard.instantiateViewController(withIdentifier: "nav")
                self.present(loginVC, animated: true, completion: { () -> Void in
                    let rootVC = UIApplication.shared.keyWindow?.rootViewController as! UITabBarController
                    rootVC.selectedIndex = 0
                })
            }
        }
        
        let alertAc2 = UIAlertAction(title: "取消", style: .default) { (_) in
            self.dismiss(animated: true, completion: {
                
            })
        }
        alertVC.addAction(alertAc2)
        alertVC.addAction(alertAc1)
        self.present(alertVC, animated: true) {
            
        }
        
    }
    override func viewWillAppear(_ animated: Bool) {
        
        self.tableView?.reloadData()
        
    }
    override func viewWillDisappear(_ animated: Bool) {
        
    }


}
