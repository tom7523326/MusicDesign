//
//  MusicUtils.swift
//  MusicNoteDesignTools
//
//  Created by tangsl on 15/7/22.
//  Copyright (c) 2015年 tangsl. All rights reserved.
//

import UIKit



class MusicUtils{
    
    class func addLineToNoteView(noteView :UIView ,note :MusicNote){
        if !note.noteType.isRest(){
            let linemargin = note.getLineMargin()
            if note.noteScale.rawValue % 2 == 0{
                let lineview :UIView = UIView(frame: CGRectMake(linemargin, note.getCircleY() + margin * 2 - 1, NOTE_LINE_WIDTH, STAFF_LINE_HEIGHT))
                lineview.backgroundColor = UIColor.blackColor()
                noteView.addSubview(lineview)
            }
            else{
                let lineview1 :UIView = UIView(frame: CGRectMake(linemargin, note.getCircleY() - 1, NOTE_LINE_WIDTH, STAFF_LINE_HEIGHT))
                lineview1.backgroundColor = UIColor.blackColor()
                noteView.addSubview(lineview1)
                
                if note.noteScale != NOTE_SCALE.g{
                    let lineview2 :UIView = UIView(frame: CGRectMake(linemargin, note.getCircleY() + margin * 4 - 1, NOTE_LINE_WIDTH, STAFF_LINE_HEIGHT))
                    lineview2.backgroundColor = UIColor.blackColor()
                    noteView.addSubview(lineview2)
                }
            }
        }
    }
}