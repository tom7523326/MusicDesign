//
//  MusicSongEntity.swift
//  MusicNoteDesignTools
//
//  Created by tangsl on 15/7/27.
//  Copyright (c) 2015年 tangsl. All rights reserved.
//

import UIKit


class MusicSong :NSObject, MusicMeasureDelegate, NSMutableCopying{
    
    required init(mArray: [MusicMeasure],speed: Int,name :String,signature :TIME_SIGNATURE) {
        measureArray = mArray
        songSpeed = speed
        songName = name
        timeSignature = signature
    }
    var measureArray :[MusicMeasure]!
    var songSpeed: Int!
    var songName: String!
    var timeSignature :TIME_SIGNATURE!
    func getTimeSignatureImage() -> UIImage{
        return timeSignature.getImage()
    }
    
    func mutableCopyWithZone(zone: NSZone) -> AnyObject{
        var tempMeasureArray :[MusicMeasure]! = [MusicMeasure]()
        for measure in measureArray{
            tempMeasureArray.append(measure.mutableCopy() as! MusicMeasure)
        }
        let theCopy : MusicSong = self.dynamicType.init(mArray: tempMeasureArray, speed: songSpeed, name: songName, signature: timeSignature)
        
        return theCopy
    }
    
    func turnToJsonString() -> String{
        var measureStringArray :[String] = [String]()
        for measure in measureArray{
            measureStringArray.append(measure.turnToJsonString())
        }
        let jsonObj :JSON = JSON(measureStringArray)
        
        let dictionary = ["measureArray":jsonObj.description, "songSpeed":songSpeed, "songName":songName,  "timeSignature":timeSignature.rawValue]
        let json = JSON(dictionary)
        
        return json.description
    }
    
    class func getObjectWithString(string :String) -> MusicSong?{
        if let dataFromString = string.dataUsingEncoding(NSUTF8StringEncoding, allowLossyConversion: false) {
            let json = JSON(data: dataFromString)
            var tmeasureArray :[MusicMeasure]! = [MusicMeasure]()
            var tsongSpeed: Int!
            var tsongName: String!
            var ttimeSignature :TIME_SIGNATURE!
            for (key, subJson): (String, JSON) in json {
                if key == "songSpeed"{
                    tsongSpeed = subJson.intValue
                }
                if key == "songName"{
                    tsongName = subJson.stringValue
                }
                if key == "timeSignature"{
                    ttimeSignature = TIME_SIGNATURE(rawValue: subJson.intValue)
                }
                if key == "measureArray"{
                    if let tdataFromString = subJson.stringValue.dataUsingEncoding(NSUTF8StringEncoding, allowLossyConversion: false) {
                        let tjson = JSON(data:tdataFromString)
                        
                        for (_, subJson): (String, JSON) in tjson {
                            let measure = MusicMeasure.getObjectWithString(subJson.stringValue)
                            tmeasureArray.append(measure!)
                        }
                    }
                }
            }

            let song =  MusicSong(mArray: tmeasureArray, speed: tsongSpeed, name: tsongName, signature: ttimeSignature)
            for measure in song.measureArray{
                measure.delegate = song
            }
            return song
        }
        return nil
    }
}