//
//  InfoViewController.swift
//  GRTracker
//
//  Created by Grandre on 2017/5/26.
//  Copyright © 2017年 革码者. All rights reserved.
//

import UIKit
import SwiftyJSON
class InfoViewController: UIViewController,BMKMapViewDelegate,UIGestureRecognizerDelegate {

    var infoDetailV:InfoDetailView!
   
    var _mapView:BMKMapView!
    var annotation:BMKPointAnnotation!
  
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.blue
        self.initInfoDetailView()
        self.initMapView()
        
        //KVO deinit时得注销
        self.annotation.addObserver(self, forKeyPath: "coordinate", options: .new, context: nil)
    
        
        NotificationCenter.default.addObserver(self, selector: #selector(self.SpeedRefleshFromWS(ns:)), name: NSNotification.Name(rawValue: "SpeedRefleshFromWS"), object: nil)
    }
    
    func SpeedRefleshFromWS(ns:Notification){
        print("---GR---WS Speed---come in---")
        let value = ns.userInfo?["SpeedRefleshFromWS"] as! Double
        self.infoDetailV.speed.text = "\(value)"
  
    }
    
    //KVO delegate
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        if keyPath == "coordinate"{
            
            self._mapView.setCenter(self.annotation.coordinate, animated: true)
        }
    }
    
    init(){
        super.init(nibName: nil, bundle: nil)
        self.infoDetailV = UINib(nibName: "InfoDetailView", bundle: nil).instantiate(withOwner: self, options: nil).last as! InfoDetailView
       self.annotation = BMKPointAnnotation()
  
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    func initInfoDetailView(){
        self.infoDetailV.frame = CGRect(x: 0, y:0, width: ScreenWidth, height: 250)
        self.view.addSubview(infoDetailV)
    }
    
    func initMapView(){
        //添加地图视图
        _mapView = BMKMapView()
        _mapView.isScrollEnabled = true
        self.view.addSubview(_mapView!)
        self._mapView.snp.makeConstraints { (make) in
            make.left.right.bottom.equalTo(self.view)
            make.top.equalTo(infoDetailV.snp.bottom)
        }
        
        self._mapView.setCenter(annotation.coordinate, animated: true)
        self._mapView?.zoomLevel = 15
        self._mapView.delegate = self
        self._mapView.addAnnotation(self.annotation)
 
    }
    
    func mapView(_ mapView: BMKMapView!, viewFor annotation: BMKAnnotation!) -> BMKAnnotationView! {
        //普通标注
//        print("----绘制静态----annotation")
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

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        print("----GR--InfoViewController--viewWillAppear----")
        _mapView.viewWillAppear()
        _mapView.delegate = self

    }
    
    override func viewWillDisappear(_ animated: Bool) {
        print("----GR--InfoViewController--viewWillDisappear--")
        _mapView.viewWillDisappear()
        _mapView.delegate = nil

    }
    deinit {
        self.annotation.removeObserver(self, forKeyPath: "coordinate")
        NotificationCenter.default.removeObserver(self)
        print("------GR---InfoViewController--deinit---")
    }
}
