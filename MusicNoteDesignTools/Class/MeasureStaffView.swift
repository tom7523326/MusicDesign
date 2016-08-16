//
//  MeasureStaffView.swift
//  MusicNoteDesignTools
//
//  Created by tangsl on 15/7/31.
//  Copyright (c) 2015年 tangsl. All rights reserved.
//

import UIKit
import AVFoundation

class MeasureStaffView:UIView {
    
    // MARK: ——————————————instance—————————————————
    var staffType :STAFF_TYPE? = STAFF_TYPE.normalStaff
    var staffOrigin :CGPoint?
    var leftMargin :CGFloat = 0
    var staffWidth :CGFloat = 0
    var highlightState :Bool = false
    var selectState :Bool = false
    var noteSpacing :CGFloat = 0
    var musicMeasure :MusicMeasure?
    var leftTopView :UIView?
    var rightTopView :UIView?
    var staffBackView :UIButton?
    var selectBtn :UIButton?
    var noteViewArray :[UIImageView]! = [UIImageView]()
    var delegate :MeasureStaffViewDelegate?
    
    
    // MARK: ——————————————system method—————————————————
    init(frame: CGRect,sType :STAFF_TYPE,measure :MusicMeasure) {
        super.init(frame: frame)
        //set bg image
        self.backgroundColor = UIColor.clearColor()
        staffType = sType
        musicMeasure = measure
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    // MARK: draw miscal line method
    override func drawRect(rect: CGRect) {
        
        staffWidth = self.bounds.width
        
        // set context detail
        let context = UIGraphicsGetCurrentContext()
        if staffType!.isNormal(){
            CGContextSetLineWidth(context, STAFF_LINE_HEIGHT)
        }
        else
        {
            CGContextSetLineWidth(context, RHYTHM_LINE_HEIGHT)
        }
        let colorSpace = CGColorSpaceCreateDeviceRGB()
        let components: [CGFloat] = [0.0, 0.0, 0.0, 1.0]
        let color = CGColorCreate(colorSpace, components)
        CGContextSetStrokeColorWithColor(context, color)
        
        // draw horizontal line
        if staffType!.isNormal(){
            for i in 0..<5 {
                let staffTop:CGFloat = FIRST_STAFF_TOP + (STAFF_SPACING + STAFF_LINE_HEIGHT) * CGFloat(i)
                CGContextMoveToPoint(context, leftMargin, staffTop)
                CGContextAddLineToPoint(context, leftMargin + staffWidth, staffTop)
            }
        }
        else{
            let staffTop:CGFloat = FIRST_STAFF_TOP + (STAFF_SPACING + STAFF_LINE_HEIGHT) * CGFloat(2)
            CGContextMoveToPoint(context, leftMargin, staffTop)
            CGContextAddLineToPoint(context, leftMargin + staffWidth, staffTop)
        }
        
        // draw vertical line
        let staffTop:CGFloat = FIRST_STAFF_TOP + (STAFF_SPACING + STAFF_LINE_HEIGHT) * 4
//        CGContextMoveToPoint(context, leftMargin, FIRST_STAFF_TOP)
//        CGContextAddLineToPoint(context, leftMargin, staffTop)
        CGContextMoveToPoint(context, self.bounds.width-STAFF_LINE_HEIGHT, FIRST_STAFF_TOP)
        CGContextAddLineToPoint(context, self.bounds.width-STAFF_LINE_HEIGHT, staffTop)
        
        
        CGContextStrokePath(context)
        
        
        
        
        if staffType!.isFirstMeasure()
        {
            //show clef image
            let clefView:UIImageView = UIImageView(frame: CGRectMake(0, 0, 70, 158))
            clefView.image = UIImage(named: "Note_G_Clef")
            leftMargin = CLEF_MARGIN
            staffWidth -= CLEF_MARGIN
            self.addSubview(clefView)
            
            if staffType!.isFirstLineFirstMeasure() {
                
                //show time signature
                let timeSignatureView:UIImageView = UIImageView(frame: CGRectMake(70, FIRST_STAFF_TOP, 37, 88))
                timeSignatureView.image = musicMeasure?.delegate.getTimeSignatureImage()
                self .addSubview(timeSignatureView)
            }
        }
        
        //show note image
        self.showNoteImage()
        
        if staffType!.isNormal(){
            
            staffBackView = UIButton(frame:CGRectMake(leftMargin, FIRST_STAFF_TOP, staffWidth, (STAFF_SPACING + STAFF_LINE_HEIGHT) * CGFloat(4)))
            staffBackView?.addTarget(self, action:#selector(MeasureStaffView.selectBtnClickMethod(_:)) , forControlEvents: UIControlEvents.TouchUpInside)
            staffBackView?.alpha = 0.3
            self.addSubview(staffBackView!)
            staffBackView?.backgroundColor = UIColor.yellowColor()
            staffBackView?.hidden = !highlightState
            
            
            selectBtn = UIButton(frame: CGRectMake(0, 0, 44, 44))
            selectBtn?.center = staffBackView!.center
            selectBtn?.setImage(UIImage(named: "midbtn_select"), forState: UIControlState.Normal)
            selectBtn?.addTarget(self, action: #selector(MeasureStaffView.selectBtnClickMethod(_:)), forControlEvents: UIControlEvents.TouchUpInside)
            self.addSubview(selectBtn!)
            selectBtn?.hidden = !highlightState
            
            let singleTap = UITapGestureRecognizer(target: self, action: #selector(MeasureStaffView.singleTapClick))
            singleTap.numberOfTouchesRequired = 1
            singleTap.numberOfTapsRequired = 1
            addGestureRecognizer(singleTap)
            
            let doubleTap = UITapGestureRecognizer(target: self, action: #selector(MeasureStaffView.doubleTapClick))
            doubleTap.numberOfTouchesRequired = 1
            doubleTap.numberOfTapsRequired = 2
            addGestureRecognizer(doubleTap)
            
            singleTap.requireGestureRecognizerToFail(doubleTap)
        }
        
    }
    
    
    // MARK: ——————————————business method—————————————————
    
    func drawNormalRect(){
        
    }
    
    
    func hilightStaffView(staffState :Bool)
    {
        if (staffState == false)
        {
            highlightState = false
            selectState = false
            selectBtn?.setImage(UIImage(named: "midbtn_select"), forState: UIControlState.Normal)
            selectBtn?.hidden = true
            staffBackView?.hidden = true
            rightTopView?.removeFromSuperview()
            leftTopView?.removeFromSuperview()
        }
        else
        {
            highlightState = true
            selectBtn?.hidden = false
            staffBackView?.hidden = false
        }
    }
    
    func selectBtnClickMethod(sender: AnyObject){
        if(selectState == false){
            selectState = true
            selectBtn?.setImage(UIImage(named: "midbtn_select_se"), forState: UIControlState.Normal)
            self.showAddBtn()
            delegate?.addSelectIndex(musicMeasure!.measureIndex)
        }
        else{
            selectState = false
            selectBtn?.setImage(UIImage(named: "midbtn_select"), forState: UIControlState.Normal)
            leftTopView?.removeFromSuperview()
            rightTopView?.removeFromSuperview()
            delegate?.removeSelectIndex(musicMeasure!.measureIndex)
        }
    }
    
    func startPlay(){
        for i in 0 ..< musicMeasure!.noteArray.count{
            if(!delegate!.getPlayState()){
                return
            }
            
            let note = musicMeasure!.noteArray[i]
            
            let dispatchQueue: dispatch_queue_t = dispatch_get_main_queue()
            var player : AVAudioPlayer! = nil
            
            dispatch_async(dispatchQueue, { () -> Void in
                if self.staffType!.isNormal(){
                    self.noteViewArray[i].image = note.getNoteHilightImage()
                }
                else{
                    self.noteViewArray[i].image = note.getRhythmHilightImage()
                }
                
                if !note.noteType.isRest(){
                    let path :String?
                    if self.staffType!.isNormal(){
                        path = NSBundle.mainBundle().pathForResource(note.getNoteWavFileName(), ofType:"wav")
                    }
                    else{
                        path = NSBundle.mainBundle().pathForResource(NOTE_SCALE.b1.getNoteWavName(), ofType:"wav")
                    }
                    let fileURL = NSURL(fileURLWithPath: path!)
                    player = try? AVAudioPlayer(contentsOfURL: fileURL)
                    player.prepareToPlay()
                    player.play()
                }
            })
            usleep(UInt32(musicMeasure!.getNotePlayTime()*1000000*note.getNoteTimeValue()))
            dispatch_async(dispatchQueue, { () -> Void in
                if self.staffType!.isNormal(){
                self.noteViewArray[i].image = note.getNoteImage()
                }
                else{
                self.noteViewArray[i].image = note.getRhythmImage()
                }
                if !note.noteType.isRest(){
                    player.stop()
                }
            })
            
            
        }
        
    }
    // MARK: -----------gesture res methods------------------
    
    func singleTapClick(){
        
        if highlightState{
            delegate!.exitEditState()
        }
        else{
            delegate!.showMeasureDetail(musicMeasure!)
        }
    }
    
    func doubleTapClick(){
        delegate!.startEditState()
    }
    
    // MARK: ——————————————view change res method—————————————————
    func showNoteImage(){
        let noteCount =  musicMeasure?.noteArray.count
        noteSpacing = (staffWidth - CGFloat(noteCount!) *  NOTE_WIDTH) / CGFloat(noteCount!)
        noteViewArray.removeAll(keepCapacity: false)
        
       
        
        
        
        for i in 0 ..< musicMeasure!.noteArray.count{
             var noteOriginY :CGFloat
            let image :UIImage
            if staffType!.isNormal(){
                image = musicMeasure!.noteArray[i].getNoteImage()
                noteOriginY = musicMeasure!.noteArray[i].getNoteScaleHeightValue()
            }
            else{
                image = musicMeasure!.noteArray[i].getRhythmImage()
                noteOriginY = musicMeasure!.noteArray[i].getRhythmNoteScaleHeightValue()
            }
            let noteView :UIImageView = UIImageView(frame:CGRectMake(leftMargin+(noteSpacing + NOTE_WIDTH) * CGFloat(i),noteOriginY, NOTE_WIDTH, NOTE_HEIGHT))
            noteView.image = image
            noteViewArray.append(noteView)
            self.addSubview(noteView)
            if staffType!.isNormal(){
                MusicUtils.addLineToNoteView(noteView, note: musicMeasure!.noteArray[i])
            }
        }
    }
    
    func showAddBtn(){
        if(delegate!.isHasCopyItem())
        {
            leftTopView = UIView(frame: CGRectMake(0, 0, 78, 44))
            addSubview(leftTopView!)
            rightTopView = UIView(frame: CGRectMake(bounds.width-78, 0, 78, 44))
            addSubview(rightTopView!)
            
            let leftAddBtn  = UIButton(frame: CGRectMake(0, 0, 39, 44))
            leftAddBtn.setImage(UIImage(named: "midbtn_addmeasure_half"), forState:UIControlState.Normal)
            leftAddBtn.setImage(UIImage(named: "midbtn_addmeasure_half_se"), forState: UIControlState.Highlighted)
            leftAddBtn.addTarget(self, action: #selector(MeasureStaffView.addLeftMeasure), forControlEvents: UIControlEvents.TouchUpInside)
            leftTopView!.addSubview(leftAddBtn)
            
            let rightAddBtn  = UIButton(frame: CGRectMake(0, 0, 39, 44))
            rightAddBtn.setImage(UIImage(named: "midbtn_addmeasure_half"), forState:UIControlState.Normal)
            rightAddBtn.setImage(UIImage(named: "midbtn_addmeasure_half_se"), forState: UIControlState.Highlighted)
            rightAddBtn.addTarget(self, action: #selector(MeasureStaffView.addRightMeasure), forControlEvents: UIControlEvents.TouchUpInside)
            rightTopView!.addSubview(rightAddBtn)
            
            let leftCopyBtn  = UIButton(frame: CGRectMake(40, 0, 39, 44))
            leftCopyBtn.setImage(UIImage(named: "midbtn_edit_measure_half"), forState:UIControlState.Normal)
            leftCopyBtn.setImage(UIImage(named: "midbtn_edit_measure_half_se"), forState: UIControlState.Highlighted)
            leftCopyBtn.addTarget(self, action: #selector(MeasureStaffView.copyToleft), forControlEvents: UIControlEvents.TouchUpInside)
            leftTopView!.addSubview(leftCopyBtn)
            
            let rightCopyBtn  = UIButton(frame: CGRectMake(40, 0, 39, 44))
            rightCopyBtn.setImage(UIImage(named: "midbtn_edit_measure_half"), forState:UIControlState.Normal)
            rightCopyBtn.setImage(UIImage(named: "midbtn_edit_measure_half_se"), forState: UIControlState.Highlighted)
            rightCopyBtn.addTarget(self, action: #selector(MeasureStaffView.copyToRight), forControlEvents: UIControlEvents.TouchUpInside)
            rightTopView!.addSubview(rightCopyBtn)
        }
        else{
            let leftAddBtn  = UIButton(frame: CGRectMake(0, 0, 44, 44))
            leftAddBtn.setImage(UIImage(named: "midbtn_addmeasure"), forState:UIControlState.Normal)
            leftAddBtn.setImage(UIImage(named: "midbtn_addmeasure_se"), forState: UIControlState.Highlighted)
            leftAddBtn.addTarget(self, action: #selector(MeasureStaffView.addLeftMeasure), forControlEvents: UIControlEvents.TouchUpInside)
            self.addSubview(leftAddBtn)
            
            let rightAddBtn  = UIButton(frame: CGRectMake(bounds.width-44, 0, 44, 44))
            rightAddBtn.setImage(UIImage(named: "midbtn_addmeasure"), forState:UIControlState.Normal)
            rightAddBtn.setImage(UIImage(named: "midbtn_addmeasure_se"), forState: UIControlState.Highlighted)
            rightAddBtn.addTarget(self, action: #selector(MeasureStaffView.addRightMeasure), forControlEvents: UIControlEvents.TouchUpInside)
            self.addSubview(rightAddBtn)
            
            leftTopView = leftAddBtn
            rightTopView = rightAddBtn
        }
    }
    
    
    
    // MARK: ——————————————delegate method—————————————————
    func addLeftMeasure(){
        delegate?.addEmptyMeasureWithIndex(musicMeasure!.measureIndex)
    }
    
    func addRightMeasure(){
        delegate?.addEmptyMeasureWithIndex(musicMeasure!.measureIndex + 1)
    }
    
    func copyToleft(){
        delegate?.addCopyItemWithIndex(musicMeasure!.measureIndex)
    }
    
    func copyToRight(){
        delegate?.addCopyItemWithIndex(musicMeasure!.measureIndex+1)
    }
}
