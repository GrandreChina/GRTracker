//
//  FenceTableViewCell.swift
//  GRTracker
//
//  Created by Grandre on 2017/6/12.
//  Copyright © 2017年 革码者. All rights reserved.
//

import UIKit

class FenceTableViewCell: UITableViewCell {

    @IBOutlet weak var FenceName: GRLabel!
    
    @IBOutlet weak var stratTime: UILabel!
    @IBOutlet weak var endTime: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
