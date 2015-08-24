//
//  Session.swift
//  CircularProgressControl
//
//  Created by dbx on 15/1/4.
//  Copyright (c) 2015年 dong bingxue. All rights reserved.
//

import UIKit

enum SessionState {
   case kSessionStateStart
   case kSessionStateStop
}



class Session: NSObject {
    
    var startDate : NSDate!
    var finishDate : NSDate!
    var progressTime : NSTimeInterval {
        
        if (self.finishDate != nil) {
            return self.finishDate.timeIntervalSinceDate(self.startDate)
        }
        else {
            return NSDate().timeIntervalSinceDate(self.startDate)
        }
    }
    
    var state : SessionState!
}
