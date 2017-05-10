//
//  deviceInfoCell.swift
//  GRTracker
//
//  Created by Grandre on 2017/5/9.
//  Copyright © 2017年 革码者. All rights reserved.
//

import UIKit

class deviceInfoCell: UITableViewCell {

    @IBOutlet weak var deviceName: UILabel!
    
    @IBOutlet weak var deviceID: UILabel!

    @IBOutlet weak var groupName: UILabel!
    
    @IBOutlet weak var batteryCapcity: UILabel!
    
    @IBOutlet weak var lng: UILabel!
    @IBOutlet weak var lat: UILabel!
    
    @IBOutlet weak var address: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
