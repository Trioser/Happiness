//
//  FaceView.swift
//  Happiness
//
//  Created by Richard E Millet on 2/15/15.
//  Copyright (c) 2015 remillet. All rights reserved.
//

import UIKit

class FaceView: UIView {
	var scale: CGFloat = 0.9 {
		didSet {
			self.setNeedsDisplay() // redraw if lineWidth changes
		}
	}
	
	var lineWidth: CGFloat = 3 {
		didSet {
			self.setNeedsDisplay() // redraw if lineWidth changes
		}
	}
	
	var color: UIColor = UIColor.blueColor() {
		didSet {
			self.setNeedsDisplay() // redraw if color changes
		}
	}
	
	var faceCenter: CGPoint {
		get {
			return self.convertPoint(center, fromView: superview)
		}
	}
	
	var faceRadius: CGFloat {
		get {
			 return (min(bounds.size.width, bounds.size.height) / 2) * scale
		}
	}

    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func drawRect(rect: CGRect) {
        //
		// Drawing code
		//
		let facePath = UIBezierPath(arcCenter: faceCenter, radius: faceRadius, startAngle: 0, endAngle: CGFloat(2*M_PI), clockwise: true)
		facePath.lineWidth = lineWidth
		color.set()
		facePath.stroke()
    }
}
