//
//  HappinessViewController.swift
//  Happiness
//
//  Created by Richard E Millet on 2/15/15.
//  Copyright (c) 2015 remillet. All rights reserved.
//

import UIKit

class HappinessViewController: UIViewController
{
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
	
	//
	// Additions from lecture
	//
	
	// Our happiness model
	var happiness: Int = 50 {// 0 = very sad, 100 = ecstatic
		didSet {
			happiness = min(max(happiness, 0), 100) // keep happiness between 0 and 100
			println("Happiness value is = \(happiness)")
			updateUI()
		}
	}
	
	private func updateUI() {
		
	}
}
