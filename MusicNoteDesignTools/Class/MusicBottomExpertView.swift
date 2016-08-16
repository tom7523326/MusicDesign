//
//  MusicBottomExpertView.swift
//  MusicNoteDesignTools
//
//  Created by tangsl on 15/8/6.
//  Copyright (c) 2015年 tangsl. All rights reserved.
//

import UIKit

class MusicBottomExpertView :UIView {
        var undoBtn :UIButton!
     var redoBtn :UIButton!
    var deleteBtn :UIButton!
    var copyBtn :UIButton!
    var cutBtn :UIButton!
    
    var delegate :MusicBottomExpertViewDelegate?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        let backImageView :UIImageView = UIImageView()
        backImageView.image = UIImage(named: "bg_bottomexpert")
        self.addSubview(backImageView)
        
        constrain(backImageView) { backImageView in
            backImageView.centerX == backImageView.superview!.centerX
            backImageView.bottom == backImageView.superview!.bottom
            backImageView.width == 593
            backImageView.height == 206
        }
        
        undoBtn = UIButton()
        undoBtn.setImage(UIImage(named: "bottombtn_last"),forState: UIControlState.Normal)
        undoBtn.setImage(UIImage(named: "bottombtn_last_se"),forState: UIControlState.Highlighted)
        undoBtn.addTarget(self, action: #selector(MusicBottomExpertView.undoBtnClick), forControlEvents: UIControlEvents.TouchUpInside)
        undoBtn.enabled = false
        self.addSubview(undoBtn)
        
        redoBtn = UIButton()
        redoBtn.setImage(UIImage(named: "bottombtn_next"),forState: UIControlState.Normal)
        redoBtn.setImage(UIImage(named: "bottombtn_next_se"),forState: UIControlState.Highlighted)
        redoBtn.addTarget(self, action: #selector(MusicBottomExpertView.redoBtnClick), forControlEvents: UIControlEvents.TouchUpInside)
        redoBtn.enabled = false
        self.addSubview(redoBtn)
        
        deleteBtn = UIButton()
        deleteBtn.setImage(UIImage(named: "bottombtn_delete"),forState: UIControlState.Normal)
        deleteBtn.setImage(UIImage(named: "bottombtn_delete_se"),forState: UIControlState.Highlighted)
        deleteBtn.addTarget(self, action: #selector(MusicBottomExpertView.deleteBtnClick), forControlEvents: UIControlEvents.TouchUpInside)
        deleteBtn.enabled = false
        self.addSubview(deleteBtn)
        
        copyBtn = UIButton()
        copyBtn.setImage(UIImage(named: "bottombtn_copy"),forState: UIControlState.Normal)
        copyBtn.setImage(UIImage(named: "bottombtn_copy_se"),forState: UIControlState.Highlighted)
        copyBtn.addTarget(self, action: #selector(MusicBottomExpertView.copyBtnClick), forControlEvents: UIControlEvents.TouchUpInside)
        copyBtn.enabled = false
        self.addSubview(copyBtn)
        
        cutBtn = UIButton()
        cutBtn.setImage(UIImage(named: "bottombtn_cut"),forState: UIControlState.Normal)
        cutBtn.setImage(UIImage(named: "bottombtn_cut_se"),forState: UIControlState.Highlighted)
        cutBtn.addTarget(self, action: #selector(MusicBottomExpertView.cutBtnClick), forControlEvents: UIControlEvents.TouchUpInside)
        cutBtn.enabled = false
        self.addSubview(cutBtn)
        
        constrain(undoBtn,redoBtn,deleteBtn,copyBtn,cutBtn) {
            undoBtn,redoBtn,deleteBtn,copyBtn,cutBtn in
            
            align(bottom : redoBtn,copyBtn)
            align(bottom : undoBtn,cutBtn)
            deleteBtn.bottom == deleteBtn.superview!.bottom - 40
            redoBtn.bottom == deleteBtn.superview!.bottom - 20
            undoBtn.bottom == deleteBtn.superview!.bottom - 0
            
            deleteBtn.centerX == deleteBtn.superview!.centerX
            distribute(by: 0, horizontally: undoBtn,redoBtn,deleteBtn,copyBtn,cutBtn)
            
            undoBtn.width == redoBtn.width
            redoBtn.width == deleteBtn.width
            deleteBtn.width == copyBtn.width
            copyBtn.width == cutBtn.width
            cutBtn.width == BOTTOM_BTN_WIDTH
            
            undoBtn.height == redoBtn.height
            redoBtn.height == deleteBtn.height
            deleteBtn.height == copyBtn.height
            copyBtn.height == cutBtn.height
            cutBtn.height == BOTTOM_BTN_HEIGHT
        }
    }
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //btn click method
    func undoBtnClick(){
        delegate?.undoBtnClick()
    }
    func redoBtnClick(){
        delegate?.redoBtnClick()
    }
    func deleteBtnClick(){
        delegate?.deleteBtnClick()
    }
    func copyBtnClick(){
        delegate?.copyBtnClick()
    }
    func cutBtnClick(){
        delegate?.cutBtnClick()
    }
    
    func setRedoBtnEnableState(state :Bool){
        redoBtn.enabled = state
    }
    
    func setUndoBtnEnableState(state :Bool){
        undoBtn.enabled = state
    }
    
    func setFuncBtnEnableState(state :Bool){
        deleteBtn.enabled = state
        copyBtn.enabled = state
        cutBtn.enabled = state
    }
}
