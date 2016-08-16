//
//  AddNewSongView.swift
//  MusicNoteDesignTools
//
//  Created by tangsl on 15/8/20.
//  Copyright (c) 2015年 tangsl. All rights reserved.
//

import UIKit

class AddNewSongView :UIView {
    
    var delegate :AddNewSongViewDelegate?
    var twoFourBtn :UIButton!
    var threeFourBtn :UIButton!
    var fourFourBtn :UIButton!
    var nameTextField :UITextField!
    var speedTextFiled :UITextField!
    var timeSignature :TIME_SIGNATURE = TIME_SIGNATURE.fourFourTime
    var addState :Bool!
    
    init(frame: CGRect,addOrSet :Bool) {
        super.init(frame: frame)
        addState = addOrSet
        backgroundColor = UIColor.clearColor()
        
        let lightBlackView = UIView(frame:bounds)
        lightBlackView.alpha = 0.5
        lightBlackView.backgroundColor = UIColor.blackColor()
        addSubview(lightBlackView)
        
        let addView = UIImageView()
        if addState == true{
            addView.image = UIImage(named: "addsong_bg")
        }
        else{
            addView.image = UIImage(named: "setsong_bg")
        }
        addView.userInteractionEnabled = true
        addSubview(addView)
        
        constrain(addView){addView in
            addView.center == addView.superview!.center
            addView.height == 415
            addView.width == 530
        }
        
        let nameTextBgView = UIImageView(frame: CGRectMake(190, 120, 221, 60))
        nameTextBgView.image = UIImage(named: "addsong_name")
        addView.addSubview(nameTextBgView)
        
        
        nameTextField = UITextField(frame: CGRectMake(196, 120, 221, 60))
        nameTextField.text = "新乐谱"
        addView.addSubview(nameTextField)
        
        if addState == true{
            twoFourBtn = UIButton()
            twoFourBtn.addTarget(self, action: #selector(AddNewSongView.twoFourBtnClick(_:)), forControlEvents: UIControlEvents.TouchUpInside)
            
            addView.addSubview(twoFourBtn)
            
            threeFourBtn = UIButton()
            threeFourBtn.addTarget(self, action: #selector(AddNewSongView.threeFourBtnClick(_:)), forControlEvents: UIControlEvents.TouchUpInside)
            addView.addSubview(threeFourBtn)
            
            fourFourBtn = UIButton()
            fourFourBtn.addTarget(self, action: #selector(AddNewSongView.fourFourBtnClick(_:)), forControlEvents: UIControlEvents.TouchUpInside)
            fourFourBtn.setImage(UIImage(named: "addsong_rect_se"), forState: UIControlState.Normal)
            addView.addSubview(fourFourBtn)
            
            constrain(twoFourBtn,threeFourBtn,fourFourBtn){twoFourBtn,threeFourBtn,fourFourBtn in
                align(top: twoFourBtn,threeFourBtn,fourFourBtn)
                twoFourBtn.width == threeFourBtn.width
                threeFourBtn.width == fourFourBtn.width
                twoFourBtn.width == 56
                
                twoFourBtn.height == threeFourBtn.height
                threeFourBtn.height == fourFourBtn.height
                twoFourBtn.height == 59
                
                distribute(by: 5, horizontally: twoFourBtn, threeFourBtn, fourFourBtn)
                twoFourBtn.left == twoFourBtn.superview!.left + 190
                twoFourBtn.top == twoFourBtn.superview!.top + 202
            }
            
            let twoFourImage = UIImageView()
            twoFourImage.image = UIImage(named: "addsong_signature_2_4")
            twoFourBtn.addSubview(twoFourImage)
            
            let threeFourImage = UIImageView()
            threeFourImage.image = UIImage(named: "addsong_signature_3_4")
            threeFourBtn.addSubview(threeFourImage)
            
            let fourFourImage = UIImageView()
            fourFourImage.image = UIImage(named: "addsong_signature_4_4")
            fourFourBtn.addSubview(fourFourImage)
            
            constrain(twoFourImage,threeFourImage,fourFourImage){twoFourImage,threeFourImage,fourFourImage in
                twoFourImage.center == twoFourImage.superview!.center
                threeFourImage.center == threeFourImage.superview!.center
                fourFourImage.center == fourFourImage.superview!.center
                
                twoFourImage.width == 44
                twoFourImage.height == 52
                threeFourImage.width == twoFourImage.width
                fourFourImage.width == threeFourImage.width
                threeFourImage.height == twoFourImage.height
                fourFourImage.height == threeFourImage.height
            }
        }
        else{
            let speedTextBgView = UIImageView(frame: CGRectMake(190, 202, 221, 60))
            speedTextBgView.image = UIImage(named: "addsong_name")
            addView.addSubview(speedTextBgView)
            
            speedTextFiled = UITextField(frame: CGRectMake(196, 202, 221, 60))
            speedTextFiled.text = "80"
            addView.addSubview(speedTextFiled)
        }
        let finishBtn = UIButton(frame: CGRectMake(124, 290, 113, 54))
        finishBtn.setImage(UIImage(named:"addsong_finish"), forState: UIControlState.Normal)
        finishBtn.addTarget(self, action: #selector(AddNewSongView.finishBtnClick), forControlEvents: UIControlEvents.TouchUpInside)
        addView.addSubview(finishBtn)
        
        let cancelBtn = UIButton(frame: CGRectMake(294, 290, 113, 54))
        cancelBtn.setImage(UIImage(named:"addsong_cancel"), forState: UIControlState.Normal)
        cancelBtn.addTarget(self, action: #selector(AddNewSongView.cancelBtnClick), forControlEvents: UIControlEvents.TouchUpInside)
        addView.addSubview(cancelBtn)
        
    }
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func twoFourBtnClick(sender :AnyObject){
        setAllBtnUnse()
        sender.setImage(UIImage(named: "addsong_rect_se"), forState: UIControlState.Normal)
        timeSignature = TIME_SIGNATURE.twoFourTime
        
    }
    
    func threeFourBtnClick(sender :AnyObject){
        setAllBtnUnse()
        sender.setImage(UIImage(named: "addsong_rect_se"), forState: UIControlState.Normal)
        timeSignature = TIME_SIGNATURE.threeFourTime
    }
    
    func fourFourBtnClick(sender :AnyObject){
        setAllBtnUnse()
        sender.setImage(UIImage(named: "addsong_rect_se"), forState: UIControlState.Normal)
        timeSignature = TIME_SIGNATURE.fourFourTime
    }
    
    func setAllBtnUnse(){
        twoFourBtn.setImage(nil, forState: UIControlState.Normal)
        threeFourBtn.setImage(nil, forState: UIControlState.Normal)
        fourFourBtn.setImage(nil, forState: UIControlState.Normal)
    }
    
    func finishBtnClick(){
        if addState == true{
            delegate?.finishBtnClick(nameTextField.text!, timeSignature :timeSignature)
        }
        else{
            delegate?.finishSetBtnClick(nameTextField.text!,songspeed: speedTextFiled.text!)
        }
    }
    
    func cancelBtnClick(){
        delegate?.cancelBtnClick()
    }
}
