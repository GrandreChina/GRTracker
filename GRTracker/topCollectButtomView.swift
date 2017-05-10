//
//  topCollectButtomView.swift
//  GRTracker
//
//  Created by Grandre on 17/4/20.
//  Copyright © 2017年 革码者. All rights reserved.
//

import UIKit

class topCollectButtomView: UIView,UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout {

    var colletionView:UICollectionView!
    var inset:CGFloat!
    var topCollectBtnFlag:Bool = true
    var btn:UIButton!
    var height1: CGFloat!
    override func layoutIfNeeded() {
        
    }
  
    override func layoutSubviews() {
        
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = UIColor.white.withAlphaComponent(0.6)
        
        self.btn = UIButton(frame: CGRect(x:(self.bounds.width-30)*0.5,y:self.bounds.height-30,width:30,height:30))
        btn.backgroundColor = UIColor.clear
        btn.setImage(UIImage(named: "jiantou.png"), for: UIControlState.normal)
        btn.addTarget(self, action: #selector(self.btnPressed), for: .touchUpInside)
        btn.setImage(UIImage(named:"arrow1.png"), for: .normal)
        self.addSubview(btn)
        
        let layout = UICollectionViewFlowLayout()
        //滚动方向
        layout.scrollDirection = .vertical
        
        
        self.colletionView = UICollectionView(frame: CGRect(x: 0, y: 0, width: self.bounds.width, height: self.bounds.height - 30), collectionViewLayout: layout)
        
        //注册一个cell
        self.colletionView.register(My1CollectionViewCell.classForCoder(), forCellWithReuseIdentifier: "cell")
        //注册一个headView
        self.colletionView?.register(HeaderReusableView.self, forSupplementaryViewOfKind:UICollectionElementKindSectionHeader, withReuseIdentifier: "headView")
        //注册一个footView
        self.colletionView.register(FooterCollectionReusableView.self, forSupplementaryViewOfKind:UICollectionElementKindSectionFooter , withReuseIdentifier: "footView")
        
        
        self.colletionView?.delegate = self;
        self.colletionView?.dataSource = self;
        self.colletionView?.backgroundColor = UIColor.clear
        self.addSubview(self.colletionView!)
        self.bringSubview(toFront: btn)
        
        let swipeUpGesture = UISwipeGestureRecognizer(target: self, action: #selector(self.handleSwipeGesture(sender:)))
        swipeUpGesture.direction = UISwipeGestureRecognizerDirection.up //不设置是右
        self.addGestureRecognizer(swipeUpGesture)
        
        let swipeDownGesture = UISwipeGestureRecognizer(target: self, action: #selector(self.handleSwipeGesture(sender:)))
        swipeDownGesture.direction = UISwipeGestureRecognizerDirection.down //不设置是右
        self.addGestureRecognizer(swipeDownGesture)
        
    }
    
    //划动手势
    func handleSwipeGesture(sender: UISwipeGestureRecognizer){
        //划动的方向
        let direction = sender.direction
        //判断是上下左右
        switch (direction){
        case UISwipeGestureRecognizerDirection.left:
            print("Left")
          
            break
        case UISwipeGestureRecognizerDirection.right:
            print("Right")
            break
        case UISwipeGestureRecognizerDirection.up:
            print("Up")
            if !self.topCollectBtnFlag{
                btnPressed()
            }
            break
        case UISwipeGestureRecognizerDirection.down:
            print("Down")
            if self.topCollectBtnFlag{
                btnPressed()
            }
            break
        default:
            break;
        }
      
    }
    func btnPressed(){
        UIView.animate(withDuration: 0.3) {
//            print("-----\(self.height1)----")
            if self.topCollectBtnFlag{
                self.frame = CGRect(x: 0, y:self.height1, width: ScreenWidth, height: 150)
                
                
            }else{
                self.frame = CGRect(x: 0, y: self.height1, width: ScreenWidth, height: 75)
                
            }
            
            self.btn.frame =  CGRect(x:(self.bounds.width-30)*0.5,y:self.bounds.height-30,width:30,height:30)
            self.colletionView.frame = CGRect(x: 0, y: 0, width: self.bounds.width, height: self.bounds.height - 30)
        }
        
        
        topCollectBtnFlag = !topCollectBtnFlag
    }
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    override func draw(_ rect: CGRect) {
        print("----drawRect-----------")
        
        //每次layoutSubviews时都会调用drawRect方法
        self.contentMode = .redraw
       
        let context = UIGraphicsGetCurrentContext()
        context?.setLineWidth(0.5)
        context?.setStrokeColor(MAIN_RED.cgColor)
        context?.move(to: CGPoint(x: 0, y: rect.size.height-15))
            
        context?.addLine(to: CGPoint(x: rect.size.width/2-30, y: rect.size.height-15))
            
        context?.strokePath()
        
        context?.move(to: CGPoint(x: rect.size.width/2 + 30, y: rect.size.height-15))
        
        context?.addLine(to: CGPoint(x: rect.size.width, y: rect.size.height-15))
        
        context?.strokePath()
        
        
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
        return CGSize(width: ScreenWidth, height: 20)
    }
    
    //设置footer的宽高
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForFooterInSection section: Int) -> CGSize {
        return CGSize(width: ScreenWidth, height: 5)
    }
    //自定义header和footer
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
   
        
        
        if kind == UICollectionElementKindSectionHeader{
            
           let v = self.colletionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "headView", for: indexPath) as! HeaderReusableView
            
            for view in v.subviews{
                view.removeFromSuperview()
            }
            
            v.initUI()
            
            switch indexPath.section {
            case 0:
                v.label.text = "总览"
            default:
                v.label.text = "国人监控"
            }
            
          
            return v
        }else{
            
           let v = self.colletionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "footView", for: indexPath) as! FooterCollectionReusableView
            
          return v
        }
        
        
        
    }
    
    
    //可以为某一个cell设置大小
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: (ScreenWidth-10)*0.5, height: 25)
    }
    //设置元素内容
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        //这里创建cell
        
        let cell = colletionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! My1CollectionViewCell
        
        for view in cell.contentView.subviews{
            view.removeFromSuperview()
        }
        cell.backgroundColor = MAIN_RED.withAlphaComponent(0.4)
        cell.layer.cornerRadius = 5
        cell.layer.masksToBounds = true
        
        cell.valueLable.text = "\(indexPath.row+1)台"
        
        
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
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    


}
