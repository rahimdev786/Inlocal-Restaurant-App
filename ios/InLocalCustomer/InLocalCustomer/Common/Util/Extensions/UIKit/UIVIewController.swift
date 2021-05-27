//
//  UIVIewController.swift
//  e360
//
//  Created by Sauvik Dolui on 21/08/16.
//  Copyright © Sauvik Dolui. All rights reserved.
//

import UIKit
import Foundation

extension UIViewController {
    
    func showOTPAlart(otp:String) {
        
        let alertVC = UIAlertController(title: "OTP", message: otp, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default) { (_) in
            
            
        }
        
        alertVC.addAction(okAction)
        self.present(alertVC, animated: true, completion: nil)
    }
    
    func showAlert(title: String, message: String, okayButtonTitle: String,
                   buttonAction: @escaping () -> Void ) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        
        let buttonAction = UIAlertAction(title: okayButtonTitle, style: .default) { (action) in
            buttonAction()
        }
        
        alertController.addAction(buttonAction)
        self.present(alertController, animated: true) {
            ()
        }
    }
    
    func showAlert(title: String, message: String,
                   primaryButtonTitle: String,
                   secondaryButtonTitle: String,
                   primaryButtonAction: @escaping () -> Void,
                   secondaryAction: @escaping () -> Void) {
        
        
        let alertController = UIAlertController(title: title, message: message,
                                                preferredStyle: .alert)
        
        let primaryActionButton = UIAlertAction(title: primaryButtonTitle, style: .destructive) { (action) in
            primaryButtonAction()
        }
        let secondaryActionButton = UIAlertAction(title: secondaryButtonTitle,
                                                  style: .default) { (action) in
                                                    secondaryAction()
        }
        alertController.addAction(secondaryActionButton)
        alertController.addAction(primaryActionButton)
        
        self.present(alertController, animated: true, completion: {})
        
    }
    
    
    /*func navigateTo(_ vc: UIViewController?) {
        
        guard let vc = vc else {
            sideMenuViewController?.hideMenuViewController()
            return
        }
        
        let navController = PopNavigationController(rootViewController: vc)
        navController.isNavigationBarHidden = true
        sideMenuViewController?.contentViewController = navController
        sideMenuViewController?.hideMenuViewController()
    }*/
}

