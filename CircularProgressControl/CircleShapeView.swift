//
//  CircleShapeView.swift
//  CircularProgressControl
//
//  Created by dbx on 15/1/4.
//  Copyright (c) 2015年 dong bingxue. All rights reserved.
//

import UIKit

class CircleShapeView: UIControl {

    var progressLayer: CircleShapeLayer!
    var progressLabel: UILabel!
    var status: NSString!
    
    var elapsedTime: NSTimeInterval {
        
        set {
            self.progressLayer.elapsedTime = newValue
            self.progressLabel.attributedText = self.formatProgressStringFromTimeInterval(elapsedTime)
        }
        get{
            
            return self.progressLayer.elapsedTime
        }
        
    }
    
    var timeLimit: NSTimeInterval {
        set {
            self.progressLayer.timeLimit = newValue
        }
        get{
            
            return self.progressLayer.timeLimit
        }
        
    }
    
    var percent: Double {
        return self.progressLayer.percent
        
    }
    
    override var tintColor:UIColor! {
        didSet {
            
            self.progressLayer.progressColor = tintColor
            self.progressLabel.textColor = tintColor
        }
        
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
      
        self.progressLayer.frame = self.bounds;
        
        self.progressLabel.sizeToFit()
        self.progressLabel.center = CGPointMake(self.center.x - self.frame.origin.x, self.center.y - self.frame.origin.y)
    
    }
    
    override func awakeFromNib() {
        self.setupViews()
    }
    
    
   func setupViews() {
    
    self.backgroundColor = UIColor.clearColor()
    self.clipsToBounds = false
    
    progressLabel = UILabel(frame: self.bounds)
    progressLabel.numberOfLines = 2
    progressLabel.textAlignment = .Center
    progressLabel.backgroundColor = UIColor.clearColor()
    progressLabel.textColor = UIColor.whiteColor()
    self.addSubview(progressLabel)


    self.progressLayer = CircleShapeLayer()
    self.progressLayer.frame = self.bounds
    self.progressLayer.backgroundColor = UIColor.clearColor().CGColor
    self.layer.addSublayer(self.progressLayer)
    
    }
    
    override func updateConstraints() {
        
        super.updateConstraints()
    }
    
    
    func stringFromTimeInterval(interval:NSTimeInterval ,shortDate:Bool) -> NSString {
        let ti = NSInteger(interval)
        let seconds = ti % 60
        let minutes = (ti / 60) % 60
        let hours = (ti / 3600)
        
        if (shortDate) {
            
            return String(format: "%02ld:%02ld", hours, minutes)
        }
        else {
            
            return String(format: "%02ld:%02ld:%02ld", hours, minutes, seconds)
        }
        
    }
    
    
    func formatProgressStringFromTimeInterval(interval:NSTimeInterval) -> NSAttributedString {
        
        let progressString =  self.stringFromTimeInterval(interval, shortDate: false)
        
        var attributedString: NSMutableAttributedString
        
        
        if (status.length > 0) {
            
            attributedString = NSMutableAttributedString(string: String(format: "%@\n%@", progressString, status))
            attributedString.addAttributes([NSFontAttributeName:UIFont(name: "HelveticaNeue-Bold", size: 40)!], range: NSMakeRange(0,progressString.length))
            
            attributedString.addAttributes([NSFontAttributeName:UIFont(name: "HelveticaNeue-thin", size: 18)!], range: NSMakeRange(progressString.length+1,status.length))
            
        }
        else {
            
            attributedString = NSMutableAttributedString(string:String(format: "%@", progressString))
            attributedString.addAttributes([NSFontAttributeName:UIFont(name: "HelveticaNeue-Bold", size: 18)!], range: NSMakeRange(0,progressString.length))
            
        }
        
        return attributedString;
    }
    
    
}
