//
//  MusicMeasureEntity.swift
//  MusicNoteDesignTools
//
//  Created by tangsl on 15/7/27.
//  Copyright (c) 2015年 tangsl. All rights reserved.
//

import UIKit

class MusicMeasure :NSObject,NSMutableCopying{
    
    required init(nArray: [MusicNote]) {
        noteArray = nArray
    }
    
    var staffLineIndex:Int!
    
    var noteArray:[MusicNote]! = nil
    
    var delegate:MusicMeasureDelegate! = nil
    
    var measureIndex: Int = 0
    
    func getShowlength() ->CGFloat{
    
        if noteArray.count <= delegate.timeSignature.rawValue
        {
            return 1
        }
        else
        {
            return 1/CGFloat(delegate.timeSignature.rawValue)*CGFloat(noteArray.count)
        }
    }
    
    func getNotePlayTime() -> Float{
        return Float(60) / Float(delegate.songSpeed) * Float(delegate.timeSignature.getSignatureCount())
    }
    
    func getTimeSignatureValue() -> Float{
       return 1 / Float(delegate.timeSignature.getSignatureCount()) * Float(delegate.timeSignature.rawValue)
    }
    
    func mutableCopyWithZone(zone: NSZone) -> AnyObject{
        var tempNoteArray :[MusicNote]! = [MusicNote]()
        for note in noteArray{
            tempNoteArray.append(note.mutableCopy() as! MusicNote)
        }
        let theCopy : MusicMeasure = self.dynamicType.init(nArray: tempNoteArray)
        theCopy.delegate = delegate
        
        return theCopy
    }
    
    func turnToJsonString() -> String{
        var noteStringArray :[String] = [String]()
        for note in noteArray{
            noteStringArray.append(note.turnToJsonString())
        }
        let jsonObj :JSON = JSON(noteStringArray)
        return jsonObj.description
    }
    
    class func getObjectWithString(string :String) -> MusicMeasure?{
        if let dataFromString = string.dataUsingEncoding(NSUTF8StringEncoding, allowLossyConversion: false) {
            let json = JSON(data: dataFromString)
            var noteArray :[MusicNote] = [MusicNote]()
            for (_, subJson): (String, JSON) in json {
                noteArray.append(MusicNote.getObjectWithString(subJson.stringValue)!)
            }
            return MusicMeasure(nArray: noteArray)
        }
        return nil
    }
}
