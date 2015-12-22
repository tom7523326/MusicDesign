//
//  NoteKeyBtn.swift
//  MusicNoteDesignTools
//
//  Created by tangsl on 15/8/13.
//  Copyright (c) 2015年 tangsl. All rights reserved.
//

import UIKit

class NoteKeyBtn :UIButton {
    
    var delegate :NoteKeyBtnDelegate?
    var noteIndex :Int = -1
    var noteImageView :UIImageView?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        if noteIndex != -1{
            self.hidden = true
        }
        delegate?.noteKeyBtnClick(self)
    }
    
    override func touchesMoved(touches: Set<UITouch>, withEvent event: UIEvent?) {
        let location:CGPoint? = (touches as NSSet).anyObject()?.locationInView(self)
        delegate?.moveNoteToPosi(location!, sender: self)
    }
    
    override func touchesEnded(touches: Set<UITouch>, withEvent event: UIEvent?) {
        let location:CGPoint? = (touches as NSSet).anyObject()?.locationInView(self)
        delegate?.touchEndInPosi(location!, sender: self)
    }
    
    override func touchesCancelled(touches: Set<UITouch>?, withEvent event: UIEvent?) {
        
    }
}
