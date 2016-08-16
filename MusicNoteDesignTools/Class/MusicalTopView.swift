//
//  MusicalTopView.swift
//  MusicNoteDesignTools
//
//  Created by tangsl on 15/7/23.
//  Copyright (c) 2015年 tangsl. All rights reserved.
//

import UIKit

class MusicalTopView: UIView {
    
    //! delegate
    var delegate : MainViewTopViewDelegate! = nil
    var playbtn:UIButton!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        //int back image
        let backImage: UIImage! = UIImage(named:"bg_top")
        self.backgroundColor = UIColor(patternImage: backImage)
        
        //show top btn
        self.showMainViewTopBtn()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func showMainViewTopBtn(){
        
        //play btn init
        playbtn = UIButton()
        playbtn.setImage(UIImage(named: "topbtn_play"),  forState: UIControlState.Normal)
        playbtn.setImage(UIImage(named: "topbtn_play_se"),  forState: UIControlState.Highlighted)
        playbtn.addTarget(self, action: #selector(MusicalTopView.playBtnClickMethod(_:)), forControlEvents: UIControlEvents.TouchUpInside)
        self .addSubview(playbtn)
        
        //add btn init
        let addbtn :UIButton! = UIButton()
        addbtn.setImage(UIImage(named: "topbtn_add"), forState: UIControlState.Normal)
        addbtn.setImage(UIImage(named: "topbtn_add_se"), forState: UIControlState.Highlighted)
        addbtn.addTarget(self, action: #selector(MusicalTopView.addBtnClickMethod(_:)), forControlEvents: UIControlEvents.TouchUpInside)
//        addbtn.enabled = false
        self.addSubview(addbtn)
        
        //save btn init
        let savebtn :UIButton! = UIButton()
        savebtn.setImage(UIImage(named: "topbtn_save"), forState: UIControlState.Normal)
        savebtn.setImage(UIImage(named: "topbtn_save_se"), forState: UIControlState.Highlighted)
        savebtn.addTarget(self, action: #selector(MusicalTopView.saveBtnClickMethod(_:)), forControlEvents: UIControlEvents.TouchUpInside)
        self.addSubview(savebtn)
        
        //set btn init
        let setbtn :UIButton! = UIButton()
        setbtn.setImage(UIImage(named: "topbtn_set"), forState: UIControlState.Normal)
        setbtn.setImage(UIImage(named: "topbtn_set_se"), forState: UIControlState.Highlighted)
        setbtn.addTarget(self, action: #selector(MusicalTopView.setBtnClickMethod(_:)), forControlEvents: UIControlEvents.TouchUpInside)
        self.addSubview(setbtn)
        
        //switch btn init
        let switchbtn :UIButton! = UIButton()
        switchbtn.setImage(UIImage(named: "topbtn_swich"), forState: UIControlState.Normal)
        switchbtn.setImage(UIImage(named: "topbtn_swich_se"), forState: UIControlState.Highlighted)
        switchbtn.addTarget(self, action: #selector(MusicalTopView.switchClickMethod(_:)), forControlEvents: UIControlEvents.TouchUpInside)
        self.addSubview(switchbtn)
        
        //table btn init
        let tablebtn :UIButton! = UIButton()
        tablebtn.setImage(UIImage(named: "topbtn_table"), forState: UIControlState.Normal)
        tablebtn.setImage(UIImage(named: "topbtn_table_se"), forState: UIControlState.Highlighted)
        tablebtn.addTarget(self, action: #selector(MusicalTopView.tableClickMethod(_:)), forControlEvents: UIControlEvents.TouchUpInside)
        self.addSubview(tablebtn)
        
        constrain(playbtn, tablebtn){
            playbtn, tablebtn in
            align(top: playbtn, tablebtn)
            playbtn.left == playbtn.superview!.left + 7.5
            tablebtn.right == tablebtn.superview!.right - 7.5
        }
        
        constrain(addbtn,savebtn,setbtn,switchbtn) {
            addbtn,savebtn,setbtn,switchbtn in
            setbtn.left == setbtn.superview!.centerX + 7.5
            align(top: addbtn,savebtn,setbtn,switchbtn)
            distribute(by: 15, horizontally: addbtn, savebtn, setbtn, switchbtn)
           
            
            addbtn.width == savebtn.width
            savebtn.width == setbtn.width
            setbtn.width == switchbtn.width
            switchbtn.width == BTN_WIDTH
            
            addbtn.height == savebtn.height
            savebtn.height == setbtn.height
            setbtn.height == switchbtn.height
            switchbtn.height == BTN_HEIGHT
        }
        
        
        
    }
    
    //method
    func playBtnClickMethod(sender: AnyObject){
        delegate.playBtnClickMethod(sender)
    }
    
    func addBtnClickMethod(sender: AnyObject){
        delegate .addBtnClickMethod()
    }
    
    func saveBtnClickMethod(sender: AnyObject){
        delegate.saveBtnClickMethod()
    }
    
    func setBtnClickMethod(sender: AnyObject){
        delegate.setBtnClickMethod()
    }
    
    func switchClickMethod(sender: AnyObject){

        delegate.switchClickMethod(sender)
    }
    
    func tableClickMethod(sender: AnyObject){
        delegate.tableClickMethod()
    }
    

    
}
