//
//  ViewController.swift
//  GRTracker
//
//  Created by Grandre on 17/4/18.
//  Copyright © 2017年 革码者. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON
import SVProgressHUD
import MJRefresh
class oneViewController: UIViewController,UITableViewDelegate,UITableViewDataSource{

    var _index:NSInteger = 0
    var tableView:UITableView!
    var _bounds:CGFloat!
    var deviceArr:[JSON]! = []{
        didSet{
            self.tableView.reloadData()
            
        }
    }

    init(Bounds bounds:CGFloat = 400){
        self._bounds = bounds
        super.init(nibName: nil, bundle: nil)
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    override func viewDidLoad() {
        super.viewDidLoad()

        self.tableView = UITableView(frame: CGRect(x: 0, y: 0, width: ScreenWidth, height: _bounds))
        self.tableView.register(UITableViewCell.classForCoder(), forCellReuseIdentifier: "cell")
        self.tableView.register( UINib(nibName: "deviceInfoCell", bundle: Bundle.main), forCellReuseIdentifier: "deviceInfoCell")
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.tableView.mj_header = MJRefreshNormalHeader(refreshingBlock: { 
            print("---GR---")
            self.alamofireGetData()
            
        })
        
        self.tableView.mj_footer = MJRefreshBackNormalFooter(refreshingBlock: { 
            self.alamofireAddData()
        })
        self.automaticallyAdjustsScrollViewInsets = true
        self.view.addSubview(self.tableView)
        

    }

    override func viewWillAppear(_ animated: Bool) {
        self.tableView.mj_header.beginRefreshing()
        
    }
    
    
    //MARK: - Alamofire Add Data
    func alamofireAddData(){
        if tokenGlobal == nil{
            tokenGlobal = UserDefaults.standard.value(forKey: "token") as! String
        }
        let headers: HTTPHeaders = [
            "x-auth-token": tokenGlobal
        ]
 
        let currentIndex = self.deviceArr.count
        Alamofire.request("http://\(IP_API)/web/gstracker/app/loadAll/\(currentIndex)/3", method: .get, parameters: nil, encoding:JSONEncoding.default, headers: headers).responseJSON(completionHandler: { (response) in
      
            self.tableView.mj_footer.endRefreshing()
            if let JSON2 = response.result.value{
                let flag = JSON(JSON2)["success"].boolValue
                if flag{
//                   print(JSON(JSON2)["list"].array)
//批量添加元素 ：将一个数组的元素添加到另一个元素
                    self.deviceArr.insert(contentsOf: JSON(JSON2)["list"].array!, at: self.deviceArr.count)
                    

                    
                }
                
            }
        })
        
    }
    
    //MARK: - Alamofire Get Data
    func alamofireGetData(){
        print("获取数据")
        if tokenGlobal == nil{
            tokenGlobal = UserDefaults.standard.value(forKey: "token") as! String
        }
        let headers: HTTPHeaders = [
            "x-auth-token": tokenGlobal
        ]

        Alamofire.request("http://\(IP_API)/web/gstracker/app/loadAll/0/3", method: .get, parameters: nil, encoding:JSONEncoding.default, headers: headers).responseJSON(completionHandler: { (response) in

            self.tableView.mj_header.endRefreshing()
            if let JSON2 = response.result.value{
                let flag = JSON(JSON2)["success"].boolValue
                if flag{
              
                  self.deviceArr = JSON(JSON2)["list"].array
                    print(self.deviceArr)
                 }
            }
        })
        

    
    }

//    func alamofireLogout(){
//        SVProgressHUD.show(withStatus: "Logout ...")
//        
//        Alamofire.request("http://210.75.20.143:5080/web/logoutApp", method: .post, encoding: JSONEncoding.default).responseJSON { (response) in
//            
//            if let JSON1 = response.result.value {
//                let logoutSuccess = JSON(JSON1)["success"].boolValue
//                if logoutSuccess{
//                    SVProgressHUD.dismiss()
//                    SVProgressHUD.setMinimumDismissTimeInterval(1)
//                    SVProgressHUD.showSuccess(withStatus: "退出成功")
//                    
//                    UserDefaults.standard.removeObject(forKey: "username")
//                    UserDefaults.standard.synchronize()
//                    
//                    if UserDefaults.standard.object(forKey: "username") == nil{
//                        let storyBoard = UIStoryboard(name: "Login", bundle: nil)
//                        let loginVC = storyBoard.instantiateViewController(withIdentifier: "navlogin")
//                        self.present(loginVC, animated: true, completion: { () -> Void in
//                            let rootVC = UIApplication.shared.keyWindow?.rootViewController as! UITabBarController
//                            rootVC.selectedIndex = 0
//                        })
//                    }
//                    
//                }else{
//                    SVProgressHUD.dismiss()
//                    SVProgressHUD.setMinimumDismissTimeInterval(2)
//                    SVProgressHUD.showError(withStatus: "退出失败")
//                }
//                
//                
//            }
//        }
//    }
//    
//   
//        
    
  

    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

     func numberOfSections(in tableView: UITableView) -> Int {
       
        return 1
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 245
    }
     func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.deviceArr.count
    }

    
     func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "deviceInfoCell", for: indexPath) as! deviceInfoCell
        
        cell.selectionStyle = .none
        let data = deviceArr[indexPath.row]
        cell.deviceName.text = data["deviceName"].string
        cell.deviceID.text   = data["id"].stringValue
        cell.groupName.text  = data["groupName"].string
        cell.batteryCapcity.text  = data["batteryCapcity"].string
        cell.lng.text        = data["lng"].stringValue
        cell.lat.text        = data["lat"].stringValue
        
        return cell
    }
    
    
 
}
