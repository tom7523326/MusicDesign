//
//  MainViewController.swift
//  MusicNoteDesignTools
//
//  Created by tangsl on 15/7/23.
//  Copyright (c) 2015年 tangsl. All rights reserved.
//

import UIKit



class MainViewController: UIViewController ,MainViewTopViewDelegate,SongShowViewDelegate,MeasureStaffViewDelegate,MusicBottomExpertViewDelegate,EditMainViewControllerDelegate,AddNewSongViewDelegate,SongListShowViewControllerDelegate{
    // MARK: ——————————————instance—————————————————
    var topView :MusicalTopView!
    var bottomView :UIView!
    var songShowView :SongShowView!
    var musicModel :MusicModel!
    var musicHandler :MusicHandler!
    var measureViewArray :[MeasureStaffView]! = [MeasureStaffView]()
    var editState :Bool = false
    var editController: EditMainViewController?
    var playState :Bool = false
    var isEditMeasure :Bool = false
    var isRhythmState :Bool = false
    var addview :AddNewSongView!
    var songListShowViewController :SongListShowViewController?
    
    
    // MARK: ——————————————system method—————————————————
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        musicModel = MusicModel()
        musicHandler = MusicHandler()
        musicHandler.musicModel = musicModel
    }
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: NSBundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        musicModel = MusicModel()
        musicHandler = MusicHandler()
        musicHandler.musicModel = musicModel
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        view.frame = CGRectMake(0, 0, VIEW_WIDTH, VIEW_HEIGHT);
        
        //init back image
        let image :UIImage! = UIImage(named: "bg_content")
        view.backgroundColor = UIColor(patternImage: image)
        
        //init top view
        topView = MusicalTopView()
        topView.delegate = self;
        view.addSubview(topView)
        
        //init bottom view
        bottomView = MusicBottomView(frame: CGRectMake(0,VIEW_HEIGHT - 165, VIEW_WIDTH, 165))
        view.addSubview(bottomView)
        
        
        
        //init mainview
        songShowView = SongShowView(frame: CGRectMake(0, 0, 0, 0),title: musicModel.song.songName,speed: musicModel.song.songSpeed)
        songShowView.songdelegate = self
        view.addSubview(songShowView)
        
        //            layout(topView,bottomExpertView,songShowView) { topView,bottomExpertView,songShowView in
        //                distribute(by: 0, vertically: topView, songShowView, bottomExpertView)
        //                align(left: topView, songShowView, bottomExpertView)
        //                topView.width == bottomExpertView.width
        //                bottomExpertView.width == songShowView.width
        //                songShowView.width == songShowView.superview!.width
        //                topView.height == 152
        //                bottomExpertView.height == 165
        //                topView.top == topView.superview!.top
        //                bottomExpertView.bottom == bottomExpertView.superview!.bottom
        //            }
        constrain(topView,songShowView) { topView,songShowView in
            distribute(by: 0, vertically: topView, songShowView)
            align(left: topView, songShowView)
            topView.width == songShowView.width
            songShowView.width == songShowView.superview!.width
            topView.height == 152
            songShowView.height == songShowView.superview!.height - 165 - 152
            topView.top == topView.superview!.top
        }
        self.showMeasureStaffView()
        
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: ——————————————topview delegate method—————————————————
    func playBtnClickMethod(sender :AnyObject){
        if playState == false
        {
            playState = true
            sender.setImage(UIImage(named: "topbtn_pause"), forState:UIControlState.Normal)
            sender.setImage(UIImage(named: "topbtn_pause_se"), forState:UIControlState.Highlighted)
            let dispatchQueue: dispatch_queue_t = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0)
            dispatch_async(dispatchQueue, { () -> Void in
                for measureView in self.measureViewArray{
                    if self.playState == true {
                        let dispatchMainQueue: dispatch_queue_t = dispatch_get_main_queue()
                        dispatch_async(dispatchMainQueue, { () -> Void in
                            self.songShowView.scrollRectToVisible(measureView.frame, animated: true)
                        })
                        measureView.startPlay()
                    }
                    else{
                        break
                    }
                }
                let dispatchMainQueue: dispatch_queue_t = dispatch_get_main_queue()
                dispatch_async(dispatchMainQueue, {() -> Void in
                    self.finishPlay(sender)
                })
            })
            
        }
        else
        {
            finishPlay(sender)
        }
    }
    func finishPlay(sender :AnyObject){
        playState = false
        sender.setImage(UIImage(named: "topbtn_play"), forState:UIControlState.Normal)
        sender.setImage(UIImage(named: "topbtn_play_se"), forState:UIControlState.Highlighted)
    }
    func addBtnClickMethod(){
        if editState{
            exitEditState()
        }
        if playState{
            finishPlay(topView.playbtn)
        }
        addview = AddNewSongView(frame: view.bounds,addOrSet: true)
        addview.delegate = self
        view.addSubview(addview)
        
    }
    func saveBtnClickMethod(){
        musicModel.save()
        let alertView = UIAlertView(title: "乐谱", message: "保存成功", delegate: self, cancelButtonTitle: "确定")
    
        alertView.show()
    }
    func setBtnClickMethod(){
        if editState{
            exitEditState()
        }
        if playState{
            finishPlay(topView.playbtn)
        }
        addview = AddNewSongView(frame: view.bounds,addOrSet: false)
        addview.delegate = self
        addview.speedTextFiled.text = "\(musicModel.song.songSpeed)"
        addview.nameTextField.text = "\(musicModel.song.songName)"
        view.addSubview(addview)
    }
    func switchClickMethod(sender :AnyObject){
        if editState{
            exitEditState()
        }
        if playState{
            finishPlay(topView.playbtn)
        }
        if(isRhythmState){
            isRhythmState = false
            sender.setImage(UIImage(named: "topbtn_swich"), forState: UIControlState.Normal)
            sender.setImage(UIImage(named: "topbtn_swich_se"), forState: UIControlState.Highlighted)
        }
        else{
            isRhythmState = true

            sender.setImage(UIImage(named: "topbtn_swichfinish"), forState: UIControlState.Normal)
            sender.setImage(UIImage(named: "topbtn_swichfinish_se"), forState: UIControlState.Highlighted)
        }
        showMeasureStaffView()
    }
    func tableClickMethod(){
        songListShowViewController = SongListShowViewController()
        songListShowViewController!.songNameArray = musicModel.getAllSongName()
        songListShowViewController!.mainViewDelegate = self
        songListShowViewController!.view.frame = view.bounds
        view.addSubview(songListShowViewController!.view)
    }
    
    // MARK: ——————————————business method—————————————————
    func editSongView(){
        for measureView in measureViewArray{
            measureView.hilightStaffView(editState)
        }
        
    }
    
    func addEmptyMeasureWithIndex(index :Int){
        musicModel.addEmptyMeasureWithIndex(index)
        self.showMeasureStaffView()
    }
    
    
    
    //generate staff staff index
    func getStaffCount() -> Int{
        return musicHandler.getStaffCount()
    }
    
    //show all measure
    func showMeasureStaffView(){
        for view in measureViewArray{
            view.removeFromSuperview()
        }
        songShowView.titleLable.text = musicModel.song.songName
        songShowView.speedLable.text = "\(musicModel.song.songSpeed)"
        measureViewArray = musicHandler.showMeasureStaffViewOnView(songShowView,isRhythm: isRhythmState)
        for view in measureViewArray{
            view.delegate = self
            view.highlightState = editState
        }
        
    }
    
    func checkBottomBtnState(){
        if editState{
            if musicModel.undoStack.count > 0{
                (bottomView as! MusicBottomExpertView).setUndoBtnEnableState(true)
            }
            else{
                (bottomView as! MusicBottomExpertView).setUndoBtnEnableState(false)
            }
            
            if musicModel.redoStack.count > 0{
                (bottomView as! MusicBottomExpertView).setRedoBtnEnableState(true)
            }
            else{
                (bottomView as! MusicBottomExpertView).setRedoBtnEnableState(false)
            }
            
            if musicModel.selectIndexArray.count > 0{
                (bottomView as! MusicBottomExpertView).setFuncBtnEnableState(true)
            }
            else{
                (bottomView as! MusicBottomExpertView).setFuncBtnEnableState(false)
            }
        }
    }
    
    
    // MARK: ——————————————MusicBottomExpertViewDelegate res—————————————————
    func undoBtnClick(){
        musicModel.undo()
        musicModel.emptySelectArray()
        showMeasureStaffView()
        checkBottomBtnState()
    }
    func redoBtnClick(){
        musicModel.redo()
        showMeasureStaffView()
        checkBottomBtnState()
    }
    func deleteBtnClick(){
        musicModel.deleteSelectArray()
        musicModel.emptySelectArray()
        showMeasureStaffView()
        checkBottomBtnState()
    }
    func copyBtnClick(){
        musicModel.copySelectArray()
        musicModel.emptySelectArray()
        showMeasureStaffView()
        checkBottomBtnState()
    }
    func cutBtnClick(){
        musicModel.cutSelectArray()
        musicModel.emptySelectArray()
        showMeasureStaffView()
        checkBottomBtnState()
    }
    
    
    
    // MARK: ——————————————SongShowViewDelegate res—————————————————
    //get model method
    func getSong() -> MusicSong{
        return musicModel.song
    }
    func exitEditState(){
        editState = false
        musicModel.emptyRedoStack()
        musicModel.emptySelectArray()
        musicModel.emptyUndoStack()
        musicModel.emptyCopyArray()
        bottomView.removeFromSuperview()
        bottomView = MusicBottomView(frame: CGRectMake(0,view.bounds.height - 165, 1024, 165))
        view.addSubview(bottomView)
        self.editSongView()
    }
    
    // MARK: ——————————————MeasureStaffViewDelegate res—————————————————
    func addSelectIndex(sIndex :Int){
        musicModel.addSelectIndex(sIndex)
        checkBottomBtnState()
    }
    func removeSelectIndex(sIndex :Int){
        musicModel.removeSelectIndex(sIndex)
        checkBottomBtnState()
    }
    func  isHasCopyItem()->Bool{
        return musicModel.isHasCopyItem()
    }
    func addCopyItemWithIndex(index :Int){
        musicModel.copyItemToIndex(index)
        musicModel.emptySelectArray()
        showMeasureStaffView()
    }
    func showMeasureDetail(measure :MusicMeasure){
        finishPlay(topView.playbtn)
        if editController == nil {
            editController?.view.removeFromSuperview()
            editController = nil
        }
        isEditMeasure = true
        editController = EditMainViewController()
        editController!.view.frame = CGRectMake(0, 0, VIEW_WIDTH, VIEW_HEIGHT)
        editController!.delegate = self
        self.view.addSubview(editController!.view)
        editController!.showMeasureViewWithMeasure(measure)
    }
    func startEditState(){
        if !editState{
        finishPlay(topView.playbtn)
        editState = true
        //init bottom expertview
        bottomView.removeFromSuperview()
        let bottomExpertView = MusicBottomExpertView(frame: CGRectMake(0,view.bounds.height - 165, 1024, 165))
        bottomExpertView.delegate = self
        view.addSubview(bottomExpertView)
        bottomView = bottomExpertView
        self.editSongView()
        }
        else{
            exitEditState()
        }
    }
    func getPlayState() -> Bool{
        return playState
    }
    
    // MARK: ----------------EditVIewTopViewDelegate res-------------------
    func backBtnClickMethod(){
        editController?.view.removeFromSuperview()
        
        editController = nil
        isEditMeasure = false
        
        showMeasureStaffView()
    }
    
    // MARK: ----------------AddNewSongViewDelegate------------------------
    func cancelBtnClick(){
        addview.removeFromSuperview()
    }
    func finishBtnClick(songName :String, timeSignature :TIME_SIGNATURE){
        addview.removeFromSuperview()
        var tSongName :String
        if songName.lengthOfBytesUsingEncoding(NSUTF8StringEncoding) == 0{
            tSongName = "新标题"
        }
        else{
            tSongName = songName
        }
        musicModel.addNewSongWithName(tSongName, timeSignature: timeSignature)
        showMeasureStaffView()
    }
    
    func finishSetBtnClick(songName :String, songspeed :String){
        addview.removeFromSuperview()
        var tSongName :String
        if songName.lengthOfBytesUsingEncoding(NSUTF8StringEncoding) == 0{
            tSongName = "新标题"
        }
        else{
            tSongName = songName
        }
        var spped :Int
        if Int(songspeed) != nil{
            spped = Int(songspeed)!
        }
        else{
            spped = 150
        }
        songShowView.titleLable.text = tSongName
        songShowView.speedLable.text = "\(spped)"
        musicModel.setSongWithName(tSongName, speed: spped)
    }
    
    //MARK: -----------SongListShowViewControllerDelegate--------------
    func renewMusicSongWithSongName(songName :String){
        musicModel.renewMusicSongWithSongName(songName)
        removeSongListView()
        showMeasureStaffView()
    }
    
    func removeSongListView(){
        songListShowViewController?.view.removeFromSuperview()
    }
    func deleteSongWithSongName(songName :String){
        musicModel.deleteSongWithSongName(songName)
    }
}