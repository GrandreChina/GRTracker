//
//  userImage_NameCell.swift
//  GoBook
//
//  Created by Grandre on 16/5/26.
//  Copyright © 2016年 革码者. All rights reserved.
//

import UIKit

class userImage_NameCell: UITableViewCell {
    var logoImageView:UIImageView?
    var showName:UILabel?
    var userName:UILabel?
    var touXiang:UIImage?
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        for view in self.contentView.subviews{
            view.removeFromSuperview()
        }
        
            
        
        self.logoImageView = UIImageView(frame: CGRect(x: 10, y: 5, width: 80, height: 80))
//        self.logoImageView?.image = UIImage(named: "Avatar")
        self.logoImageView?.layer.cornerRadius  = 10
        self.logoImageView?.layer.masksToBounds = true
        self.addSubview(self.logoImageView!)
        
        self.showName = UILabel(frame: CGRect(x:100,y:15,width:ScreenWidth-100-10,height:35))
        self.showName?.text = "昵称:" + "Grandre"
//        self.showName?.font = UIFont(name: MY_FONT, size: 20)
        self.showName?.textColor = UIColor.black
        self.addSubview(self.showName!)
        
        self.userName = UILabel(frame: CGRect(x:100,y:50,width:ScreenWidth-100-10,height:25))
        self.userName?.text = "用户名:" + "Grandre"
//        self.userName?.font = UIFont(name: MY_FONT, size: 15)
        self.userName?.textColor = UIColor(red: 0.3678, green: 0.5085, blue: 0.8855, alpha: 1.0)
        self.addSubview(self.userName!)
        

    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
