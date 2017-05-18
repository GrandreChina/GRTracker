//
//  MonitorViewController.swift
//  GRTracker
//
//  Created by Grandre on 17/4/14.
//  Copyright © 2017年 革码者. All rights reserved.
//

import UIKit
import Starscream
import SwiftyJSON
import Alamofire
class MonitorViewController: UIViewController,BMKMapViewDelegate{

    var _mapView:BMKMapView!
    var topCollectBottomV:topCollectButtomView!
    var socket:WebSocket!
    var deviceArr:[JSON]!
    
    func callBack(){
        self.alamofireGetData()
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        print("----GR---viewDidLoad---")
        self.checkLogin()
        self.initWebSoctket()
        self.initUI()
        self.initMapView()
        self.initTopButtomView()

    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        _mapView.viewWillAppear()
        print(" ----GR-----viewwill Appear")
        _mapView.delegate = self
        socket.connect()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        _mapView.viewWillDisappear()
        _mapView.delegate = nil
        
        print(" ----GR-----viewwill disAppear")
        socket.disconnect()
        
    }
    
    
//192.168.13.81:8090 内网
    func initWebSoctket(){
        socket = WebSocket(url: URL(string: "ws://210.75.20.143:5090/ugV9X6BQdSk4tR8CiC+/eEVhjx+n99F7bh+RyXsGZPp9ht3hX6cMos/As1grIThE")!)
        //websocketDidConnect
        socket.onConnect = {
            print("--GR--websocket is connected")
        }
        //websocketDidDisconnect
        socket.onDisconnect = { (error: NSError?) in
            print("--GR--websocket is disconnected: \(String(describing: error?.localizedDescription))")
        }
        //websocketDidReceiveMessage
        socket.onText = { (text: String) in
//            print("--GR--got some text: \(text)")
            
            //将string格式转换成json格式
            let object =  JSON(parseJSON: text)
            print(object)
        }
        //websocketDidReceiveData
        socket.onData = { (data: Data) in
            print("--GR--got some data: \(data.count)")
        }
        //you could do onPong as well.
//        socket.connect()
        
    }

   
    func initTopButtomView(){
        self.topCollectBottomV = topCollectButtomView(frame: CGRect(x: 0, y:((self.navigationController?.navigationBar.bounds.height)!+UIApplication.shared.statusBarFrame.height), width: self.view.bounds.width, height: 100))

        self.view.addSubview(topCollectBottomV)
 
    }
    func checkLogin(){
        let user =  UserDefaults.standard.object(forKey: "username")
   
        if user == nil{
            let storyBoard = UIStoryboard(name: "Login", bundle: nil)
            let loginVC = storyBoard.instantiateViewController(withIdentifier: "navlogin")
    
            self.present(loginVC, animated: true, completion: { 
                self.socket.disconnect()
            })
          
        }
    }
    func initUI(){
        self.title = "监控与跟踪"
        self.navigationController?.navigationBar.barTintColor = MAIN_RED
    }
    func initMapView(){
        //添加地图视图
        _mapView = BMKMapView()
        self.view.addSubview(_mapView!)
        self._mapView.snp.makeConstraints { (make) in
            make.left.right.bottom.equalTo(self.view)
            make.top.equalTo(self.view)
            
        }

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
        
        Alamofire.request("http://210.75.20.143:5080/web/gstracker/app/loadAll/0/25", method: .get, parameters: nil, encoding:JSONEncoding.default, headers: headers).responseJSON(completionHandler: { (response) in
            
            if let JSON2 = response.result.value{
                let flag = JSON(JSON2)["success"].boolValue
                if flag{
                    
                    self.deviceArr = JSON(JSON2)["list"].array
                    print(self.deviceArr)
                }
            }
        })
        
        
        
    }

      override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

}
