//
//  InfoDetailView.swift
//  GRTracker
//
//  Created by Grandre on 2017/5/27.
//  Copyright © 2017年 革码者. All rights reserved.
//

import UIKit

class InfoDetailView: UIView {

    @IBOutlet weak var deviceName: UIButton!
    @IBOutlet weak var groupName: UILabel!
    @IBOutlet weak var serialNumber: UIButton!
    @IBOutlet weak var batteryCapcity: UILabel!
    
    @IBOutlet weak var speed: UILabel!
 
    @IBOutlet weak var powerConsumperType: UILabel!
    
    
    
    @IBOutlet weak var GPSLabel: GRLabel!
    @IBOutlet weak var BlueLabel: GRLabel!
    @IBOutlet weak var WIFILabel: GRLabel!
    @IBOutlet weak var BaseStationLabel: GRLabel!
    @IBAction func history(_ sender: Any) {
        
        print("---点击了历史轨迹---")
    }
    
    
    override func awakeFromNib() {

    }
}
