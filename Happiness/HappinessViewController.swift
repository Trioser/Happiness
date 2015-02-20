//
//  HappinessViewController.swift
//  Happiness
//
//  Created by Richard E Millet on 2/15/15.
//  Copyright (c) 2015 remillet. All rights reserved.
//

import UIKit

class HappinessViewController: UIViewController, FaceViewDataSource
{
	@IBOutlet weak var faceView: FaceView! {
		didSet {
			faceView.faceViewDataSource = self
			faceView.addGestureRecognizer(UIPinchGestureRecognizer(target: faceView, action: "scale:"))
		}
	}
	
	override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
	
	private struct HappinessRange {
		static let HAPPINESS_MAX: Int = 100
		static let HAPPINESS_MIN: Int = 0
		static let HAPPINESS_AVG: Int = HAPPINESS_MAX / 2
	}
	
	//
	// Additions from lecture
	//
	func smilinessForFaceView(sender: FaceView) -> Double? {
		let result = Double(self.happiness - HappinessRange.HAPPINESS_AVG) / Double(HappinessRange.HAPPINESS_AVG)
		let avg = HappinessRange.HAPPINESS_AVG
		return result
	}
	
	// Our happiness model
	var happiness: Int = 100 {// 0 = very sad, 100 = ecstatic
		didSet {
			happiness = min(max(happiness, 0), HappinessRange.HAPPINESS_MAX) // keep happiness between 0 and 100
			println("Happiness value is = \(happiness)")
			updateUI()
		}
	}
	
	private func updateUI() {
		faceView.setNeedsDisplay()
	}
}
