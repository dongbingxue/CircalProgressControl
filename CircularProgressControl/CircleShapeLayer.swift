//
//  CircleShapeLayer.swift
//  CircularProgressControl
//
//  Created by dbx on 15/1/4.
//  Copyright (c) 2015年 dong bingxue. All rights reserved.
//

import UIKit

class CircleShapeLayer: CAShapeLayer {
    
    var elapsedTime: NSTimeInterval = 0 {
        
        didSet{
            
            initialProgress = self.percent(oldValue, toTime: timeLimit)
            self.progressLayer.strokeEnd = CGFloat(percent)
            self.startAnimation()
        }
        
    }
    
    var timeLimit: NSTimeInterval = 0
    
    var percent: Double {
        return self.percent(elapsedTime, toTime: timeLimit)
    }
    
    var progressColor: UIColor {
        
        set {
            self.progressLayer.strokeColor = newValue.CGColor
        }
        get{
            return UIColor(CGColor:self.progressLayer.strokeColor)!
        }
    }
    
    var progressLayer: CAShapeLayer!
    var initialProgress: Double!
    var aFrame: CGRect!
    
    override init() {
        
        super.init()
        self.setupLayer()
        
    }

    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func layoutSublayers() {
        
        self.path = self.drawPathWithArcCenter()
        self.progressLayer.path = self.drawPathWithArcCenter()
        super.layoutSublayers()
    }
    
    
    func setupLayer() {
        
        self.path = self.drawPathWithArcCenter();
        self.fillColor = UIColor.clearColor().CGColor
        self.strokeColor = UIColor(red: 0.86, green: 0.86 ,blue: 0.86, alpha:0.4).CGColor
        self.lineWidth = 20
        
        self.progressLayer = CAShapeLayer()
        self.progressLayer.path = self.drawPathWithArcCenter()
        self.progressLayer.fillColor = UIColor.clearColor().CGColor
        self.progressLayer.strokeColor = UIColor.whiteColor().CGColor
        self.progressLayer.lineWidth = 20;
        self.progressLayer.lineCap = kCALineCapRound
        self.progressLayer.lineJoin = kCALineJoinRound
        self.addSublayer(self.progressLayer)
        
    }
    
    
    func drawPathWithArcCenter() -> CGPathRef {
        
        let position_y:CGFloat = self.frame.size.height/2
        let position_x:CGFloat = self.frame.size.width/2
        
        let point = CGPoint(x: position_x, y: position_y)
        
        var path = UIBezierPath(arcCenter: point, radius:CGFloat(position_y), startAngle: CGFloat(-M_PI / 2), endAngle: CGFloat( 3 * M_PI / 2), clockwise: true)
        
        return path.CGPath
        
    }
    
    
    func percent(fromTime:NSTimeInterval,toTime:NSTimeInterval)  -> Double {
        
        if ((toTime > 0) && (fromTime > 0)) {
            
            var progress: Double = 0;
            
            progress = fromTime / toTime;
            
            if (progress * 100) > 100 {
                progress = 1.0
            }
            
            return progress
        }
        else{
            return 0.0
        }
    }
    
    func startAnimation () {
        
        let pathAnimation = CABasicAnimation(keyPath: "strokeEnd")
        pathAnimation.duration = 0.1
        pathAnimation.fromValue = self.initialProgress
        pathAnimation.toValue = self.percent
        pathAnimation.removedOnCompletion = true
        
        self.progressLayer.addAnimation(pathAnimation, forKey: nil)
        
    }
    
    
    
}
