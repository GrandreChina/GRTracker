//
//  NetWork.swift
//  GRTracker
//
//  Created by Grandre on 2017/5/19.
//  Copyright © 2017年 革码者. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON
import Starscream
import SVProgressHUD
class NetWork: NSObject {
    
    
    static var socket:WebSocket!//静态属性的好处是所有实例共用一份拷贝
    static var alamofireManager:SessionManager!
    
    
    
    static func getAllDeviceData(Block block:@escaping ([JSON])->Void){
        if tokenGlobal == nil{
            tokenGlobal = UserDefaults.standard.value(forKey: "token") as! String
        }
        let headers: HTTPHeaders = [
            "x-auth-token": tokenGlobal
//            "x-auth-token": "segsdg.sehe.sejlew"//模拟假token
        ]
        
        Alamofire.request("http://\(IP_API)/web/gstracker/app/loadAll/0/25", method: .get, parameters: nil, encoding:JSONEncoding.default, headers: headers).responseJSON(completionHandler: { (response) in
//            print("----response error \(response.error)---")
//            print("----response data   \(response.data)---")
//            print("----response description \(response.description)----")
//            print("----response result value\(response.result.value)")
            if let JSON2 = response.result.value{
                let flag = JSON(JSON2)["success"].boolValue
                if flag{
                    if let arr = JSON(JSON2)["list"].array{
                       block(arr)
                    }else{
                        print("获取数据为空")
                    }
                    
       
                }else{
                        print("---GR--可能token错误---请重新登录--")
                        if(JSON(JSON2)["message"] == "token unauthorized."){
                            print("-----GR--token 失效----")
                            UserDefaults.standard.removeObject(forKey: "username")
                            UserDefaults.standard.removeObject(forKey: "token")
                            UserDefaults.standard.synchronize()
                            
                            if UserDefaults.standard.object(forKey: "username") == nil
                                && UserDefaults.standard.object(forKey: "token") == nil{
                                
                                
                                let appDelegate = UIApplication.shared.delegate as! AppDelegate
                                appDelegate.checkLogin()
                                
                            }
                            
                            
                        }
                }
            }
        })
        
    }
    
    static func initWS(){
  
        socket = WebSocket(url: URL(string: "ws://\(IPWS_API)/ugV9X6BQdSk4tR8CiC+/eEVhjx+n99F7bh+RyXsGZPp9ht3hX6cMos/As1grIThE")!)
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
//            print(object)
            
        
            NotificationCenter.default.post(name: NSNotification.Name(rawValue: "WebSocketGetText"), object: self, userInfo: ["data":object])
            
            
            
        }
        //websocketDidReceiveData
        socket.onData = { (data: Data) in
            print("--GR--got some data: \(data.count)")
            print("--GR--got data\(data.description)")
        }

        
    }
    static func login(userName:String,passKey:String){
        SVProgressHUD.setDefaultMaskType(.black)
        SVProgressHUD.show(withStatus: "Login ...")
        
        let parameters: Parameters = [
            "username": userName,
            "password": passKey
        ]
        let config = URLSessionConfiguration.default
        config.timeoutIntervalForRequest = 4
        self.alamofireManager = SessionManager(configuration:config)
        self.alamofireManager.request("http://\(IP_API)/web/loginApp", method: .post, parameters: parameters, encoding: JSONEncoding.default, headers: nil).responseJSON { (response) in
            SVProgressHUD.dismiss()
            
            if let data = response.result.value{
                let jsonData = JSON(data)
                let loginSuccess = jsonData["success"].boolValue
                if loginSuccess{
                    print("----success---")
                    SVProgressHUD.dismiss()
                    SVProgressHUD.setMinimumDismissTimeInterval(1)
                    SVProgressHUD.showSuccess(withStatus: "登录成功")
                    userNameGlobal = userName                    
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
    static func logout(){
        SVProgressHUD.setDefaultMaskType(.black)
        SVProgressHUD.show(withStatus: "Logout ...")
        
        if tokenGlobal == nil{
            tokenGlobal = UserDefaults.standard.value(forKey: "token") as! String
        }
        let headers: HTTPHeaders = [
            "x-auth-token": tokenGlobal
            
        ]
        let config = URLSessionConfiguration.default
        config.timeoutIntervalForRequest = 4
        self.alamofireManager = SessionManager(configuration:config)
        self.alamofireManager.request("http://\(IP_API)/web/logoutApp", method: .post, parameters: nil, encoding: JSONEncoding.default, headers: headers).responseJSON { (response) in
            
            if let JSON1 = response.result.value {
                print(JSON(JSON1))
                let logoutSuccess = JSON(JSON1)["success"].boolValue
                if logoutSuccess{
                    SVProgressHUD.dismiss()
                    SVProgressHUD.setMinimumDismissTimeInterval(1)
                    SVProgressHUD.showSuccess(withStatus: "退出成功")
                    
                    UserDefaults.standard.removeObject(forKey: "username")
                    UserDefaults.standard.removeObject(forKey: "token")
                    UserDefaults.standard.synchronize()
                    
                    if UserDefaults.standard.object(forKey: "username") == nil
                        && UserDefaults.standard.object(forKey: "token") == nil{
                        
                        
                        let appDelegate = UIApplication.shared.delegate as! AppDelegate
                        appDelegate.checkLogin()
                        
                    }
                    
                }else{
                    SVProgressHUD.dismiss()
                    SVProgressHUD.setMinimumDismissTimeInterval(2)
                    SVProgressHUD.showError(withStatus: "退出失败")
                }
            }
        }
        

    }
    deinit {
        print("----GR-----NetWorkClass deinit--")
    }
}
