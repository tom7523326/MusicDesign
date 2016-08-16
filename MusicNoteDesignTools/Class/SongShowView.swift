//
//  SongShowView.swift
//  MusicNoteDesignTools
//
//  Created by tangsl on 15/7/27.
//  Copyright (c) 2015年 tangsl. All rights reserved.
//

import UIKit

class SongShowView: UIScrollView {
    
    var staffArray:[MeasureStaffView]!
    var songdelegate :SongShowViewDelegate!
    var titleLable :UILabel!
    var speedLable :UILabel!
    
    init(frame: CGRect ,title :String,speed :Int) {
        super.init(frame: frame)
        
        backgroundColor = UIColor.clearColor()
       
        
        //speedview
        let speedSymbleView :UIImageView! = UIImageView()
        speedSymbleView.image = UIImage(named:"symbol_d=")
        addSubview(speedSymbleView)
        
        //title lable
        speedLable = UILabel()
        speedLable.font = UIFont.systemFontOfSize(20)
        speedLable.text = "\(speed)"
        addSubview(speedLable)
        
        constrain(speedSymbleView,speedLable) { speedSymbleView,speedLable in
            speedSymbleView.centerX == speedSymbleView.superview!.left + 101
            speedSymbleView.top == speedSymbleView.superview!.top + 10
            speedSymbleView.width == 23
            speedSymbleView.height == 23
            
            speedLable.left == speedSymbleView.right + 3
            speedLable.width == 70
            speedLable.height == 40
            speedLable.top == speedSymbleView.superview!.top
        }
        
        //title lable
        titleLable = UILabel()
        titleLable.font = UIFont.systemFontOfSize(28)
        titleLable.text = title
        addSubview(titleLable)
        
        constrain(titleLable) { titleLable in
            titleLable.centerX == titleLable.superview!.centerX
            titleLable.top == titleLable.superview!.top
//            titleLable.width == 100//宽度自适应
            titleLable.height == 40
        }
        
//        // test staff view
//        var staffView :StaffView = StaffView()
//        self.addSubview(staffView)
//        
//        layout(staffView){ staffView in
//            staffView.centerX == staffView.superview!.centerX
//            staffView.top == staffView.superview!.top + 25 + 15
//            staffView.width == staffView.superview!.width - 37*2
//            staffView.height == 125
//        }
        
        
        let singleTap = UITapGestureRecognizer(target: self, action: Selector("singleTapClick"))
        singleTap.numberOfTouchesRequired = 1
        singleTap.numberOfTapsRequired = 1
        addGestureRecognizer(singleTap)
        
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func singleTapClick(){
        songdelegate.exitEditState()
    }
    

}
