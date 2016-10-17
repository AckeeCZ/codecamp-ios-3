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
    
    var amplitude : CGFloat = 40.0 {
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
        offset = self.bounds.height / 2.0

    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = UIColor.lightGray
    }
    
    

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    override func draw(_ rect: CGRect) {
        
        super.draw(rect)
        let context = UIGraphicsGetCurrentContext();
        context?.setStrokeColor(UIColor.red.cgColor);
        context?.setLineWidth(2);
        context?.move(to: CGPoint(x: 0, y: offset));
        
        
        let range = 0 ..< Int(frame.width)
        for i in range {
            let x = CGFloat(i)
            let y = self.amplitude * sin(x/frame.width * period * 2 * CGFloat(M_PI)) + offset
            context?.addLine(to: CGPoint(x: x, y: y));
        }
        //CGContextSetLineJoin(context, CGLineJoin.Bevel)
        //CGContextSetLineCap(context, CGLineCap.Round)
        context?.strokePath();
    }
}
    
  
