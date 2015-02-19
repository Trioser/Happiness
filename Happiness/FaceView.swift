//
//  FaceView.swift
//  Happiness
//
//  Created by Richard E Millet on 2/15/15.
//  Copyright (c) 2015 remillet. All rights reserved.
//

import UIKit

protocol FaceViewDataSource: class {
	func smilinessForFaceView(sender: FaceView) -> Double?
}

@IBDesignable
class FaceView: UIView {
	@IBInspectable
	var scale: CGFloat = 0.9 {
		didSet {
			self.setNeedsDisplay() // redraw if lineWidth changes
		}
	}
	
	@IBInspectable
	var lineWidth: CGFloat = 3 {
		didSet {
			self.setNeedsDisplay() // redraw if lineWidth changes
		}
	}
	
	@IBInspectable
	var color: UIColor = UIColor.blueColor() {
		didSet {
			self.setNeedsDisplay() // redraw if color changes
		}
	}
	
	weak var faceViewDataSource: FaceViewDataSource?
	
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
	
	private enum Eye { case Left, Right }
	
	private func bezierPathForEye(whichEye: Eye) -> UIBezierPath {
		let eyeRadius = faceRadius / Scaling.FaceRadiusToEyeRadiusRatio
		let eyeVerticalOffset = faceRadius / Scaling.FaceRadiusToEyeOffsetRatio
		let eyeHortizontalSeparation = faceRadius / Scaling.FaceRadiusToEyeSeparationRatio
		
		var eyeCenter = faceCenter
		eyeCenter.y -= eyeVerticalOffset
		switch whichEye {
			case .Left:
				eyeCenter.x -= eyeHortizontalSeparation / 2
			case .Right:
				eyeCenter.x += eyeHortizontalSeparation / 2
		}
		
		let path = UIBezierPath(arcCenter: eyeCenter, radius: eyeRadius, startAngle: 0, endAngle: CGFloat(2*M_PI), clockwise: true)
		path.lineWidth = self.lineWidth
		
		return path
	}
	
	private func bezierPathForSmile(fractionOfMaxSmile: Double) -> UIBezierPath {
		let mouthWidth = faceRadius / Scaling.FaceRadiusToMouthWidthRatio
		let mouthHeight = faceRadius / Scaling.FaceRadiusToMouthHeightRatio
		let mouthVerticalOffset = faceRadius / Scaling.FaceRadiusToMouthOffsetRatio
		
		let smileHeight = CGFloat(max(min(fractionOfMaxSmile, 1), -1)) * mouthHeight
		
		let start = CGPoint(x: faceCenter.x - mouthWidth / 2, y: faceCenter.y + mouthVerticalOffset)
		let end = CGPoint(x: faceCenter.x + mouthWidth / 2, y: faceCenter.y + mouthVerticalOffset)
		let controlPoint1 = CGPoint(x: start.x + mouthWidth / 3, y: start.y + smileHeight)
		let controlPoint2 = CGPoint(x: end.x - mouthWidth / 3, y: start.y + smileHeight)
		
		let path = UIBezierPath()
		path.moveToPoint(start)
		path.addCurveToPoint(end, controlPoint1: controlPoint1, controlPoint2: controlPoint2)
		path.lineWidth = self.lineWidth
		
		return path
	}
	
	private struct Scaling {
		static let FaceRadiusToEyeRadiusRatio: CGFloat = 10
		static let FaceRadiusToEyeOffsetRatio: CGFloat = 3
		static let FaceRadiusToEyeSeparationRatio: CGFloat = 1.5
		static let FaceRadiusToMouthWidthRatio: CGFloat = 1
		static let FaceRadiusToMouthHeightRatio: CGFloat = 3
		static let FaceRadiusToMouthOffsetRatio: CGFloat = 3
	}

    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func drawRect(rect: CGRect) {
        //
		// Drawing code
		//
		
		// Draw the face's enclosing circle
		let facePath = UIBezierPath(arcCenter: faceCenter, radius: faceRadius, startAngle: 0, endAngle: CGFloat(2*M_PI), clockwise: true)
		facePath.lineWidth = lineWidth
		color.set()
		facePath.stroke()
		
		// Draw the face's left eye
		bezierPathForEye(Eye.Left).stroke()
		bezierPathForEye(Eye.Right).stroke()

		let smiliness = faceViewDataSource?.smilinessForFaceView(self) ?? 0.0
		let smilepath = bezierPathForSmile(smiliness)
		smilepath.stroke()
	}
}
