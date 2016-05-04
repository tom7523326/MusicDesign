//
//  MusicStorage.swift
//  MusicNoteDesignTools
//
//  Created by tangsl on 15/7/31.
//  Copyright (c) 2015年 tangsl. All rights reserved.
//

import UIKit

class MusicStorage {
    class func simulateTestData()->MusicSong
    {
//       return MusicStorage.load1()!
       return MusicStorage.simulateTestData2()
    }
    
    class func simulateTestData1()->MusicSong
    {
        let measureArray:[MusicMeasure] = [self.simulateTestMeasure(),self.simulateEmptyMeasure(),self.simulateTestMeasure4(),self.simulateTestMeasure1(),self.simulateTestMeasure(),self.simulateTestMeasure2(),self.simulateTestMeasure(),self.simulateTestMeasure3(),self.simulateTestMeasure(),self.simulateTestMeasure(),self.simulateTestMeasure4(),self.simulateTestMeasure(),self.simulateTestMeasure1(),self.simulateTestMeasure(),self.simulateTestMeasure(),self.simulateTestMeasure(),self.simulateTestMeasure2(),self.simulateTestMeasure(),self.simulateTestMeasure(),self.simulateTestMeasure(),self.simulateTestMeasure2(),self.simulateTestMeasure(),self.simulateTestMeasure(),]
        let song = MusicSong(mArray: measureArray, speed: 80, name: "大鹿", signature: TIME_SIGNATURE.fourFourTime)
        
        for measure in song.measureArray{
            measure.delegate = song;
        }

        
        return song
    }
    
    class func simulateTestData2()->MusicSong
    {
        let measureArray:[MusicMeasure] = [self.simulateEmptyMeasure(),self.simulateEmptyMeasure(),self.simulateEmptyMeasure(),self.simulateEmptyMeasure(),self.simulateEmptyMeasure(),self.simulateEmptyMeasure(),self.simulateEmptyMeasure(),self.simulateEmptyMeasure(),self.simulateEmptyMeasure(),self.simulateEmptyMeasure(),self.simulateEmptyMeasure(),self.simulateEmptyMeasure(),self.simulateEmptyMeasure(),self.simulateEmptyMeasure(),self.simulateEmptyMeasure(),self.simulateEmptyMeasure(),]
        let song = MusicSong(mArray: measureArray, speed: 80, name: "新乐谱", signature: TIME_SIGNATURE.fourFourTime)
        
        for measure in song.measureArray{
            measure.delegate = song;
        }
        
        
        return song
    }
    
    class func simulateTestMeasure() -> MusicMeasure
    {
        let note1:MusicNote = MusicNote(type: NOTE_TYPE.noteQuarterNote, scale: NOTE_SCALE.a2)
        let note2:MusicNote = MusicNote(type: NOTE_TYPE.noteQuarterNote, scale: NOTE_SCALE.c1)
        let note3:MusicNote = MusicNote(type: NOTE_TYPE.noteQuarterNote, scale: NOTE_SCALE.b)
        let note4:MusicNote = MusicNote(type: NOTE_TYPE.noteQuarterNote, scale: NOTE_SCALE.e2)
        
        let measure:MusicMeasure = MusicMeasure(nArray: [note1,note2,note3,note4])
        
        return measure
    }
    class func simulateTestMeasure1() -> MusicMeasure
    {
        let note1:MusicNote = MusicNote(type: NOTE_TYPE.noteWholeNote, scale: NOTE_SCALE.g2)
        
        let measure:MusicMeasure = MusicMeasure(nArray: [note1])
        
        return measure
    }
    class func simulateTestMeasure2() -> MusicMeasure
    {
        let note1:MusicNote = MusicNote(type: NOTE_TYPE.noteQuarterNote, scale: NOTE_SCALE.a1)
        let note2:MusicNote = MusicNote(type: NOTE_TYPE.noteSixteenthNote, scale: NOTE_SCALE.c2)
        let note3:MusicNote = MusicNote(type: NOTE_TYPE.noteSixteenthNote, scale: NOTE_SCALE.d1)
        let note4:MusicNote = MusicNote(type: NOTE_TYPE.noteEighthNote, scale: NOTE_SCALE.b)
        let note5:MusicNote = MusicNote(type: NOTE_TYPE.noteHalfNote, scale: NOTE_SCALE.c1)
        let measure:MusicMeasure = MusicMeasure(nArray: [note1,note2,note3,note4,note5])
        
        return measure
    }
    class func simulateTestMeasure3() -> MusicMeasure
    {
        let note2:MusicNote = MusicNote(type: NOTE_TYPE.noteHalfNoteDotted, scale: NOTE_SCALE.c1)
        let note4:MusicNote = MusicNote(type: NOTE_TYPE.noteEighthNoteDotted, scale: NOTE_SCALE.e2)
        
        let measure:MusicMeasure = MusicMeasure(nArray: [note2,note4])
        
        return measure
    }
    class func simulateTestMeasure4() -> MusicMeasure
    {
        let note1:MusicNote = MusicNote(type: NOTE_TYPE.noteQuarterNote, scale: NOTE_SCALE.a1)
        let note2:MusicNote = MusicNote(type: NOTE_TYPE.noteQuarterNote, scale: NOTE_SCALE.c1)
        let note3:MusicNote = MusicNote(type: NOTE_TYPE.noteHalfNote, scale: NOTE_SCALE.b)
        
        let measure:MusicMeasure = MusicMeasure(nArray: [note1,note2,note3])
        
        return measure
    }
    class func simulateEmptyMeasure() -> MusicMeasure{
        let measure :MusicMeasure = MusicMeasure(nArray: [MusicNote]())
        
        return measure
    }
    
    
    //MARK: -------------save and load method-------------------
    class func save(tsong :MusicSong){
        var paths = NSSearchPathForDirectoriesInDomains(NSSearchPathDirectory.DocumentDirectory, NSSearchPathDomainMask.UserDomainMask, true)
        print(paths)
        //设定路径
        let url: NSURL = NSURL(fileURLWithPath: paths[0] + "/\(tsong.songName).txt")
        
        //定义可变数据变量
        let data = NSMutableData()
        //向数据对象中添加文本，并制定文字code
        data.appendData(tsong.turnToJsonString().dataUsingEncoding(NSUTF8StringEncoding, allowLossyConversion: true)!)
        //用data写文件
        data.writeToFile(url.path!, atomically: true)
    }
    
    class func load() -> MusicSong? {
        var paths = NSSearchPathForDirectoriesInDomains(NSSearchPathDirectory.DocumentDirectory, NSSearchPathDomainMask.UserDomainMask, true)
        print(paths)
        //设定路径
        let url: NSURL = NSURL(fileURLWithPath: paths[0] + "/song.txt")
        //从url里面读取数据，读取成功则赋予readData对象，读取失败则走else逻辑
        if let readData = NSData(contentsOfFile: url.path!) {
            //如果内容存在 则用readData创建文字列
            return MusicSong.getObjectWithString(NSString(data: readData, encoding: NSUTF8StringEncoding)! as String)
        } else {
            //nil的话，输出空
            return nil
        }
        
    }
    
    class func load1() -> MusicSong? {
        let path = NSBundle.mainBundle().pathForResource("song", ofType:"txt")
        //设定路径
        let url = NSURL(fileURLWithPath: path!)
        //从url里面读取数据，读取成功则赋予readData对象，读取失败则走else逻辑
        if let readData = NSData(contentsOfFile: url.path!) {
            //如果内容存在 则用readData创建文字列
            return MusicSong.getObjectWithString(NSString(data: readData, encoding: NSUTF8StringEncoding)! as String)
        } else {
            //nil的话，输出空
            return nil
        }
        
    }
    class func addNewSongWithName(songName :String,timeSignature :TIME_SIGNATURE) -> MusicSong{

        let measureArray:[MusicMeasure] = [self.simulateEmptyMeasure(),simulateEmptyMeasure(),simulateEmptyMeasure(),simulateEmptyMeasure(),simulateEmptyMeasure(),simulateEmptyMeasure(),simulateEmptyMeasure(),simulateEmptyMeasure(),simulateEmptyMeasure(),simulateEmptyMeasure(),simulateEmptyMeasure()]
        let song = MusicSong(mArray: measureArray, speed: 80, name:songName, signature:timeSignature)
        
        for measure in song.measureArray{
            measure.delegate = song;
        }
        
        return song
    }
    
    class func getAllSongName() -> [String]?{
        var paths = NSSearchPathForDirectoriesInDomains(NSSearchPathDirectory.DocumentDirectory, NSSearchPathDomainMask.UserDomainMask, true)
        print(paths)
        //设定路径
        var error :NSError?
        var fileNameArray :[AnyObject]?
        do {
            fileNameArray = try NSFileManager.defaultManager().contentsOfDirectoryAtPath(paths[0] )
        } catch let error1 as NSError {
            error = error1
            fileNameArray = nil
        }
        if error == nil {
            var finalArray :[String] = [String]()
            for i in 0 ..< fileNameArray!.count {
                let fileName: String? = fileNameArray![i] as? String
                if ((fileName)! as NSString).pathExtension == "txt"{
                    finalArray.append((fileName! as NSString).stringByDeletingPathExtension)
                }
            }
            
            return finalArray
        }
        
        return nil
    }
    
    class  func getMusicSongWithSongName(songName :String) ->MusicSong?{
        var paths = NSSearchPathForDirectoriesInDomains(NSSearchPathDirectory.DocumentDirectory, NSSearchPathDomainMask.UserDomainMask, true)
        print(paths)
        //设定路径
        let url: NSURL = NSURL(fileURLWithPath: paths[0] + "/\(songName).txt")
        //从url里面读取数据，读取成功则赋予readData对象，读取失败则走else逻辑
        if let readData = NSData(contentsOfFile: url.path!) {
            //如果内容存在 则用readData创建文字列
            return MusicSong.getObjectWithString(NSString(data: readData, encoding: NSUTF8StringEncoding)! as String)
        } else {
            //nil的话，输出空
            return nil
        }
    }
    class func deleteSongWithSongName(songName :String){
        var paths = NSSearchPathForDirectoriesInDomains(NSSearchPathDirectory.DocumentDirectory, NSSearchPathDomainMask.UserDomainMask, true)
        print(paths)
        //设定路径
        let url: NSURL = NSURL(fileURLWithPath: paths[0] + "/\(songName).txt")
        do {
            try NSFileManager.defaultManager().removeItemAtURL(url)
        } catch _ {
        }
    }
}

