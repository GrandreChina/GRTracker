//
//  GeoFanCode.swift
//  GRTracker
//
//  Created by Grandre on 2017/5/10.
//  Copyright © 2017年 革码者. All rights reserved.
//

import UIKit

class GeoFanCode: NSObject,BMKGeoCodeSearchDelegate {
    
    
   static var geocodeSearch: BMKGeoCodeSearch!
    
   static func getAddressFromLngLat(lng:Double,lat:Double,vc:BMKGeoCodeSearchDelegate){
    geocodeSearch = BMKGeoCodeSearch()
    geocodeSearch.delegate = vc
  
    let coor = CLLocationCoordinate2DMake(lat, lng);//原始坐标
    //转换非WGS84坐标至百度坐标(加密后的坐标)
    let testdic = BMKConvertBaiduCoorFrom(coor,BMK_COORDTYPE_COMMON);
    let baiduCoor:CLLocationCoordinate2D = BMKCoorDictionaryDecode(testdic);//转换后的百度坐标

    let reverseGeocodeSearchOption = BMKReverseGeoCodeOption()
    reverseGeocodeSearchOption.reverseGeoPoint = baiduCoor
        
    let flag = geocodeSearch.reverseGeoCode(reverseGeocodeSearchOption)
    if flag {
        print("反geo 检索发送成功")
    } else {
        print("反geo 检索发送失败")
    }
    
  
    }

    
   

}
