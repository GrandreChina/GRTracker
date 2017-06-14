//
//  2ViewController.swift
//  GRTracker
//
//  Created by Grandre on 17/4/18.
//  Copyright © 2017年 革码者. All rights reserved.
//

import UIKit

class twoViewController: UIViewController,BMKMapViewDelegate {

    var _mapView:BMKMapView!
    var _bounds:CGFloat!
    var pointArr:[CLLocationCoordinate2D]!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.initReadJsonData()
        self.initMapView()
        self.route()
        self.view.backgroundColor = UIColor.white
        
    }

    func route(){

        _mapView.removeAnnotations(_mapView.annotations)
        _mapView.removeOverlays(_mapView.overlays)
        

        let polyLine = BMKPolyline(coordinates: &pointArr!, count: UInt(pointArr.count))
        
        // 添加路线 overlay
        _mapView.add(polyLine)
        //根据polyline设置地图范围
        mapViewFitPolyLine(polyLine)
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        _mapView.viewWillAppear()
        _mapView.delegate = self

     
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        _mapView.viewWillDisappear()
        print("----view will disappear")
        _mapView.delegate = nil

    }
  
    init(Bounds bounds:CGFloat = 400){
        self._bounds = bounds
        super.init(nibName: nil, bundle: nil)
       
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    func initMapView(){
        //添加地图视图
        
        _mapView = BMKMapView(frame: CGRect(x: 0, y: 10, width: self.view.frame.width, height: self._bounds  - 20))
        
        let center = CLLocationCoordinate2D(latitude: (pointArr.first?.latitude)!, longitude: (pointArr.first?.longitude)!)
        
        _mapView?.setCenter(center, animated: true)
        _mapView?.zoomLevel = 15
        self.view.addSubview(_mapView!)
        
      
        
    }
    func initReadJsonData(){
        do{
            let json = try JSONSerialization.jsonObject(with: NSData(contentsOf: NSURL(fileURLWithPath: Bundle.main.path(forResource: "gps", ofType: "json")!) as URL )! as Data, options: JSONSerialization.ReadingOptions())
            
            
            if let lang: NSArray = (json as! NSDictionary).object(forKey: "root") as! NSArray?{
               
               
                self.pointArr = Array(repeating:CLLocationCoordinate2D(latitude: 0, longitude: 0), count: lang.count)
          
                for i in 0..<lang.count{
                    
                    let lat = (lang[i] as! NSDictionary).value(forKey: "lat") as! Double
                    let lng = (lang[i] as! NSDictionary).value(forKey: "lng") as! Double

                    let coor = CLLocationCoordinate2DMake(lat, lng);//原始坐标
                    //转换非WGS84坐标至百度坐标(加密后的坐标)
                    let testdic = BMKConvertBaiduCoorFrom(coor,BMK_COORDTYPE_COMMON);
                    let baiduCoor:CLLocationCoordinate2D = BMKCoorDictionaryDecode(testdic);//转换后的百度坐标
                    self.pointArr[i] = baiduCoor
                }
               
             
              
            }
        }catch{
            print(error)
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /**
     *根据overlay生成对应的View
     *@param mapView 地图View
     *@param overlay 指定的overlay
     *@return 生成的覆盖物View
     */
    func mapView(_ mapView: BMKMapView!, viewFor overlay: BMKOverlay!) -> BMKOverlayView! {
        if overlay as! BMKPolyline? != nil {
            
            let polylineView = BMKPolylineView(overlay: overlay as! BMKPolyline)
//            polylineView?.strokeColor = UIColor(red: 0, green: 0, blue: 1, alpha: 0.7)
            polylineView?.strokeColor = UIColor.green
            polylineView?.lineWidth = 3
            return polylineView
        }
        return nil
    }
    

    //根据polyline设置地图范围
    func mapViewFitPolyLine(_ polyline: BMKPolyline!) {
        if polyline.pointCount < 1 {
            return
        }
        
        let pt = polyline.points[0]
        var ltX = pt.x
        var rbX = pt.x
        var ltY = pt.y
        var rbY = pt.y
        
        for i in 1..<polyline.pointCount {
            let pt = polyline.points[Int(i)]
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

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
