//
//  MonitorViewController.swift
//  GRTracker
//
//  Created by Grandre on 17/4/14.
//  Copyright © 2017年 革码者. All rights reserved.
//

import UIKit
import Starscream
class MonitorViewController: UIViewController,BMKMapViewDelegate,BMKDistrictSearchDelegate {

    var _mapView:BMKMapView!
    var districtSearch: BMKDistrictSearch!
    var topCollectBottomView:topCollectButtomView!
    var socket:WebSocket!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.checkLogin()
        self.initWebSoctket()
        self.initUI()
        self.initMapView()
        self.initTopButtomView()

    }


    func initWebSoctket(){
        socket = WebSocket(url: URL(string: "ws://192.168.13.81:8090/ugV9X6BQdSk4tR8CiC+/eEVhjx+n99F7bh+RyXsGZPp9ht3hX6cMos/As1grIThE")!)
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
            print("--GR--got some text: \(text)")
        }
        //websocketDidReceiveData
        socket.onData = { (data: Data) in
            print("--GR--got some data: \(data.count)")
        }
        //you could do onPong as well.
//        socket.connect()
        
    }

   
    func initTopButtomView(){
        self.topCollectBottomView = topCollectButtomView(frame: CGRect(x: 0, y:((self.navigationController?.navigationBar.bounds.height)!+UIApplication.shared.statusBarFrame.height), width: self.view.bounds.width, height: 100))

        self.topCollectBottomView.height1 = (self.navigationController?.navigationBar.bounds.height)!+UIApplication.shared.statusBarFrame.height
        
        self.view.addSubview(topCollectBottomView)
    }
    func checkLogin(){
        let user =  UserDefaults.standard.object(forKey: "username")
 
        
        if user == nil{
            let storyBoard = UIStoryboard(name: "Login", bundle: nil)
            let loginVC = storyBoard.instantiateViewController(withIdentifier: "navlogin")
           
            self.present(loginVC, animated: true, completion: { 
                
            })
          
        }
    }
    func initUI(){
        self.title = "监控与跟踪"
        self.navigationController?.navigationBar.barTintColor = MAIN_RED
    }
    func initMapView(){
        //添加地图视图
//        let topHeight = (self.navigationController?.navigationBar.frame.height)! + UIApplication.shared.statusBarFrame.height
//        _mapView = BMKMapView(frame: CGRect(x: 0, y: topHeight, width: self.view.frame.width, height: self.view.frame.height - topHeight - (self.tabBarController?.tabBar.frame.height)!))
       
        _mapView = BMKMapView()
        self.view.addSubview(_mapView!)
        
        self._mapView.snp.makeConstraints { (make) in
            make.left.right.bottom.equalTo(self.view)
            make.top.equalTo(self.view)
            
        }
        // 初始化搜索服务
        districtSearch = BMKDistrictSearch()
       
        


    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        _mapView.viewWillAppear()
        _mapView.delegate = self
        districtSearch.delegate = self
        requestDistrictSearch()
        
        socket.connect()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        _mapView.viewWillDisappear()
        _mapView.delegate = nil
        districtSearch.delegate = nil
        
        socket.disconnect()
    }
    //发起请求
    func requestDistrictSearch() {
        let option = BMKDistrictSearchOption()
        option.city = "深圳"
        option.district = "南山"
        let flag = districtSearch.districtSearch(option)
        if flag {
            print("district检索发送成功")
        } else {
            print("district检索发送失败")
        }
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    // MARK: - BMKDistrictSearchDelegate
    /**
     *返回行政区域搜索结果
     *@param searcher 搜索对象
     *@param result 搜索结BMKDistrictSearch果
     *@param error 错误号，@see BMKSearchErrorCode
     */
    func onGetDistrictResult(_ searcher: BMKDistrictSearch!, result: BMKDistrictResult!, errorCode error: BMKSearchErrorCode) {
        
        print("onGetDistrictResult error: \(error)")
        if error == BMK_SEARCH_NO_ERROR {
            print("\nname:\(result.name)\ncode:\(result.code)\ncenter latlon:\(result.center.latitude),\(result.center.longitude)");
            
            self._mapView.removeOverlays(_mapView.overlays)
            var flag = true
            for path in result.paths {
                let polygon = transferPathStringToPolygon(path as! String)
                if (polygon != nil) {
                    _mapView.add(polygon) // 添加overlay
                    if flag {
                        mapViewFitPolygon(polygon)
                        flag = false
                    }
                }
            }
        }
    }
    
    // MARK: - BMKMapViewDelegate
    /**
     *根据overlay生成对应的View
     *@param mapView 地图View
     *@param overlay 指定的overlay
     *@return 生成的覆盖物View
     */
    func mapView(_ mapView: BMKMapView!, viewFor overlay: BMKOverlay!) -> BMKOverlayView! {
        if (overlay as? BMKPolygon) != nil {
            let polygonView = BMKPolygonView(overlay: overlay)
            polygonView?.strokeColor = UIColor(red: 1, green: 0, blue: 0, alpha: 0.6)
            polygonView?.fillColor = UIColor(red: 1, green: 1, blue: 0, alpha: 0.4)
            polygonView?.lineWidth = 1
            polygonView?.lineDash = true
            return polygonView
        }
        return nil
    }
    
    
    // MARK: -
    //根据polygon设置地图范围
    func mapViewFitPolygon(_ polygon: BMKPolygon!) {
        if polygon.pointCount < 1 {
            return
        }
        
        let pt = polygon.points[0]
        var ltX = pt.x
        var rbX = pt.x
        var ltY = pt.y
        var rbY = pt.y
        
        for i in 1..<polygon.pointCount {
            let pt = polygon.points[Int(i)]
            if pt.x < ltX {
                ltX = pt.x
            }
            if pt.x > rbX {
                rbX = pt.x
            }
            if pt.y > ltY {
                ltY = pt.y
            }
            if pt.y < rbY {
                rbY = pt.y
            }
        }
        
        let rect = BMKMapRectMake(ltX, ltY, rbX - ltX, rbY - ltY)
        _mapView.visibleMapRect = rect
        _mapView.zoomLevel = _mapView.zoomLevel - 0.3
    }
    
    //根据path string 生成 BMKPolygon
    func transferPathStringToPolygon(_ path: String) -> BMKPolygon? {
        let pts = path.components(separatedBy: ";")
        if  pts.count < 1 {
            return nil
        }
        
        var points = Array(repeating: BMKMapPoint(x: 0, y: 0), count: pts.count)
        var index = 0
        for ptStr in pts {
            let range = ptStr.range(of: ",")
            let xStr = ptStr.substring(to: (range?.lowerBound)!)
            let yStr = ptStr.substring(from: (range?.upperBound)!)
            if xStr.characters.count > 0 && yStr.characters.count > 0  {
                points[index] = BMKMapPointMake(Double(xStr)!, Double(yStr)!)
                index += 1
            }
        }
        var polygon: BMKPolygon? = nil
        if index > 0 {
            polygon = BMKPolygon(points: &points, count: UInt(index))
        }
        return polygon
    }


}
