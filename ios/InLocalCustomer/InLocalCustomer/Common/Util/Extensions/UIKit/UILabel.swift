//
//  UILabel.swift
//  OneClick
//
//  Created by Sauvik Dolui on 23/08/17.
//  Copyright © 2017 Sauvik Dolui. All rights reserved.
//

import UIKit

extension UILabel {
	
	func startBlink() {
		UIView.animate(withDuration: 0.8,
		               delay:0.0,
		               options:[.autoreverse, .repeat],
		               animations: {
						self.alpha = 0
		}, completion: nil)
	}
	
	func stopBlink() {
		alpha = 1
		layer.removeAllAnimations()
	}
}
