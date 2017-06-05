//
//  Three3ViewController.swift
//  GRTracker
//
//  Created by Grandre on 2017/5/27.
//  Copyright © 2017年 革码者. All rights reserved.
//

import UIKit
class SettingDeviceTableVC: UIViewController,UITableViewDataSource,UITableViewDelegate{
    

    var _tableView:UITableView!
    var workModeArr:Array = ["DeepSleep Mode","StandByMode","智能工作模式","用户自定义模式"]
    
//    var DataSourceArr:[String]! = []
    var realSeclectionArr:[String]! = []
    override func viewDidLoad() {
        super.viewDidLoad()
        self.initUI()
        self.initTableView()
        

    }

    func initUI(){
        self.navigationItem.setLeftBarButton(UIBarButtonItem(title: "<", style: .plain, target: self, action: #selector(self.backBtnPress)) , animated: true)
        
        self.navigationItem.leftBarButtonItem?.setTitleTextAttributes([NSForegroundColorAttributeName:UIColor.blue,NSFontAttributeName: UIFont(name: "Chalkduster", size: 20)!], for: UIControlState.normal)
        self.view.backgroundColor = UIColor.white
    }
    func initTableView(){
        _tableView = UITableView(frame: self.view.bounds, style: .grouped)
        _tableView.delegate = self
        _tableView.dataSource = self
        _tableView.tableFooterView = UIView()
        
        self.view.addSubview(_tableView)
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        switch section{
        case 0:
            return 10
        case 1:
            return 5
        default:
            return 5
            
        }
    }
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
   
        return 0.1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section{
        case 0:
            return self.workModeArr.count
        case 1:
            return 1
        default:
            return 0
            
        }
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        var cell = tableView.dequeueReusableCell(withIdentifier: "cell")
        if cell == nil{
            cell = UITableViewCell(style: .value1, reuseIdentifier: "cell")
        }
        cell?.textLabel?.text = workModeArr[indexPath.row]
        
        if (indexPath.row == 3){
            cell?.accessoryType = .disclosureIndicator
        }else{
           cell?.accessoryType = .checkmark
        }
        
        cell?.selectionStyle = .none
        return cell!
    }

    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {

        if (indexPath.row != 3){
            let cell = tableView.cellForRow(at: indexPath)
            if cell?.accessoryType != .checkmark{
                cell?.accessoryType = .checkmark
              
            }else{
                cell?.accessoryType = .none
            }
        }else if (indexPath.row == 3){
            let vc = UserDefineModeDetailVC()
            self.navigationController?.pushViewController(vc, animated: true)

        }
    }
    
    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        print("------GR--didDeselectRowAt--")
        if (indexPath.row != 3){
            let cell = tableView.cellForRow(at: indexPath)
            cell?.accessoryType = .none
        }
    }
    override func viewWillAppear(_ animated: Bool) {
        
    }
    override func viewWillDisappear(_ animated: Bool) {
        
    }
    func backBtnPress(){
        self.navigationController?.popViewController(animated: true)
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
  
    }
    

  

}
