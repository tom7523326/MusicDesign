//
//  StaffView.swift
//  MusicNoteDesignTools
//
//  Created by tangsl on 15/7/28.
//  Copyright (c) 2015年 tangsl. All rights reserved.
//

import UIKit


class StaffView: UIView {
    
    var staffType :STAFF_TYPE?
    var measuerImageArray  :[AnyObject]?
    let leftMargin :CGFloat! = 0
    let staffWidth :CGFloat? = 0
    let firstStaffTop :CGFloat = 0
    let staffSpacing :CGFloat = 0
    
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        //set bg image
        backgroundColor = UIColor.clearColor()
    }
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    
    //draw miscal line method
    override func drawRect(rect: CGRect) {
        // Drawing code
        let staffLineHeight :CGFloat = 2;
        let context = UIGraphicsGetCurrentContext()
        CGContextSetLineWidth(context, staffLineHeight)
        let colorSpace = CGColorSpaceCreateDeviceRGB()
        let components: [CGFloat] = [0.0, 0.0, 0.0, 1.0]
        let color = CGColorCreate(colorSpace, components)
        CGContextSetStrokeColorWithColor(context, color)
        
        let leftMargin :CGFloat = 0
        let staffWidth :CGFloat = bounds.width - leftMargin * 2
        let firstStaffTop :CGFloat = 12.5
        let staffSpacing :CGFloat = 18
        
        if staffType == STAFF_TYPE.normalStaff
        {
            for i in 0..<5 {
                let staffTop:CGFloat = firstStaffTop + (staffSpacing + staffLineHeight) * CGFloat(i)
                CGContextMoveToPoint(context, leftMargin, staffTop)
                CGContextAddLineToPoint(context, leftMargin + staffWidth, staffTop)
            }
            
            for i in 0..<5 {
                let staffLeft:CGFloat = leftMargin + CGFloat(110) * CGFloat(i != 0) + (staffWidth - CGFloat(110)) / 4 * CGFloat(i)
                let staffTop:CGFloat = firstStaffTop + (staffSpacing + staffLineHeight) * 4
                CGContextMoveToPoint(context, staffLeft, firstStaffTop)
                CGContextAddLineToPoint(context, staffLeft, staffTop)
            }
        }
        
        CGContextStrokePath(context)
        
        if staffType == STAFF_TYPE.normalStaff
        {
            let clefView:UIImageView = UIImageView(frame: CGRectMake(20, 0, 55, 135))
            clefView.image = UIImage(named: "Note_G_Clef")
            addSubview(clefView)
        }
        
    }
    
    
}