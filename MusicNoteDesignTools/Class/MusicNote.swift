//
//  MusicNoteEntity.swift
//  MusicNoteDesignTools
//
//  Created by tangsl on 15/7/27.
//  Copyright (c) 2015年 tangsl. All rights reserved.
//

import UIKit



class MusicNote:NSObject,NSMutableCopying{
    
    //! music note type
    var noteType   :NOTE_TYPE!
    //! music note scale
    var noteScale  :NOTE_SCALE!
    
    
     required init(type: NOTE_TYPE,scale: NOTE_SCALE) {
        noteType = type
        noteScale = scale
    }
    
    func getNoteTimeValue() -> Float{
        return noteType.getTimeValue()
    }
    
    func getNoteImage() -> UIImage{
        if(noteScale.rawValue <= 6 && !noteType.isRest()){
            return noteType.getConversionImage()
        }
        else{
            return noteType.getImage()
        }
    }
    
    func getRhythmImage() -> UIImage{
        if(!noteType.isRest()){
            return noteType.getConversionImage()
        }
        else{
            return noteType.getImage()
        }
    }
    
    func getNoteHilightImage() ->UIImage{
        if(noteScale.rawValue <= 6 && !noteType.isRest()){
            return noteType.getConversionImageSe()
        }
        else{
            return noteType.getImageSe()
        }
    }
    
    func getRhythmHilightImage() -> UIImage{
        if(!noteType.isRest()){
            return noteType.getConversionImageSe()
        }
        else{
            return noteType.getImageSe()
        }
    }
    

    
    func getNoteWavFileName() -> String{
        return noteScale.getNoteWavName()
    }
    
    
    func getNoteScaleHeightValue() ->CGFloat{
        if !noteType.isRest(){
            return (STAFF_SPACING + STAFF_LINE_HEIGHT) / CGFloat(2) * CGFloat(noteScale.rawValue) - getCircleY() 
        }
        else{
            return (STAFF_HEIGHT - NOTE_HEIGHT - STAFF_SPACING - STAFF_LINE_HEIGHT)/2
        }
    }
    
    func getRhythmNoteScaleHeightValue() -> CGFloat{
        if !noteType.isRest(){
            return (STAFF_SPACING + STAFF_LINE_HEIGHT) / CGFloat(2) * CGFloat(NOTE_SCALE.b1.rawValue) - noteType.getCricleConverseY()
        }
        else{
            return (STAFF_HEIGHT - NOTE_HEIGHT - STAFF_SPACING - STAFF_LINE_HEIGHT)/2
        }
    }
    
    func getCircleY() -> CGFloat{
        if(noteScale.rawValue > 6){
            return noteType.getCricleY()
        }
        else{
            return noteType.getCricleConverseY()
        }
    }
    
    func mutableCopyWithZone(zone: NSZone) -> AnyObject{
        let theCopy = self.dynamicType.init(type: noteType, scale: noteScale)
        
        return theCopy
    }
    
    func getLineMargin() ->CGFloat{
        if(noteScale.rawValue > 6){
            return noteType.getLineMargin() - 2
        }
        else{
            return noteType.getLineConverseMargin() - 2
        }
    }
    
    func turnToJsonString() -> String{
        let jsonObj :JSON = JSON([noteType.rawValue,noteScale.rawValue])
        return jsonObj.description
    }
    
    class func getObjectWithString(string :String) -> MusicNote?{
        if let dataFromString = string.dataUsingEncoding(NSUTF8StringEncoding, allowLossyConversion: false) {
            let json = JSON(data: dataFromString)
             return MusicNote(type: NOTE_TYPE(rawValue:json[0].intValue)!,scale: NOTE_SCALE(rawValue:json[1].intValue)!)
        }
       return nil
    }
    
    
}
