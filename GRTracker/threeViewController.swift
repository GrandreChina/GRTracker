//
//  threeViewController.swift
//  GRTracker
//
//  Created by Grandre on 17/4/18.
//  Copyright © 2017年 革码者. All rights reserved.
//

import UIKit

class threeViewController: UIViewController,UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout {
   
    var colletionView:UICollectionView!
    var dataArr = NSMutableArray()
    var inset:CGFloat!
    var topCollectBottomView:topCollectButtomView!
    var topCollectBtnFlag:Bool = true
    var btn:UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = UIColor.brown
        print("-------")
        
        self.topCollectBottomView = topCollectButtomView(frame: CGRect(x: 0, y: 0, width: self.view.bounds.width, height: 75))
        self.topCollectBottomView.backgroundColor = UIColor.clear
        
        self.view.addSubview(topCollectBottomView)
        
        
        
        self.btn = UIButton(frame: CGRect(x:(self.view.bounds.width-30)*0.5,y:self.topCollectBottomView.height-30,width:30,height:30))
        btn.backgroundColor = UIColor.clear
        btn.setImage(UIImage(named: "jiantou.png"), for: UIControlState.normal)
        btn.addTarget(self, action: #selector(self.btnPressed), for: .touchUpInside)
        btn.setImage(UIImage(named:"arrow1.png"), for: .normal)
       
        self.topCollectBottomView.addSubview(btn)
        
        let layout = UICollectionViewFlowLayout()
        //滚动方向
        layout.scrollDirection = .vertical
        

        self.colletionView = UICollectionView(frame: CGRect(x: 0, y: 0, width: self.topCollectBottomView.bounds.width, height: self.topCollectBottomView.height - 30), collectionViewLayout: layout)
        
        //注册一个cell
        self.colletionView.register(My1CollectionViewCell.classForCoder(), forCellWithReuseIdentifier: "cell")
        //注册一个headView
        self.colletionView?.register(HeaderReusableView.self, forSupplementaryViewOfKind:UICollectionElementKindSectionHeader, withReuseIdentifier: "headView")
        //注册一个footView
        self.colletionView.register(HeaderReusableView.self, forSupplementaryViewOfKind:UICollectionElementKindSectionFooter , withReuseIdentifier: "footView")
        
        
        self.colletionView?.delegate = self;
        self.colletionView?.dataSource = self;
        self.colletionView?.backgroundColor = UIColor.white.withAlphaComponent(0.2)
        
        self.topCollectBottomView.addSubview(self.colletionView!)
        self.topCollectBottomView.bringSubview(toFront: btn)
        
        
    }
    
    func btnPressed(){
       
        if topCollectBtnFlag{
            self.topCollectBottomView.frame = CGRect(x: 0, y: 0, width: self.view.bounds.width, height: 150)
         
        
        }else{
            self.topCollectBottomView.frame = CGRect(x: 0, y: 0, width: self.view.bounds.width, height: 75)
            
        }
  
        self.btn.frame =  CGRect(x:(self.view.bounds.width-30)*0.5,y:self.topCollectBottomView.height-30,width:30,height:30)
        self.colletionView.frame = CGRect(x: 0, y: 0, width: self.topCollectBottomView.bounds.width, height: self.topCollectBottomView.height - 30)
         topCollectBtnFlag = !topCollectBtnFlag
    }
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        print("----GR---touch")
    }
    //设置分区个数
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 2
    }
    //设置每个分区元素个数
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if section == 1{
            return 6
        }
        return  2
    }
    //设置header的宽高
        func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
            return CGSize(width: 200, height: 15)
        }
    
        //设置footer的宽高
        func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForFooterInSection section: Int) -> CGSize {
            return CGSize(width: 200, height: 5)
        }
    //自定义header和footer

    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        var v:HeaderReusableView!
            if kind == UICollectionElementKindSectionHeader{

              v = self.colletionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "headView", for: indexPath) as! HeaderReusableView
            
                v.label.text = "总览"
                if indexPath.section == 1{
                    v.label.text = "国人监控"
                }
                return v
            }else{
                v = self.colletionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "footView", for: indexPath) as! HeaderReusableView
    
                return v
            }

    }
    //可以为某一个cell设置大小
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: (self.view.bounds.width-10)*0.5, height: 25)
    }
    //设置元素内容
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        //这里创建cell
        let cell = colletionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath)
        cell.backgroundColor = MAIN_RED.withAlphaComponent(0.4)
        cell.layer.cornerRadius = 5
        cell.layer.masksToBounds = true
        
        return cell
    }
    //    设置cell上下左右的间距，包括可以设置section头，尾的inset。这里的inset设置会覆盖掉UICollectionViewFlowLayout自定义的inset。
    //    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAtIndex section: Int) -> UIEdgeInsets {
    //        return UIEdgeInsets(top: 10, left: inset, bottom: 30, right: inset)
    //    }
    //    ---------------
    func collectionView(_ collectionView: UICollectionView, canMoveItemAt indexPath: IndexPath) -> Bool {
        return true
    }
    func collectionView(_ collectionView: UICollectionView, moveItemAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
        print("----move item")
    }
    
    
    //最小cell左右间距
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 10
    }
    //最小行间距
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 5
    }
    
    //    -------delegate-------
    //点击元素
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath){
        print("点击了第\(indexPath.section) 分区 ,第\(indexPath.row) 个元素")
    }
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}

