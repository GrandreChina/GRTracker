//
//  MonitorViewController.swift
//  GRTracker
//
//  Created by Grandre on 17/4/14.
//  Copyright © 2017年 革码者. All rights reserved.
//

import UIKit
import SVProgressHUD
//import Starscream//webSocket
import SwiftyJSON
//import Alamofire
class MonitorViewController: UIViewController,BMKMapViewDelegate,topBtnCollectViewDelegate{

    var _mapView:BMKMapView!
    var topBtnCollectV:topBtnCollectView!
    var deviceArr:[JSON]! = []{//原始数据
        didSet{
            self.showAnnotation()
        }
    }
    //一定要给字典设置一个初始值，才能添加或者更新元素！
//    var deviceDictionary:[String:(Double,Double)]! = [:]//未用
    var deviceDictionary2:[String:GRDeviceData]! = [:]
    
    var afterFliterYuanZu:[(String,GRDeviceData)] = []
    override func viewDidLoad() {
        super.viewDidLoad()
        print("----GR---viewDidLoad---")
        
        self.initUI()
        self.initMapView()
        self.initLeftBarItem()
        self.initWebSoctket()
        self.initTopBtnCollectV()

    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        print(" ----GR-----viewwill Appear")
        self.tabBarController?.tabBar.isHidden = false
        _mapView.viewWillAppear()
        _mapView.delegate = self
        showingMonitorVC = true
       
        //获取到原始数据之后，在deviceArr的属性观察者里面显示annotations。
        self.alamofireGetData()
        
        //可以放到deviceArr的属性观察者里面
        NetWork.socket.connect()
        
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        _mapView.viewWillDisappear()
        _mapView.delegate = nil
        showingMonitorVC = false
        print(" ----GR-----viewwill disAppear")
//        socket.disconnect()
        NetWork.socket.disconnect()
        
        
        
    }
    /*---{
    "Lat" : "22.54663733",
    "SatSysName" : "GPS",
    "Diff" : "0",
    "Lng" : "113.93645717",
    "Alt" : "15.0",
    "ProductSN" : "32363938323651800320040",
    "wsMsgType" : "gps",
    "RunningNumber" : "547",
    "TimeStamp" : "2017-05-25T09:58:17",
    "BatteryCapacity" : "0.75",
    "Speed" : "100.5",
    "Direction" : "0.45"
    }---*/
    
    //MARK: - NSNOTIFICATION
    func webSocketGetText(notification: NSNotification){
        print("----GR----从webSocket获取到数据----")
        let text = notification.userInfo?["data"] as! JSON
        print("---\(text)---")
//        如果有新数据增加，则重新刷新最上层数据源，再重新显示
        if  deviceDictionary2[text["ProductSN"].stringValue] == nil{
            print("----GR----有新数据增加---")
            SVProgressHUD.setMaximumDismissTimeInterval(0.8)
            SVProgressHUD.setDefaultStyle(.dark)
            SVProgressHUD.show(nil, status: "有新设备添加")
            self.alamofireGetData()
        }
        
        var GRstruct:GRDeviceData!
            
        if let grStruct = deviceDictionary2[text["ProductSN"].stringValue] {
            GRstruct = grStruct
        }else{
            print("---GR---ws数据之前，原始数据还没准备好---")
            return
        }
        
        GRstruct.annotation.coordinate =  CLLocationCoordinate2D(latitude: text["Lat"].doubleValue , longitude: text["Lng"].doubleValue)
      
    
        GRstruct.speed = text["Speed"].doubleValue + Double(arc4random()%4)
        
        
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: "SpeedRefleshFromWS"), object: nil, userInfo: ["SpeedRefleshFromWS":GRstruct.speed])
        
        print("-----GR---获取\(GRstruct.speed)----")
        
        
        
    }
    //MARK: -
    func initLeftBarItem(){
        let btn = UIBarButtonItem(title: "全部", style: .plain, target: self, action: #selector(self.alamofireGetData))
        self.navigationItem.setLeftBarButton(btn, animated: true)
        self.navigationItem.leftBarButtonItem?.setTitleTextAttributes([NSForegroundColorAttributeName:UIColor.white,NSFontAttributeName: UIFont(name: "Chalkduster", size: 17)!], for: UIControlState())
        
        
    }

    func initWebSoctket(){
//        socket = WebSocket(url: URL(string: "ws://\(IPWS_API)/ugV9X6BQdSk4tR8CiC+/eEVhjx+n99F7bh+RyXsGZPp9ht3hX6cMos/As1grIThE")!)
//        //websocketDidConnect
//        socket.onConnect = {
//            print("--GR--websocket is connected")
//        }
//        //websocketDidDisconnect
//        socket.onDisconnect = { (error: NSError?) in
//            print("--GR--websocket is disconnected: \(String(describing: error?.localizedDescription))")
//        }
//        //websocketDidReceiveMessage
//        socket.onText = { (text: String) in
////            print("--GR--got some text: \(text)")
//            //将string格式转换成json格式
//            let object =  JSON(parseJSON: text)
//            print(object)
//        }
//        //websocketDidReceiveData
//        socket.onData = { (data: Data) in
//            print("--GR--got some data: \(data.count)")
//            print("--GR--got data\(data.description)")
//        }
        //you could do onPong as well.
//        socket.connect()
        
        NetWork.initWS()
        
    }
    func initTopBtnCollectV(){
        topBtnCollectV = topBtnCollectView(frame: CGRect(x: 0, y:75 , width: ScreenWidth, height: 40))
        topBtnCollectV.delegate = self
        self.view.addSubview(topBtnCollectV)
    }
    func initUI(){
        self.title = "监控与跟踪"
        self.navigationController?.navigationBar.barTintColor = MAIN_RED
        NotificationCenter.default.addObserver(self, selector: #selector(self.webSocketGetText(notification:)), name: NSNotification.Name(rawValue: "WebSocketGetText"), object: nil)
        

    }
    func initMapView(){
        //添加地图视图
        _mapView = BMKMapView()
        self.view.addSubview(_mapView!)
        self._mapView.snp.makeConstraints { (make) in
            make.left.right.bottom.equalTo(self.view)
            make.top.equalTo(self.view)
            
        }
        let center = CLLocationCoordinate2D(latitude: 22.5496810319308, longitude: 113.947821886454)

        self._mapView?.setCenter(center, animated: true)
        self._mapView?.zoomLevel = 15
        
    }
    //MARK: - Alamofire Get Data
    func alamofireGetData(){
        print("获取数据")
     NetWork.getAllDeviceData { (jsonArr) in
        self.deviceArr = jsonArr
        }
  
    }
    func convertArrToDic(){
        for d in self.deviceArr{
            let coor = CLLocationCoordinate2DMake(d["lat"].double!, d["lng"].double!);//原始坐标
            //转换非WGS84坐标至百度坐标(加密后的坐标)
            let testdic = BMKConvertBaiduCoorFrom(coor,BMK_COORDTYPE_GPS);
            let baiduCoor:CLLocationCoordinate2D = BMKCoorDictionaryDecode(testdic);//转换后的百度坐标
            let tempAnnotation = BMKPointAnnotation()
            tempAnnotation.coordinate = baiduCoor
            tempAnnotation.title = "点击查看/设置"
            tempAnnotation.subtitle = d["serialNumber"].stringValue
            
            
            var deviceInfoStruct:GRDeviceData = GRDeviceData()
            deviceInfoStruct.annotation = tempAnnotation
            deviceInfoStruct.alarmState = d["state"].int == nil ? 0 :  d["state"].int
            
            deviceInfoStruct.speed = d["speed"].doubleValue


                
            
            deviceInfoStruct.ID = d["id"].int64
    
            deviceInfoStruct.deviceName = d["deviceName"].stringValue
            deviceInfoStruct.serialNumber = d["serialNumber"].stringValue
            deviceInfoStruct.batteryCapcity = d["batteryCapcity"].floatValue
            deviceInfoStruct.groupName = d["groupName"].stringValue
            deviceInfoStruct.powerConsumperType = d["powerConsumperType"].stringValue

            deviceInfoStruct.gpsWorkModeType = d["gpsWorkModeType"].stringValue
            deviceInfoStruct.bleWorkModeType = d["bleWorkModeType"].stringValue
            deviceInfoStruct.wifiWorkMode = d["wifiWorkMode"].stringValue
            deviceInfoStruct.baseStationScanWorkMode = d["baseStationScanWorkMode"].stringValue

            //        self.deviceDictionary.updateValue((d["lng"].double!,d["lat"].double!), forKey: d["serialNumber"].stringValue)
            
            self.deviceDictionary2.updateValue(deviceInfoStruct, forKey: d["serialNumber"].stringValue)
            
        }
        
//        print(self.deviceDictionary2)
    }
    
    func showAnnotation(){
        
        self.convertArrToDic()
     
        //字典values值的提取方法！
        let d = [GRDeviceData](self.deviceDictionary2.values)
        let annotations = d.map { (datastruct) -> BMKPointAnnotation in
            return datastruct.annotation
        }
        
        self._mapView.removeAnnotations(_mapView.annotations)
        self._mapView.addAnnotations(annotations)
        
        self.mapViewFitAnnotations(annotations)
        
//    统计筛选，更新四个btn的值
        fliterOnLine()
        
    }
    
    func fliterOnLine(){
//        这里fliter之后数据结构变成元组类型的数组，更方便！
        self.afterFliterYuanZu = self.deviceDictionary2.filter { (d:(key: String, value: GRDeviceData)) -> Bool in
            d.value.ID == 9
        }
        
        self.topBtnCollectV.onLineBtn.setTitle("\(self.afterFliterYuanZu.count)", for: .normal)
        
    }
    
    // MARK: - BMKMapViewDelegate
    
    /**
     *地图初始化完毕时会调用此接口
     *@param mapview 地图View
     */
    func mapViewDidFinishLoading(_ mapView: BMKMapView!) {

    }
    /**
     *当mapView新添加annotation views时，调用此接口
     *@param mapView 地图View
     *@param views 新添加的annotation views
     */
    func mapView(_ mapView: BMKMapView!, didAddAnnotationViews views: [Any]!) {
//        NSLog("didAddAnnotationViews")
    }
    /**
     *当选中一个annotation views时，调用此接口
     *@param mapView 地图View
     *@param views 选中的annotation views
     */
    func mapView(_ mapView: BMKMapView!, didSelect view: BMKAnnotationView!) {
        print("选中了标注")
        let center = view.annotation.coordinate

        self._mapView?.setCenter(center, animated: true)
        
//        let p = self._mapView.convert(center, toPointTo: self.view)
//        print("---GR--\(p)----")
        
    }
    

    /**
     *当取消选中一个annotation views时，调用此接口
     *@param mapView 地图View
     *@param views 取消选中的annotation views
     */
    func mapView(_ mapView: BMKMapView!, didDeselect view: BMKAnnotationView!) {
        NSLog("取消选中标注")
    }
    
    /**
     *拖动annotation view时，若view的状态发生变化，会调用此函数。ios3.2以后支持
     *@param mapView 地图View
     *@param view annotation view
     *@param newState 新状态
     *@param oldState 旧状态
     */
    func mapView(_ mapView: BMKMapView!, annotationView view: BMKAnnotationView!, didChangeDragState newState: UInt, fromOldState oldState: UInt) {
        NSLog("annotation view state change : \(oldState) : \(newState)")
        
        
        ///后期要关闭拖动annotation功能
    }
    

    /**
     *当点击annotation view弹出的泡泡时，调用此接口
     *@param mapView 地图View
     *@param view 泡泡所属的annotation view
     */
    func mapView(_ mapView: BMKMapView!, annotationViewForBubble view: BMKAnnotationView!) {
        NSLog("点击了泡泡")
        let vc = InfoAndSettingViewController()
        vc.infoVC.annotation = view.annotation as! BMKPointAnnotation
        vc.infoVC.annotation.title = ""
        //通过annotation的subtitle去找回原来对应的结构体
        let tempGRStruct = self.deviceDictionary2[(view.annotation as! BMKPointAnnotation).subtitle]
        vc.infoVC.infoDetailV.deviceName.setTitle(tempGRStruct?.deviceName, for: .normal)
        vc.infoVC.infoDetailV.serialNumber.setTitle(tempGRStruct?.serialNumber, for: .normal)
        vc.infoVC.infoDetailV.batteryCapcity.text = String(describing: Int8((tempGRStruct?.batteryCapcity)! * 100))        
        vc.infoVC.infoDetailV.groupName.text = tempGRStruct?.groupName

     
        
        
        var str:String = ""
        switch tempGRStruct!.powerConsumperType{
        case "0":
            str = "deepsleep模式"
        case "1":
            str = "standby模式"
        case "2":
            str = "智能工作模式"
        case "3":
            str = "用户自定义模式"
        default:
            str = ""
            
        }
        vc.infoVC.infoDetailV.powerConsumperType.text = str
        
        
        if (tempGRStruct!.powerConsumperType != "3"){
            vc.infoVC.infoDetailV.GPSLabel.setOffline()
            vc.infoVC.infoDetailV.BlueLabel.setOffline()
            vc.infoVC.infoDetailV.WIFILabel.setOffline()
            vc.infoVC.infoDetailV.BaseStationLabel.setOffline()
        }else{
        
            if(tempGRStruct?.gpsWorkModeType! == "0"){
                vc.infoVC.infoDetailV.GPSLabel.setOffline()
                
            }
            if(tempGRStruct?.bleWorkModeType! == "0"){
                vc.infoVC.infoDetailV.BlueLabel.setOffline()
                
            }
            if(tempGRStruct?.wifiWorkMode! == "0"){
                vc.infoVC.infoDetailV.WIFILabel.setOffline()
            }
            if(tempGRStruct?.baseStationScanWorkMode! == "0"){
                vc.infoVC.infoDetailV.BaseStationLabel.setOffline()
            }
        
        }
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    func mapView(_ mapView: BMKMapView!, viewFor annotation: BMKAnnotation!) -> BMKAnnotationView! {
        //普通标注
//            print("----绘制静态----annotation")
            let AnnotationViewID = "renameMark"
            var annotationView = mapView.dequeueReusableAnnotationView(withIdentifier: AnnotationViewID)
            if annotationView == nil {
                annotationView = BMKAnnotationView(annotation: annotation, reuseIdentifier: AnnotationViewID)
                annotationView?.centerOffset = CGPoint(x: 0, y: -(annotationView!.frame.size.height * 0.5))
                annotationView?.canShowCallout = true
                // 设置可拖曳,要长按标注之后才能拖拽！！！
                annotationView?.isDraggable = true
                annotationView?.bounds = CGRect(x: 0, y: 0, width: 60, height: 60)
                annotationView?.contentMode = .scaleAspectFill

            }
            annotationView?.annotation = annotation
        
     
        let bundlePath = (Bundle.main.resourcePath)! + "/mapapi.bundle/"
        let bundle = Bundle(path: bundlePath)
        var tmpBundle : String?
        tmpBundle = (bundle?.resourcePath)! + "/images/pin_green.png"
        if let imagePath =  tmpBundle{
            if let image = UIImage(contentsOfFile: imagePath){
                annotationView?.image = image
            }
            
        }else{
            print("---GR---not found image---")
        }
    
            return annotationView
   
    }
    

    // MARK: - GR原创
    //根据annotations设置地图范围
    func mapViewFitAnnotations(_ pointArr: [BMKPointAnnotation]!) {
        if pointArr.count < 1 {
            return
        }
//      map的酸爽用法
        let mapPointArr =  pointArr.map { (i) -> BMKMapPoint in
        BMKMapPointForCoordinate(i.coordinate)
        }

        let pt = mapPointArr[0]
        var ltX = pt.x
        var rbX = pt.x
        var ltY = pt.y
        var rbY = pt.y
        
        for i in 1..<mapPointArr.count {
            let pt = mapPointArr[Int(i)]
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
    //MARK: - btn Delegate
    func topBtnCollectViewTouch(_ sender:UIButton){
        print(sender.tag)
        switch sender.tag {
        case 1:
            self._mapView.removeAnnotations(_mapView.annotations)
            let arr = self.afterFliterYuanZu.map({ (d:(str:String,structdata:GRDeviceData)) -> BMKPointAnnotation in
                d.1.annotation
            })
            self._mapView.addAnnotations(arr)
            self.mapViewFitAnnotations(arr)
        case 2:
            NetWork.socket.disconnect()
            NetWork.socket.connect()
            break
        case 3:
            
            let vc = InfoAndSettingViewController()
            self.navigationController?.pushViewController(vc, animated: true)
            break
        default:
            break
        }
        
        
    }
    
    //MARK:
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
     
    }
    deinit {
       NotificationCenter.default.removeObserver(self)
        print("---GR--MonitorVc 退出了---")
    }

}
