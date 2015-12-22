//
//  MusicHandler.swift
//  MusicNoteDesignTools
//
//  Created by tangsl on 15/7/31.
//  Copyright (c) 2015年 tangsl. All rights reserved.
//

import UIKit


class MusicHandler{
    
    var musicModel :MusicModel!
    
    init() {
    }
    
    func getStaffCount() -> Int{
        var nowLIneLength :CGFloat = 0
        var nowStaffIndex = 0
        
        for i in 0 ..< musicModel.song.measureArray.count{
            let measure = musicModel.song.measureArray[i]
            measure.measureIndex = i
            if(nowLIneLength + measure.getShowlength() > PER_LINE_LENGTH){
                nowStaffIndex++
                nowLIneLength = 0
            }
            measure.staffLineIndex = nowStaffIndex
            nowLIneLength += measure.getShowlength()
        }
        
        return nowStaffIndex + 1
    }
    
    
    //得到本行的乐符图像数组
    func getNoteImageMasureArrayWithLineIndex(staffIndex :Int) -> [AnyObject]{
        var imageMasureArray = [AnyObject]()
        
        for measure in musicModel.song.measureArray{
            if(measure.staffLineIndex == staffIndex)
            {
                var imageArray = [UIImage]()
                for note in measure.noteArray{
                    imageArray.append(note.getNoteImage())
                }
                imageMasureArray.append(imageArray)
            }
        }
        
        return imageMasureArray
    }
    
    
    // get aim line measure array
    func getMeasureArrayWithLineIndex(staffindex :Int) -> ([MusicMeasure],Int){
        var meaSureArray = [MusicMeasure]()
        var noteCount :Int = 0
        
        for measure in musicModel.song.measureArray{
            if(measure.staffLineIndex == staffindex)
            {
                meaSureArray.append(measure)
                noteCount += Int(measure.getShowlength() * 4)
            }
        }
        
        return (meaSureArray,noteCount)
    }
    
    func showMeasureStaffViewOnView(aimView :UIScrollView ,isRhythm :Bool) -> [MeasureStaffView]{
        let staffCount = self.getStaffCount()
        var measureViewArray : [MeasureStaffView] = [MeasureStaffView]()
        aimView.contentSize = CGSizeMake(aimView.bounds.width, STAFF_HEIGHT * CGFloat(staffCount) + SONG_TITLE_HEIGHT)
        for i in 0 ..< staffCount{
            let (measureArray,noteCount) = self.getMeasureArrayWithLineIndex(i)
            var originX :CGFloat = STAFF_LEFT_MARGIN
            let originY = CGFloat(SONG_TITLE_HEIGHT) + STAFF_HEIGHT * CGFloat(i)
            for j in 0 ..< measureArray.count{
                let measure = measureArray[j]
                let noteMargin :CGFloat = (aimView.bounds.width - STAFF_LEFT_MARGIN * 2 - CLEF_MARGIN - CGFloat(noteCount) * NOTE_WIDTH)/CGFloat(noteCount + measureArray.count)
                var measureWith :CGFloat = (noteMargin + NOTE_WIDTH) * CGFloat(measure.getShowlength() * 4) + noteMargin
                let sType :STAFF_TYPE
                
                if(j == 0)
                {
                    measureWith += 110
                    if(i == 0){
                        if !isRhythm{
                            sType = STAFF_TYPE.normalStaffFirstStaffFirsetMeasure
                        }
                        else{
                            sType = STAFF_TYPE.rhythmStaffFirstStaffFirsetMeasure
                        }
                    }
                    else{
                        if !isRhythm{
                            sType = STAFF_TYPE.normalStaffFirstMeasure
                        }
                        else{
                            sType = STAFF_TYPE.rhythmStaffFirstMeasure
                        }
                    }
                }
                else
                {
                    if !isRhythm{
                        sType = STAFF_TYPE.normalStaff
                    }
                    else{
                        sType = STAFF_TYPE.rhythmStaff
                    }
                }
                
                let measureStaffView = MeasureStaffView(frame: CGRectMake(originX, originY, measureWith, STAFF_HEIGHT), sType: sType, measure: measure)
                originX += measureWith-1
                aimView.addSubview(measureStaffView)
                measureViewArray.append(measureStaffView)
            }
        }
        
        return measureViewArray
    }
    
}