//
//  EditMainViewController.swift
//  MusicNoteDesignTools
//
//  Created by tangsl on 15/8/15.
//  Copyright (c) 2015年 tangsl. All rights reserved.
//

import UIKit
import AVFoundation

class EditMainViewController: UIViewController ,EditVIewTopViewDelegate,MeasureEditViewDelegate{
    
    var topView :EditVIewTopView!
    var delegate :EditMainViewControllerDelegate?
    var measureEditView :MeasureEditView?
    // MARK: ——————————————system method—————————————————
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: NSBundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        measureEditView = MeasureEditView(frame:CGRectMake(0, 0, VIEW_WIDTH, VIEW_HEIGHT))
        measureEditView!.delegate = self
        view = measureEditView
        
        
        //init top view
        topView = EditVIewTopView(frame: CGRectMake(0, 0, 1024, 152))
        topView.delegate = self;
        view.addSubview(topView)
    }
    
    
    
    //MARK : EditVIewTopViewDelegate method
    func playBtnClickMethod(){
        let dispatchQueue: dispatch_queue_t = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0)
        dispatch_async(dispatchQueue, { () -> Void in
            for i in 0 ..< self.measureEditView!.musicMeasure!.noteArray.count{
                
                if i < self.measureEditView!.musicMeasure!.noteArray.count{
                    let note = self.measureEditView!.musicMeasure!.noteArray[i]
                    
                    let dispatchQueue: dispatch_queue_t = dispatch_get_main_queue()
                    var player : AVAudioPlayer! = nil
                    
                    dispatch_async(dispatchQueue, { () -> Void in
                        self.measureEditView!.lineNoteBtnArray[i].setImage(note.getNoteHilightImage(), forState: UIControlState.Normal)
                        if !note.noteType.isRest(){
                            let path = NSBundle.mainBundle().pathForResource(note.getNoteWavFileName(), ofType:"wav")
                            let fileURL = NSURL(fileURLWithPath: path!)
                            player = try? AVAudioPlayer(contentsOfURL: fileURL)
                            player.prepareToPlay()
                            player.play()
                        }
                    })
                    usleep(UInt32(self.measureEditView!.musicMeasure!.getNotePlayTime()*1000000*note.getNoteTimeValue()))
                    dispatch_async(dispatchQueue, { () -> Void in
                        if i < self.measureEditView!.musicMeasure!.noteArray.count{
                            self.measureEditView!.lineNoteBtnArray[i].setImage(note.getNoteImage(), forState: UIControlState.Normal)
                        }
                        if !note.noteType.isRest(){
                            player.stop()
                        }
                    })
                }
            }
        })
    }
    
    func cleanBtnClickMethod(){
        measureEditView!.musicMeasure!.noteArray.removeAll(keepCapacity: false)
        measureEditView!.showAllNote()
        measureEditView!.checkCanUseNote()
        
    }
    
    func backBtnClickMethod(){
        delegate!.backBtnClickMethod()
    }
    
    func showMeasureViewWithMeasure(measure : MusicMeasure){
        measureEditView!.musicMeasure = measure
        measureEditView!.showAllNote()
        measureEditView!.checkCanUseNote()
    }
    
    
    
}
