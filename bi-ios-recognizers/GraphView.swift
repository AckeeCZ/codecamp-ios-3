//
//  GraphView.swift
//  bi-ios-recognizers
//
//  Created by Dominik Vesely on 03/11/15.
//  Copyright © 2015 Ackee s.r.o. All rights reserved.
//

import Foundation
import UIKit

class GraphView : UIView {
    
    var amplitude : CGFloat = 5.0 {
        didSet {
            setNeedsDisplay()
        }
    }
    
    var period : CGFloat = 1.0 {
        didSet {
            setNeedsDisplay()
        }
    }
    
    var offset : CGFloat! = 0   {
        didSet {
            setNeedsDisplay()
        }
    }
   
    override func layoutSubviews() {
        super.layoutSubviews()
        offset = CGRectGetHeight(self.bounds) / 2.0

    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = UIColor.lightGrayColor()
    }
    
    

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    override func drawRect(rect: CGRect) {
        
        super.drawRect(rect)
        let context = UIGraphicsGetCurrentContext();
        CGContextSetStrokeColorWithColor(context, UIColor.redColor().CGColor);
        CGContextSetLineWidth(context, 2);
        CGContextMoveToPoint(context, 0, offset);
        for (var i : CGFloat = 0; i <  frame.width; i += 1) {
            let y = self.amplitude * sin(i/frame.width * period * 2 * CGFloat(M_PI)) + offset
            CGContextAddLineToPoint(context, i, y);
        }
        CGContextSetLineJoin(context, CGLineJoin.Bevel)
        CGContextSetLineCap(context, CGLineCap.Round)
        CGContextStrokePath(context);
    }
}
    
  