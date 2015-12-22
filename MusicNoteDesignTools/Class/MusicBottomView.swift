//
//  MusicButtomView.swift
//  MusicNoteDesignTools
//
//  Created by tangsl on 15/7/23.
//  Copyright (c) 2015年 tangsl. All rights reserved.
//

import UIKit



class MusicBottomView: UIView {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        //set bg image
        let backImage :UIImage! = UIImage(named: "bg_bottom")
        self.backgroundColor = UIColor(patternImage: backImage)
        

        
    }

    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    

    
    
    
    
}
