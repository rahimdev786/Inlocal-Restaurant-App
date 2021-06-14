//
//  UIView + Gradient.swift
//  UPC_App_Customer_Innofied
//
//  Created by Writayan Das on 17/06/19.
//  Copyright © 2019 Innofied Solution Pvt. Ltd. All rights reserved.
//

import UIKit

class GradientVieww: UIView {
    
    override open class var layerClass: AnyClass {
        return CAGradientLayer.classForCoder()
    }
    
    required init?(coder aDecoder: NSCoder) {
        
        super.init(coder: aDecoder)
        
        let gradientLayer:CAGradientLayer = CAGradientLayer()
        gradientLayer.frame.size = self.frame.size
        
        gradientLayer.colors = [
            UIColor.white.withAlphaComponent(0.0).cgColor,
            UIColor.white.withAlphaComponent(0.5).cgColor,
            UIColor.white.withAlphaComponent(0.8).cgColor,
            UIColor.white.withAlphaComponent(0.95).cgColor,
            UIColor.white.cgColor
        ]
        layer.insertSublayer(gradientLayer, at: 0)
    }
}
