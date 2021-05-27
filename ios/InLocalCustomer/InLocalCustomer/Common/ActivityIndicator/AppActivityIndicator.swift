//
//  WSUActivityIndicator.swift
//  WannaSeeYou
//
//  Created by SANDEEP DUTTA on 08/07/19.
//  Copyright © 2019 Innofied Solution Pvt. Ltd. All rights reserved.
//

import Foundation
import UIKit
import JGProgressHUD


class AppActivityIndicator: JGProgressHUD {
    
   static var hud: JGProgressHUD!
    
   class func showActivityIndicator(displayStyle: JGProgressHUDStyle = .dark, displayMessage: String = "Loading...", showInView: UIView) {
    
        if hud == nil {
            hud = JGProgressHUD(style: displayStyle)
            hud.textLabel.text = displayMessage
        }
        hud.show(in: showInView)
    }
    
   class func hideActivityIndicator() {
    
    
        if hud != nil {
            hud.dismiss()
            hud = nil
        }
    }
}
