//
//  EditVIewTopView.swift
//  MusicNoteDesignTools
//
//  Created by tangsl on 15/8/16.
//  Copyright (c) 2015年 tangsl. All rights reserved.
//

import UIKit

class EditVIewTopView :UIView{
    //! delegate
    var delegate : EditVIewTopViewDelegate! = nil
    //! switch flag
    var switchFlag :Bool = false
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        //int back image
        let backImage: UIImage! = UIImage(named:"bg_top")
        self.backgroundColor = UIColor(patternImage: backImage)
        
        //show top btn
        self.showEdidViewTopBtn()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func showEdidViewTopBtn(){
        
        //play btn init
        let playbtn :UIButton! = UIButton()
        playbtn.setImage(UIImage(named: "topbtn_play"),  forState: UIControlState.Normal)
        playbtn.setImage(UIImage(named: "topbtn_play_se"),  forState: UIControlState.Highlighted)
        playbtn.addTarget(self, action: Selector("playBtnClickMethod:"), forControlEvents: UIControlEvents.TouchUpInside)
        self .addSubview(playbtn)
        
        //add btn init
        let backBtn :UIButton! = UIButton()
        backBtn.setImage(UIImage(named: "topbtn_back"),  forState: UIControlState.Normal)
        backBtn.setImage(UIImage(named: "topbtn_back_se"),  forState: UIControlState.Highlighted)
        backBtn.addTarget(self, action: Selector("backBtnClickMethod:"), forControlEvents: UIControlEvents.TouchUpInside)
        self .addSubview(backBtn)
        
        //table btn init
        let cleanBtn :UIButton! = UIButton()
        cleanBtn.setImage(UIImage(named: "topbtn_clean"), forState: UIControlState.Normal)
        cleanBtn.setImage(UIImage(named: "topbtn_clean_se"), forState: UIControlState.Highlighted)
        cleanBtn.addTarget(self, action: Selector("cleanBtnClickMethod:"), forControlEvents: UIControlEvents.TouchUpInside)
        self.addSubview(cleanBtn)
        
        constrain(playbtn, cleanBtn,backBtn){
            playbtn, cleanBtn, backBtn in
            align(top: playbtn, cleanBtn ,backBtn)
            cleanBtn.right == cleanBtn.superview!.right - 7.5
            backBtn.left == backBtn.superview!.left + 7.5
            distribute(by: 15, horizontally: playbtn, cleanBtn)
        }
        
        
        
    }
    
    //method
    func playBtnClickMethod(sender: AnyObject){
        delegate.playBtnClickMethod()
    }
    
    func cleanBtnClickMethod(sender: AnyObject){
        delegate .cleanBtnClickMethod()
    }
    
    func backBtnClickMethod(sender: AnyObject){
        delegate.backBtnClickMethod()
    }
    

}
