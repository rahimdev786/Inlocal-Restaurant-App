//
//  UIButton.swift
//  Bedcoin
//
//  Created by Sudipta Patel on 08/01/20.
//  Copyright © 2020 Sudipta Patel. All rights reserved.
//

import Foundation
import  UIKit

extension UIButton{
    func roundCorners(_ corners: UIRectCorner, radius: CGFloat) {
        let path = UIBezierPath(roundedRect: self.bounds, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
        let mask = CAShapeLayer()
        mask.path = path.cgPath
        self.layer.mask = mask
    }
}
