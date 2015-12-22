//
//  MusicStaticDefine.swift
//  MusicNoteDesignTools
//
//  Created by tangsl on 15/7/24.
//  Copyright (c) 2015年 tangsl. All rights reserved.
//

import UIKit


let BTN_WIDTH:CGFloat = 85
let BTN_HEIGHT:CGFloat = 111



//********************************NOTE RES START **************************************/
enum NOTE_TYPE: Int{
    case noteWholeNote = 0
    case noteHalfNote
    case noteQuarterNote
    case noteEighthNote
    case noteSixteenthNote
    
    case restWholeNote
    case restHalfNote
    case restQuarterNote
    case restEighthNote
    case restSixteenthNote
    
    case noteWholeNoteDotted
    case noteHalfNoteDotted
    case noteQuarterNoteDotted
    case noteEighthNoteDotted
    case noteSixteenthNoteDotted
    
    case restWholeNoteDotted
    case restHalfNoteDotted
    case restQuarterNoteDotted
    case restEighthNoteDotted
    case restSixteenthNoteDotted
    
    func getImage()->UIImage{
        return UIImage(named: NOTE_FILE_NAME_ARRAY[self.rawValue])!
    }
    
    func getTimeValue()->Float{
        return NOTE_TIME_VALUE_ARRAY[self.rawValue]
    }
    
    func getConversionImage() -> UIImage{
        
        return UIImage(named: NOTE_CONVERSION_FILE_NAME_ARRAY[self.rawValue])!
    }
    
    func getImageSe()->UIImage{
        return UIImage(named: NOTE_FILE_NAME_ARRAY_SE[self.rawValue])!
    }
    
    func getConversionImageSe() -> UIImage{
        
        return UIImage(named: NOTE_CONVERSION_FILE_NAME_ARRAY_SE[self.rawValue])!
    }
    
    func isRest() -> Bool{
        if (self.rawValue >= 0 && self.rawValue < 5) || (self.rawValue >= 10 && self.rawValue < 15){
            return false
        }
        else{
            return true
        }
    }
    
    func getCricleY() -> CGFloat{
        return NOTE_CIRCLE_Y[self.rawValue]
    }
    func getCricleConverseY() -> CGFloat{
        return NOTE_CIRCLE_CONVERSE_Y[self.rawValue]
    }
    
    func getLineMargin() -> CGFloat{
        return NOTE_LINE_MARGIN_ARRAY[self.rawValue]
    }
    
    func getLineConverseMargin() -> CGFloat{
         return NOTE_LINE_MARGIN_CONVERSE_ARRAY[self.rawValue]
    }
    
}

//! note filename list
let NOTE_FILE_NAME_ARRAY =
[
        "Note_Whole_Note","Note_Half_Note","Note_Quarter_Note","Note_Eighth_Note","Note_Sixteenth_Note",
        "Rest_Whole_Note","Rest_Half_Note","Reset_Quarter_Note","Rest_Eighth_Note","Rest_Sixteenth_Note",
    "Note_Whole_Dotted_Note","Note_Half_Dotted_Note","Note_Quarter_Dotted_Note","Note_Eighth_Dotted_Note","Note_Sixteenth_Dotted_Note",
    "Rest_Whole_Dotted_Note","Rest_Half_Dotted_Note","Reset_Quarter_Dotted_Note","Rest_Eighth_Dotted_Note","Rest_Sixteenth_Dotted_Note"
]
let NOTE_CONVERSION_FILE_NAME_ARRAY =
[
    "Note_Whole_Note_Conversion","Note_Half_Note_Conversion","Note_Quarter_Note_Conversion","Note_Eighth_Note_Conversion","Note_Sixteenth_Note_Conversion",
    "Rest_Whole_Note_Conversion","Rest_Half_Note_Conversion","Reset_Quarter_Note_Conversion","Rest_Eighth_Note_Conversion","Rest_Sixteenth_Note_Conversion",
    "Note_Whole_Dotted_Note_Conversion","Note_Half_Dotted_Note_Conversion","Note_Quarter_Dotted_Note_Conversion","Note_Eighth_Dotted_Note_Conversion","Note_Sixteenth_Dotted_Note_Conversion",
    "Rest_Whole_Dotted_Note_Conversion","Rest_Half_Dotted_Note_Conversion","Reset_Quarter_Dotted_Note_Conversion","Rest_Eighth_Dotted_Note_Conversion","Rest_Sixteenth_Dotted_Note_Conversion"
]

let NOTE_FILE_NAME_ARRAY_SE =
[
    "Note_Whole_Note_se","Note_Half_Note_se","Note_Quarter_Note_se","Note_Eighth_Note_se","Note_Sixteenth_Note_se",
    "Rest_Whole_Note_se","Rest_Half_Note_se","Reset_Quarter_Note_se","Rest_Eighth_Note_se","Rest_Sixteenth_Note_se",
    "Note_Whole_Dotted_Note_se","Note_Half_Dotted_Note_se","Note_Quarter_Dotted_Note_se","Note_Eighth_Dotted_Note_se","Note_Sixteenth_Dotted_Note_se",
    "Rest_Whole_Dotted_Note_se","Rest_Half_Dotted_Note_se","Reset_Quarter_Dotted_Note_se","Rest_Eighth_Dotted_Note_se","Rest_Sixteenth_Dotted_Note_se"
]
let NOTE_CONVERSION_FILE_NAME_ARRAY_SE =
[
    "Note_Whole_Note_Conversion_se","Note_Half_Note_Conversion_se","Note_Quarter_Note_Conversion_se","Note_Eighth_Note_Conversion_se","Note_Sixteenth_Note_Conversion_se",
    "Rest_Whole_Note_Conversion_se","Rest_Half_Note_Conversion_se","Reset_Quarter_Note_Conversion_se","Rest_Eighth_Note_Conversion_se","Rest_Sixteenth_Note_Conversion_se",
    "Note_Whole_Dotted_Note_Conversion_se","Note_Half_Dotted_Note_Conversion_se","Note_Quarter_Dotted_Note_Conversion_se","Note_Eighth_Dotted_Note_Conversion_se","Note_Sixteenth_Dotted_Note_Conversion_se",
    "Rest_Whole_Dotted_Note_Conversion_se","Rest_Half_Dotted_Note_Conversion_se","Reset_Quarter_Dotted_Note_Conversion_se","Rest_Eighth_Dotted_Note_Conversion_se","Rest_Sixteenth_Dotted_Note_Conversion_ses"
]

let NOTE_CIRCLE_Y :[CGFloat] = [28,51,51,51,57,0,0,0,0,0,28,51,51,51,57,0,0,0,0,0]
let NOTE_CIRCLE_CONVERSE_Y :[CGFloat] = [28,5,5,5,-1,0,0,0,0,0,28,5,5,5,-1,0,0,0,0,0]
let NOTE_LINE_MARGIN_ARRAY :[CGFloat] = [9,12,12,2,2,0,0,0,0,0,7,7,7,2,2,0,0,0,0,0]
let NOTE_LINE_MARGIN_CONVERSE_ARRAY :[CGFloat] = [9,11,11,11,11,0,0,0,0,0,9,8,8,8,8,0,0,0,0,0]

//! note value list
let NOTE_TIME_VALUE_ARRAY:[Float] = [1,1/2,1/4,1/8,1/16,1,1/2,1/4,1/8,1/16,1+1/2,1/2+1/4,1/4+1/8,1/8+1/16,1/16+1/32,1+1/2,1/2+1/4,1/4+1/8,1/8+1/16,1/16+1/32]

let WAV_FILE_NAME_ARRAY :[String] = ["A2","G2","F2","E2","D2","C2","B1","A1","G1","F1","E1","D1","C1","B","A","G"]

enum NOTE_SCALE: Int{
    
        case a2 = 0
        case g2
        case f2
        case e2
        case d2
        case c2
        case b1
        case a1
        case g1
        case f1
        case e1
        case d1
        case c1
        case b
        case a
        case g
    
    func getNoteWavName() -> String{
        return WAV_FILE_NAME_ARRAY[self.rawValue]
    }
    

}

//! note value list
let NOTE_SCALE_VALUE_ARRAY:[Float] = []

//********************************NOTE RES END**************************************/


//********************************SONG RES START**************************************/

let SIGNATURE_NAME_ARRAY = ["symbol_One_Four_Time","symbol_Two_Four_Time","symbol_Three_Four_Time","symbol_Four_Four_Time"]

enum TIME_SIGNATURE: Int
{
    case oneFourTime = 1
    case twoFourTime
    case threeFourTime
    case fourFourTime
    
    func getImage()->UIImage{
        
        return UIImage(named: SIGNATURE_NAME_ARRAY[self.hashValue])!
    }
    
    func getSignatureCount() ->Int{
        return 4
    }
    
}

//********************************SONG RES END**************************************/





//********************************STAFF RES START**************************************/

let FIRST_STAFF_TOP :CGFloat = 33
let STAFF_SPACING :CGFloat = 20
let STAFF_LINE_HEIGHT :CGFloat = 2

enum STAFF_TYPE: Int{
    
    case normalStaff = 0;
    case normalStaffFirstStaffFirsetMeasure
    case normalStaffFirstMeasure
    case rhythmStaff
    case rhythmStaffFirstStaffFirsetMeasure
    case rhythmStaffFirstMeasure
    
    func isNormal() -> Bool{
        if(self == normalStaffFirstStaffFirsetMeasure || self == normalStaffFirstMeasure || self == normalStaff){
            return true
        }
        else{
            return false
        }
    }
    
    func isFirstMeasure() -> Bool{
        if self == normalStaffFirstStaffFirsetMeasure || self == normalStaffFirstMeasure || self == rhythmStaffFirstStaffFirsetMeasure || self == rhythmStaffFirstMeasure{
            return true
        }
        else{
            return false
        }
    }
    
    func isFirstLineFirstMeasure() -> Bool{
        if self == normalStaffFirstStaffFirsetMeasure || self == rhythmStaffFirstStaffFirsetMeasure{
            return true
        }
        else{
            return false
        }
    }
    
}

let PER_LINE_LENGTH :CGFloat = 4

let CLEF_MARGIN :CGFloat = 110
let RHYTHM_LINE_HEIGHT :CGFloat = 2

let NOTE_WIDTH :CGFloat = 50
let NOTE_HEIGHT :CGFloat = 82
let STAFF_HEIGHT :CGFloat = (STAFF_SPACING + STAFF_LINE_HEIGHT) * 8
let SONG_TITLE_HEIGHT :CGFloat = 40
let STAFF_LEFT_MARGIN :CGFloat = 37

let BOTTOM_BTN_WIDTH :CGFloat = 120
let BOTTOM_BTN_HEIGHT :CGFloat = 121

let VIEW_WIDTH :CGFloat = 1024
let VIEW_HEIGHT :CGFloat = 768

let NOTE_LINE_WIDTH :CGFloat = 30
let margin = (STAFF_LINE_HEIGHT + STAFF_SPACING)/4
//********************************STAFF RES END**************************************/
