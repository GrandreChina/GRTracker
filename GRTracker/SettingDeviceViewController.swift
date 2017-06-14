//
//  SettingDeviceViewController.swift
//  GRTracker
//
//  Created by Grandre on 2017/5/26.
//  Copyright © 2017年 革码者. All rights reserved.
//

import UIKit

class SettingDeviceViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {

    
    var _tableView:UITableView!
    var currentWorkMode:String!//"0","1","2","3"
    override func viewDidLoad() {
        super.viewDidLoad()
        self.initUI()
        self.initTableView()

    }
    
    func initUI(){
        self.view.backgroundColor = UIColor.white
    }
    
    func initTableView(){
        _tableView = UITableView(frame: self.view.bounds, style: .grouped)
        _tableView.delegate = self
        _tableView.dataSource = self
        _tableView.tableFooterView = UIView()
//        _tableView.register(UITableViewCell.classForCoder(), forCellReuseIdentifier: "cell")
        
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
            return 1
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
        let index = (indexPath.section,indexPath.row)
        switch index{
        case (0,0):
            cell?.textLabel?.text = "工作模式"

            switch self.currentWorkMode{
                case "0":
                    cell?.detailTextLabel?.text = "deepsleep模式"
                case "1":
                    cell?.detailTextLabel?.text = "standby模式"
                case "2":
                    cell?.detailTextLabel?.text = "智能工作模式"
                case "3":
                    cell?.detailTextLabel?.text = "用户自定义模式"
            
            default:
                break
            }
//            cell?.detailTextLabel?.text = self.currentWorkMode
        case (0,1):
//            cell?.textLabel?.text = "控制模式"
//            cell?.detailTextLabel?.text = "请设置"
            break
            
        default:
            break
        }
        
        
        cell?.accessoryType = .disclosureIndicator
        cell?.imageView?.image = UIImage(named: "work.png")
        cell?.imageView?.contentMode = .scaleAspectFill
        
        
        return cell!
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        switch indexPath.row{
        case 0:
            let vc = SettingDeviceTableVC()
            vc.currentWorkMode = self.currentWorkMode
            self.navigationController?.pushViewController(vc, animated: true)
            
        case 1:
            break
        default:
            break
        }
    }
    override func viewWillAppear(_ animated: Bool) {
        print("----GR----SettingDeviceViewController-appear--")
    }
    override func viewWillDisappear(_ animated: Bool) {
        print("----GR----SettingDeviceViewController-disappear--")

    }
    deinit{
        print("----GR---SettingDeviceViewController-deinit---")
    }

}
