//
//  UIView.swift
//  e360
//
//  Created by Sauvik Dolui on 17/12/16.
//  Copyright © 2017 Sauvik Dolui. All rights reserved.
//

import Foundation
import UIKit

private enum Axis: StringLiteralType {
	case x = "x"
	case y = "y"
}

extension UIView {
	private func shake(on axis: Axis) {
		let animation = CAKeyframeAnimation(keyPath: "transform.translation.\(axis.rawValue)")
        animation.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.linear)
		animation.duration = 0.6
		animation.values = [-20, 20, -20, 20, -10, 10, -5, 5, 0]
		layer.add(animation, forKey: "shake")
	}
	func shakeOnXAxis() {
		self.shake(on: .x)
	}
	func shakeOnYAxis() {
		self.shake(on: .y)
	}
    
    static func loadViewFromXib(owner: AnyObject) -> UIView? {
        guard let view = Bundle.main.loadNibNamed("\(self)", owner: owner, options: nil)?.first as? UIView else {
            return nil
        }
        return view
    }
    
}
extension UIView {
    func snapshot() -> UIImage {
        UIGraphicsBeginImageContextWithOptions(bounds.size, false, UIScreen.main.scale)
        drawHierarchy(in: bounds, afterScreenUpdates: true)
        let result = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return result ?? UIImage()
    }
}

extension UIView {
    
    func roundCorners(_ corners: CACornerMask, radius: CGFloat) {
        if #available(iOS 11, *) {
            self.layer.cornerRadius = radius
            self.layer.maskedCorners = corners
        } else {
            var cornerMask = UIRectCorner()
            if(corners.contains(.layerMinXMinYCorner)){
                cornerMask.insert(.topLeft)
            }
            if(corners.contains(.layerMaxXMinYCorner)){
                cornerMask.insert(.topRight)
            }
            if(corners.contains(.layerMinXMaxYCorner)){
                cornerMask.insert(.bottomLeft)
            }
            if(corners.contains(.layerMaxXMaxYCorner)){
                cornerMask.insert(.bottomRight)
            }
            let path = UIBezierPath(roundedRect: self.bounds, byRoundingCorners: cornerMask, cornerRadii: CGSize(width: radius, height: radius))
            let mask = CAShapeLayer()
            mask.path = path.cgPath
            self.layer.mask = mask
        }
    }
}

// MARK: - Load from NIB
extension UIView {
    
    class func loadFromNib<T>(withName nibName: String) -> T? {
        let nib  = UINib.init(nibName: nibName, bundle: nil)
        let nibObjects = nib.instantiate(withOwner: nil, options: nil)
        for object in nibObjects {
            if let result = object as? T {
                return result
            }
        }
        return nil
    }
}

extension UIView {
    
    func roundedCorners(_ corners: UIRectCorner, radius: CGFloat) {
        let path = UIBezierPath(roundedRect: self.bounds, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
        let mask = CAShapeLayer()
        mask.path = path.cgPath
        self.layer.mask = mask
    }
    
}

extension UIView{
    // add gradient to uiview
    
    public func applyGradient(color: [UIColor],location: [NSNumber]?) {
        let gradient = CAGradientLayer()
        gradient.frame = self.bounds
        gradient.colors = color.map({$0.cgColor})
        gradient.locations = location
        gradient.startPoint = CGPoint(x: 0.5,y: 0.0)// CGPoint(x: 0.0,y: 0.5)
        gradient.endPoint = CGPoint(x: 0.5,y: 1.0)//CGPoint(x: 1.0,y: 0.5)
        self.layer.insertSublayer(gradient, at: 0)
    }
    
}

/*
extension UIView{
    func showLoader(){
        if let appdelegate = AppDelegate.shared{
            appdelegate.acitivityIndicator.color = AppColors.headerDarkPurple.color
            appdelegate.acitivityIndicator.startAnimating()
            isUserInteractionEnabled = false
            addSubview(appdelegate.acitivityIndicator)
            appdelegate.acitivityIndicator.center = center
        }
    }
    
    func hideLoader(){
        isUserInteractionEnabled = true
        if let activityIndicator = AppDelegate.shared?.acitivityIndicator, activityIndicator.isAnimating{
            AppDelegate.shared?.acitivityIndicator.stopAnimating()
        }
        AppDelegate.shared?.acitivityIndicator.removeFromSuperview()
    }
}
*/
