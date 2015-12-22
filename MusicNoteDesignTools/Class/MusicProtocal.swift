//
//  MusicProtocal.swift
//  MusicNoteDesignTools
//
//  Created by tangsl on 15/7/24.
//  Copyright (c) 2015年 tangsl. All rights reserved.
//

import UIKit


protocol MainViewTopViewDelegate{
    func playBtnClickMethod(sender :AnyObject)
    func addBtnClickMethod()
    func saveBtnClickMethod()
    func setBtnClickMethod()
    func switchClickMethod(sender :AnyObject)
    func tableClickMethod()
}
protocol EditVIewTopViewDelegate{
    func playBtnClickMethod()
    func cleanBtnClickMethod()
    func backBtnClickMethod()
}

protocol EditMainViewControllerDelegate{
    func backBtnClickMethod()
}

protocol MusicMeasureDelegate{
    var timeSignature :TIME_SIGNATURE!{get}
    var songSpeed: Int!{get}
    func getTimeSignatureImage() -> UIImage

}

protocol SongShowViewDelegate{
    func getSong()->MusicSong
    func exitEditState()
}

protocol MeasureStaffViewDelegate{
    func addEmptyMeasureWithIndex(index :Int)
    func addCopyItemWithIndex(index :Int)
    func addSelectIndex(sIndex :Int)
    func removeSelectIndex(sIndex :Int)
    func isHasCopyItem()->Bool
    func showMeasureDetail(measure :MusicMeasure)
    func startEditState()
    func exitEditState()
    func getPlayState() -> Bool
}

protocol MusicBottomExpertViewDelegate{
    func undoBtnClick()
    func redoBtnClick()
    func deleteBtnClick()
    func copyBtnClick()
    func cutBtnClick()
}

protocol MeasureEditViewDelegate{

}
protocol AddNewSongViewDelegate{
    func cancelBtnClick()
    func finishBtnClick(songName :String, timeSignature :TIME_SIGNATURE)
    func finishSetBtnClick(songName :String, songspeed :String)
}

protocol NoteKeyBtnDelegate{
    func noteKeyBtnClick(sender: NoteKeyBtn)
    func moveNoteToPosi(point :CGPoint,sender: NoteKeyBtn)
   func touchEndInPosi(point :CGPoint,sender: NoteKeyBtn)
}

protocol SongListShowViewControllerDelegate{
     func renewMusicSongWithSongName(songName :String)
    func removeSongListView()
    func deleteSongWithSongName(songName :String)
}