//
//  GRDeviceData.swift
//  GRTracker
//
//  Created by Grandre on 2017/5/24.
//  Copyright © 2017年 革码者. All rights reserved.
//

import UIKit
import SwiftyJSON
struct GRDeviceData {
    var annotation:BMKPointAnnotation!
    var alarmState:Int!
    var speed:Double!
    var ID:Int64!
    var powerConsumperType:String!
    var deviceName:String!
    var serialNumber:String!
    var batteryCapcity:Float!
    var groupName:String!
    
    var gpsWorkModeType:String!
    var bleWorkModeType:String!
    var wifiWorkMode:String!
    var baseStationScanWorkMode:String!
}
