//
//  MeasureEditView.swift
//  MusicNoteDesignTools
//
//  Created by tangsl on 15/8/13.
//  Copyright (c) 2015年 tangsl. All rights reserved.
//

import UIKit

let EDIT_BOTTOM_BTN_SPACING :CGFloat = 5
let EDIT_BOTTOM_BTN_WIDTH :CGFloat = 62
let EDIT_BOTTOM_BTN_HEIGHT :CGFloat = 167
let EDIT_BOTTOM_BTN_TOP :CGFloat = 3

class MeasureEditView : UIView ,NoteKeyBtnDelegate{
    
    var bottomKeyView :UIImageView!
    var repeatLeftBtn :UIImageView!
    var repeatRightBtn :UIImageView!
    var noteBtnArray :[NoteKeyBtn]! = [NoteKeyBtn]()
    var noteArray : [MusicNote]! = [MusicNote]()
    var dottedNoteArray : [MusicNote]! = [MusicNote]()
    var btnDottedState :Bool = false
    var movingNoteView :UIImageView!
    var musicMeasure :MusicMeasure?
    var lineViewArray :[UIView]! = [UIView]()
     var dottedChangedBtn :UIButton!
    
    var lineNoteBtnArray :[NoteKeyBtn]! = [NoteKeyBtn]()
    var delegate :MeasureEditViewDelegate?
    
    //MARK: -----------system method----------------
    override init(frame: CGRect) {
        super.init(frame: frame)
        //init back image
        let image :UIImage! = UIImage(named: "bg_content")
        backgroundColor = UIColor(patternImage: image)
        
        for var i = 0; i < 10; ++i{
            let note:MusicNote = MusicNote(type: NOTE_TYPE(rawValue: i)!, scale: NOTE_SCALE.a)
            noteArray.append(note)
        }
        for var i = 10;i < 20; ++i{
            let note:MusicNote = MusicNote(type: NOTE_TYPE(rawValue: i)!, scale: NOTE_SCALE.a)
            dottedNoteArray.append(note)
        }
        
        for i in 0 ..< 8{
            let staffTop:CGFloat = 230 + (STAFF_SPACING + STAFF_LINE_HEIGHT) * CGFloat(i)
            let lineview :UIView = UIView(frame: CGRectMake(STAFF_LEFT_MARGIN, staffTop, bounds.width - STAFF_LEFT_MARGIN * 2, STAFF_LINE_HEIGHT))
            lineViewArray.append(lineview)
            addSubview(lineview)
        }
        setAllLineBlack()
        
        bottomKeyView = UIImageView(frame: CGRectMake(0, bounds.height-173, 1024, 173))
        bottomKeyView.image = UIImage(named: "bg_musicalnote")
        bottomKeyView.userInteractionEnabled = true
        addSubview(bottomKeyView)
        
        repeatLeftBtn = UIImageView(frame: CGRectMake(13, EDIT_BOTTOM_BTN_TOP, EDIT_BOTTOM_BTN_WIDTH, EDIT_BOTTOM_BTN_HEIGHT))
        repeatLeftBtn.image = UIImage(named: "bg_whitekey")
        bottomKeyView.addSubview(repeatLeftBtn)
        
        repeatRightBtn = UIImageView(frame: CGRectMake(83, EDIT_BOTTOM_BTN_TOP, EDIT_BOTTOM_BTN_WIDTH, EDIT_BOTTOM_BTN_HEIGHT))
        repeatRightBtn.image = UIImage(named: "bg_whitekey")
        bottomKeyView.addSubview(repeatRightBtn)
        
        for var i = 0; i < 10 ; ++i{
            let btn: NoteKeyBtn = NoteKeyBtn(frame: CGRectMake(180 + CGFloat(i) * (EDIT_BOTTOM_BTN_WIDTH + EDIT_BOTTOM_BTN_SPACING), EDIT_BOTTOM_BTN_TOP, EDIT_BOTTOM_BTN_WIDTH, EDIT_BOTTOM_BTN_HEIGHT))
            btn.setImage(UIImage(named: "bg_whitekey"), forState:UIControlState.Normal)
            btn.addTarget(self, action:Selector("noteKeyBtnClick:"), forControlEvents: UIControlEvents.TouchDown)
            btn.delegate = self
            btn.tag = i
            
            bottomKeyView.addSubview(btn)
            noteBtnArray.append(btn)
            
            btn.noteImageView = UIImageView(frame: CGRectMake(0, 0, NOTE_WIDTH, NOTE_HEIGHT))
            btn.noteImageView!.image = getNoteWithIndex(i).getNoteImage()
            btn.noteImageView!.center = CGPointMake(btn.bounds.width/2, btn.bounds.height/2)
            btn.noteImageView!.userInteractionEnabled = false
            btn.addSubview(btn.noteImageView!)
        }
        
        movingNoteView = UIImageView(frame: CGRectMake(0, 0, NOTE_WIDTH, NOTE_HEIGHT))
        movingNoteView.hidden = true
        addSubview(movingNoteView)
        
        dottedChangedBtn = UIButton(frame: CGRectMake(180 + CGFloat(10) * (EDIT_BOTTOM_BTN_WIDTH + EDIT_BOTTOM_BTN_SPACING) + 50, (173-77)/2, 77, 77))
        dottedChangedBtn.setImage(UIImage(named: "bottombtn_change"), forState:UIControlState.Normal)
        dottedChangedBtn.addTarget(self, action: Selector("dottedChangedBtnClick:"), forControlEvents: UIControlEvents.TouchUpInside)
        bottomKeyView.addSubview(dottedChangedBtn)
        
        
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //    override func drawRect(rect: CGRect) {
    //        for i in 0..<5 {
    //            let staffLineHeight :CGFloat = 2;
    //            let context = UIGraphicsGetCurrentContext()
    //            CGContextSetLineWidth(context, staffLineHeight)
    //            let colorSpace = CGColorSpaceCreateDeviceRGB()
    //            let components: [CGFloat] = [0.0, 0.0, 0.0, 1.0]
    //            let color = CGColorCreate(colorSpace, components)
    //            CGContextSetStrokeColorWithColor(context, color)
    //            let staffTop:CGFloat = 250 + (STAFF_SPACING + STAFF_LINE_HEIGHT) * CGFloat(i)
    //            CGContextMoveToPoint(context, STAFF_LEFT_MARGIN, staffTop)
    //            CGContextAddLineToPoint(context, bounds.width - STAFF_LEFT_MARGIN, staffTop)
    //            CGContextStrokePath(context)
    //        }
    //    }
    
    //MARK: ------------btn click method---------------
    func noteKeyBtnClick(sender: NoteKeyBtn){
        if sender.tag != -1{
            noteBtnArray[sender.tag].setImage(UIImage(named: "bottombtn_key_se"), forState:UIControlState.Normal)
            movingNoteView.image = getNoteWithIndex(sender.tag).getNoteImage()
        }
        else{
            movingNoteView.image = musicMeasure?.noteArray[sender.noteIndex].getNoteImage()
        }
        movingNoteView.hidden = false
        
        movingNoteView.center = sender.superview!.convertPoint(sender.center, toView: self)
    }
    
    func dottedChangedBtnClick(sender: UIButton){
        if btnDottedState == false{
            btnDottedState = true
        }
        else{
            btnDottedState = false
        }
        
        for var i = 0; i < 10 ; ++i{
            noteBtnArray[i].noteImageView!.image = getNoteWithIndex(i).getNoteImage()
        }
        checkCanUseNote()
    }
    
    //MARK: ------------notekyebtn delegate method---------------
    func moveNoteToPosi(point :CGPoint,sender: NoteKeyBtn){
        let centerPoint = sender.convertPoint(point, toView: self)
        movingNoteView.center = centerPoint
        let circlePosY :CGFloat
        if(sender.tag != -1){
            circlePosY = movingNoteView.frame.origin.y + getNoteWithIndex(sender.tag).getCircleY() + margin * 2
        }
        else{
            circlePosY = movingNoteView.frame.origin.y + musicMeasure!.noteArray[sender.noteIndex].getCircleY() + margin * 2
        }
        
        let scaleValue = Int((circlePosY - lineViewArray[0].frame.origin.y)/(margin * 2))
         setAllLineBlack()
        if scaleValue / 2 < lineViewArray.count &&  scaleValue / 2 >= 0{
        if scaleValue % 2 == 0{
            lineViewArray[scaleValue / 2].backgroundColor = UIColor.redColor()
            lineViewArray[scaleValue / 2].hidden = false
        }
        else{
            lineViewArray[scaleValue / 2].backgroundColor = UIColor.redColor()
            lineViewArray[scaleValue / 2].hidden = false
            if scaleValue / 2 + 1 < lineViewArray.count{
                lineViewArray[scaleValue / 2 + 1].backgroundColor = UIColor.redColor()
                lineViewArray[scaleValue / 2 + 1].hidden = false
            }
        }
        }
        
    }
    
    func touchEndInPosi(point :CGPoint,sender: NoteKeyBtn){
        let centerPoint = sender.convertPoint(point, toView: self)
        movingNoteView.center = centerPoint
        if sender.tag != -1
        {
            noteBtnArray[sender.tag].setImage(UIImage(named: "bg_whitekey"), forState:UIControlState.Normal)
        }
        setAllLineBlack()
        addNoteToMeasureWithPoint(centerPoint, btnIndex: sender.tag ,noteIndex : sender.noteIndex)
        movingNoteView.hidden = true
        
    }
    
    
    //MARK: ------------business method---------------
    
    func getNoteWithIndex(index :Int) ->MusicNote{
        if(!btnDottedState){
            return noteArray[index]
        }
        else{
            return dottedNoteArray[index]
        }
    }
    
    func addNoteToMeasureWithPoint(centerPoint :CGPoint, btnIndex :Int ,noteIndex :Int){
        let circlePosY :CGFloat
        if(noteIndex == -1){
            circlePosY = movingNoteView.frame.origin.y + getNoteWithIndex(btnIndex).getCircleY()
        }
        else{
            circlePosY = movingNoteView.frame.origin.y + musicMeasure!.noteArray[noteIndex].getCircleY()
        }
        let scaleValue = (circlePosY - lineViewArray[0].frame.origin.y + margin*2)/(margin * 2)
        if(Int(scaleValue) <= NOTE_SCALE.g.rawValue && Int(scaleValue) >= NOTE_SCALE.a2.rawValue)
        {
            let scale: NOTE_SCALE = NOTE_SCALE(rawValue: Int(scaleValue))!
            
            if(noteIndex == -1)
            {
                let tempnote :MusicNote = MusicNote(type: getNoteWithIndex(btnIndex).noteType, scale: scale)
                musicMeasure?.noteArray.append(tempnote)
                checkCanUseNote()
            }
            else
            {
                let note = musicMeasure!.noteArray[noteIndex]
                note.noteScale = scale
            }
            
        }
        else{
            if(noteIndex != -1)
            {
                musicMeasure?.noteArray.removeAtIndex(noteIndex)
                checkCanUseNote()
            }
        }
        showAllNote()
        
    }
    
    func showAllNote(){
        for btn in lineNoteBtnArray{
            lineNoteBtnArray.removeAll(keepCapacity: false)
            btn.removeFromSuperview()
        }
        
        let noteCount =  musicMeasure?.noteArray.count
        let noteSpacing = ( bounds.width - STAFF_LEFT_MARGIN * 2 - CGFloat(noteCount!) *  NOTE_WIDTH) / CGFloat(noteCount!)
        
        
        for i in 0 ..< musicMeasure!.noteArray.count{
            let note = musicMeasure?.noteArray[i]
            let lineNoteBtn :NoteKeyBtn = NoteKeyBtn(frame:CGRectMake(STAFF_LEFT_MARGIN+(noteSpacing + NOTE_WIDTH) * CGFloat(i),lineViewArray[0].frame.origin.y - margin * 2 + note!.getNoteScaleHeightValue() + 1, NOTE_WIDTH, NOTE_HEIGHT))
            lineNoteBtn.delegate = self
            lineNoteBtn.tag = -1
            lineNoteBtn.noteIndex = i
            lineNoteBtn.setImage(note!.getNoteImage(), forState: UIControlState.Normal)
            addSubview(lineNoteBtn)
            MusicUtils.addLineToNoteView(lineNoteBtn, note: note!)
            lineNoteBtnArray.append(lineNoteBtn)
        }
    }
    
    func setAllLineBlack(){
        for i in 0 ..< 8{
            let lineview = lineViewArray[i]
            lineview.backgroundColor = UIColor.blackColor()
            if i == 0 || i == 6 || i == 7 {
                lineview.hidden  = true
            }
        }
    }
    
    func checkCanUseNote(){
        var noteLength :Float = 0
        for note in musicMeasure!.noteArray{
            noteLength += note.getNoteTimeValue()
        }
        
        assert(noteLength <= musicMeasure!.getTimeSignatureValue(), "error!!")
        
        let restOfTimeLength = musicMeasure!.getTimeSignatureValue() - noteLength
        
        for i in 0 ..< 10{
            let tempTimeValue = getNoteWithIndex(i).getNoteTimeValue()
            if restOfTimeLength < tempTimeValue{
                noteBtnArray[i].enabled = false
            }
            else{
                noteBtnArray[i].enabled = true
            }
        }
    }
    

    
    
    
}