//
//  ViewController.swift
//  CircularProgressControl
//
//  Created by dbx on 15/1/4.
//  Copyright (c) 2015年 dong bingxue. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var circleProgressView: CircleShapeView!
    
    @IBOutlet weak var actionButton: UIButton!
    
    
    var timer: NSTimer!
    var session: Session!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        self.view.backgroundColor = UIColor(red: 51/255.0 , green:73/255.0,blue:93/255.0, alpha:1.0)
        
        self.session = Session()
        self.session.state = SessionState.kSessionStateStop
        
        self.circleProgressView.status = "not start"
        self.circleProgressView.timeLimit = 60
        self.circleProgressView.elapsedTime = 0
        
        self.actionButton.setTitleColor(UIColor.whiteColor(), forState: UIControlState.Normal)
        
        self.startTimer()
        
        
    }
    
    override func viewDidDisappear(animated: Bool) {
        
        super.viewDidDisappear(animated)
        
        self.timer.invalidate()
    }

    
    
    
    func startTimer() {
        
        if (self.timer == nil) || (!self.timer.valid) {
            
           NSTimer.scheduledTimerWithTimeInterval(0.1, target:self, selector:"poolTimer", userInfo:nil, repeats:true)
            
//            self.timer = NSTimer(timeInterval: 0.1, target: self, selector:"poolTimer", userInfo: nil, repeats: true)
//            self.timer.fire()
        }
    }
    
    func poolTimer() {
        
        if (self.session != nil) && (self.session.state == SessionState.kSessionStateStart)
        {
            self.circleProgressView.elapsedTime = self.session.progressTime;
        }
    }
    
    
    @IBAction func actionButtonClick(sender: AnyObject) {
        
        if (self.session.state == .kSessionStateStop) {
            
            self.session.startDate = NSDate()
            self.session.finishDate = nil;
            self.session.state = .kSessionStateStart
            
            let tintColor = UIColor(red:184/255.0 ,green:233/255.0, blue:134/255.0 ,alpha:1.0)
            self.circleProgressView.status = "in progress"
            self.circleProgressView.tintColor = tintColor
            self.circleProgressView.elapsedTime = 0
            
            self.actionButton.setTitle("Stop", forState:UIControlState.Normal)
            self.actionButton.setTitleColor(tintColor, forState: UIControlState.Normal)
        }
        else {
            
            self.session.finishDate = NSDate()
            self.session.state = .kSessionStateStop
            
            self.circleProgressView.status = "oot start"
            self.circleProgressView.tintColor = UIColor.whiteColor()
            self.circleProgressView.elapsedTime = self.session.progressTime
            
            self.actionButton.setTitle("Start", forState:UIControlState.Normal)
            self.actionButton.setTitleColor(UIColor.whiteColor(), forState: UIControlState.Normal)
        }
    }
    
    

}

