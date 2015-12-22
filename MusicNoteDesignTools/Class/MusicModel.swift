//
//  MusicModel.swift
//  MusicNoteDesignTools
//
//  Created by tangsl on 15/7/31.
//  Copyright (c) 2015年 tangsl. All rights reserved.
//

import UIKit

class MusicModel{
    var song: MusicSong!
    var selectIndexArray :[Int]
    var tempCopyArray : [MusicMeasure]
    var undoStack : [MusicSong]
    var redoStack : [MusicSong]
    
    init() {
       
        if let tempSong = MusicStorage.load(){
            song = tempSong
        }
        else{
             song = MusicStorage.simulateTestData()
        }
        
        selectIndexArray = [Int]()
        tempCopyArray = [MusicMeasure]()
        undoStack = [MusicSong]()
        redoStack = [MusicSong]()
    }
    
// MARK: ----------empty res-----------------
    
    
    func emptyUndoStack(){
        undoStack.removeAll(keepCapacity: false)
    }
    
    func emptyRedoStack(){
        redoStack.removeAll(keepCapacity: false)
    }
    
    func emptySelectArray(){
        selectIndexArray.removeAll(keepCapacity: false)
    }
    
    func emptyCopyArray(){
        tempCopyArray.removeAll(keepCapacity: false)
    }
    


// MARK: ----------add res-----------------
    func addSelectIndex(sIndex :Int){
        for var i = 0; i < selectIndexArray.count; ++i{
            let tIndex = selectIndexArray[i]
            if tIndex == sIndex{
                return
            }
            
            if(tIndex > sIndex){
                selectIndexArray.insert(sIndex, atIndex: i)
                return
            }
        }
        
        selectIndexArray.append(sIndex)
    }
    
    func addEmptyMeasureWithIndex(index :Int){
        addItemToUndoArray()
        
        let measure = MusicMeasure(nArray: [MusicNote]())
        measure.delegate = song
        song.measureArray.insert(measure, atIndex: index)
    }
    
    func addItemToUndoArray(){
        undoStack.append(song.mutableCopy() as! MusicSong)
        emptyRedoStack()
    }
    
    func addItemToRedoArray(){
        redoStack.append(song.mutableCopy() as! MusicSong)
    }
    
// MARK: ----------simple res-----------------
    
    func  isHasCopyItem()->Bool{
        return tempCopyArray.count != 0
    }
    

// MARK: ----------business res-----------------
    func removeSelectIndex(sIndex :Int){
        for var i = 0; i < selectIndexArray.count; ++i{
            let tIndex = selectIndexArray[i]
            if tIndex == sIndex{
                selectIndexArray.removeAtIndex(i)
            }
        }
    }
    
    func copySelectArray(){
        tempCopyArray.removeAll(keepCapacity: false)
        
        for i in selectIndexArray{
            tempCopyArray.append(song.measureArray[i].mutableCopy() as! MusicMeasure)
        }
    }
    
    func cutSelectArray(){
        addItemToUndoArray()
        
        tempCopyArray.removeAll(keepCapacity: false)
        for i in selectIndexArray{
            tempCopyArray.append(song.measureArray[i].mutableCopy() as! MusicMeasure)
        }
        deleteSelectArray()
    }
    
    func deleteSelectArray(){
        addItemToUndoArray()
        
        for var i = selectIndexArray.count-1; i >= 0; --i{
            song.measureArray.removeAtIndex(selectIndexArray[i])
        }
    }
    
    func copyItemToIndex(aIndex :Int){
        addItemToUndoArray()
        
        if tempCopyArray.count > 0{
            
        }
        for var i = 0; i < tempCopyArray.count ; ++i{
            song.measureArray.insert(tempCopyArray[i].mutableCopy() as! MusicMeasure, atIndex: aIndex + i)
        }
    }
    
    func renewMeasureIndex(){
        for var i = 0;i < song.measureArray.count;++i{
            let measure = song.measureArray[i]
            measure.measureIndex = i
        }
    }
    
    func undo(){
        addItemToRedoArray()
        song = undoStack[undoStack.count - 1].mutableCopy() as! MusicSong
        undoStack.removeAtIndex(undoStack.count - 1)
    }
    
    func redo(){
        undoStack.append(song.mutableCopy() as! MusicSong)
        song = redoStack[redoStack.count - 1].mutableCopy() as! MusicSong
        redoStack.removeAtIndex(redoStack.count - 1)
    }
    
    func addMeasureArray(){
        
    }
    
    func save(){
        MusicStorage.save(song)
    }
    
    func addNewSongWithName(songName :String,timeSignature :TIME_SIGNATURE){
//        save()
       song = MusicStorage.addNewSongWithName(songName,timeSignature:timeSignature)
    }
    
    func setSongWithName(sonName :String,speed :Int){
        song.songName = sonName
        song.songSpeed = speed
    }
    
    func getAllSongName() -> [String]?{
        return MusicStorage.getAllSongName()
    }
    
    func renewMusicSongWithSongName(songName :String){
//        save()
        if let tempSong = MusicStorage.getMusicSongWithSongName(songName){
            song = tempSong
        }
        else{
            song = MusicStorage.simulateTestData()
        }
    }
    func deleteSongWithSongName(songName :String){
        MusicStorage.deleteSongWithSongName(songName)
    }
}
