//
//  FenceTableView.swift
//  GRTracker
//
//  Created by Grandre on 2017/6/9.
//  Copyright © 2017年 革码者. All rights reserved.
//

import UIKit
import SnapKit
import SwiftyJSON
@objc protocol FenceTableViewBtnTapDelegate {
    @objc optional func cancleFromFenceTableView()
    @objc optional func sureFromFenceTableView()//optional 加上修饰符之后，则可选实现方法
    
    func fenceTabledidSelectRowForCell(row:Int)
}
class FenceTableView: UIView,UITableViewDelegate,UITableViewDataSource {

    var tableView:UITableView!
    
    var cancleBtn:UIButton!
    var sureBtn:UIButton!
    var dataArr:[JSON]! = []{
        didSet{
            self.tableView.reloadData()
        }
    }
    weak var delegate:FenceTableViewBtnTapDelegate!
    override init(frame: CGRect) {
        super.init(frame: frame)
        tableView = UITableView(frame: CGRect(x: 0, y: 0, width: self.frame.width, height: self.frame.height - 60))
        tableView.backgroundColor = #colorLiteral(red: 0.7569724917, green: 0.9961271882, blue: 1, alpha: 1).withAlphaComponent(0.4)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.tableFooterView = UIView()
        tableView.register( UINib(nibName: "FenceTableViewCell", bundle: Bundle.main), forCellReuseIdentifier: "FenceTableViewCell")
        
        self.addSubview(tableView)
        
        cancleBtn = UIButton()
        cancleBtn.setTitle("取消", for: .normal)
        cancleBtn.backgroundColor = #colorLiteral(red: 0.8860237598, green: 0.881954968, blue: 0.7399513125, alpha: 1)
        cancleBtn.addTarget(self, action: #selector(self.cancleBtnTap), for: .touchUpInside)
        
        self.addSubview(cancleBtn)
        cancleBtn.snp.makeConstraints { (make) in
            make.left.bottom.equalToSuperview()
            make.top.equalTo(self.tableView.snp.bottom)
            make.width.equalTo(ScreenWidth/2)
        }
       
        sureBtn = UIButton()
        sureBtn.setTitle("确定", for: .normal)
        sureBtn.backgroundColor = #colorLiteral(red: 0.36, green: 0.79, blue: 0.96, alpha: 1)
        sureBtn.addTarget(self, action: #selector(self.sureBtnTap), for: .touchUpInside)
        self.addSubview(sureBtn)
        sureBtn.snp.makeConstraints { (make) in
            make.top.equalTo(self.tableView.snp.bottom)
            make.right.bottom.equalToSuperview()
            make.width.equalTo(ScreenWidth/2)
        }
    }
    
    func cancleBtnTap(){
        self.delegate.cancleFromFenceTableView!()
    }
    func sureBtnTap(){
        self.delegate.sureFromFenceTableView!()
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
//    {
//    "geometry" : "{\"type\":\"Feature\",\"geometry\":{\"type\":\"Polygon\",\"coordinates\":[[[114.08120054193259,22.50215272824173],[114.12926572747946,22.497002886933135],[114.14917844720603,22.478463458222198],[114.14540189691306,22.46164064328079],[114.11690610833884,22.453057574433135],[114.08360380120993,22.454087542694854],[114.06437772699118,22.46370057980423],[114.08120054193259,22.50215272824173]]]},\"properties\":null}",
//    "name" : "test",
//    "id" : 38,
//    "warningType" : 0,
//    "terminalsId" : "0",
//    "userId" : 1,
//    "endTime" : "Jun 8, 2017 7:00:00 AM",
//    "durationType" : 2,
//    "startTime" : "Jun 6, 2017 6:00:00 AM",
//    "deleteStatus" : 0
//    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.dataArr.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "FenceTableViewCell", for: indexPath) as! FenceTableViewCell
  
        cell.FenceName.text = self.dataArr[indexPath.row]["name"].stringValue
        cell.stratTime.text = self.dataArr[indexPath.row]["startTime"].stringValue
        cell.endTime.text   = self.dataArr[indexPath.row]["endTime"].stringValue
        cell.backgroundColor = UIColor.clear
        cell.selectionStyle = .none
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.delegate.fenceTabledidSelectRowForCell(row: indexPath.row)
        
    }
    deinit {
        print("---GR---FenceTableView--deinit---")
    }
}
