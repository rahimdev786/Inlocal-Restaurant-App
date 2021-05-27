//
//  UIWindow.swift
//  OneClick
//
//  Created by Sauvik Dolui on 22/09/17.
//  Copyright © 2017 Innofied. All rights reserved.
//

import Foundation
import UIKit

extension UIWindow {
    
    func replaceRootViewControllerWith(_ replacementController: UIViewController, animated: Bool, completion: (() -> Void)?) {
        let snapshotImageView = UIImageView(image: self.snapshot())
        self.addSubview(snapshotImageView)
        
        let dismissCompletion = { [weak self] in // dismiss all modal view controllers
            self?.rootViewController = replacementController
            self?.bringSubviewToFront(snapshotImageView)
            if animated {
                UIView.animate(withDuration: 0.4, animations: { () -> Void in
                    snapshotImageView.alpha = 0
                }, completion: { (success) -> Void in
                    snapshotImageView.removeFromSuperview()
                    completion?()
                })
            } else {
                snapshotImageView.removeFromSuperview()
                completion?()
            }
        }
        
        DispatchQueue.main.async { [weak self] in
            if self?.rootViewController!.presentedViewController != nil {
                self?.rootViewController!.dismiss(animated: false, completion: dismissCompletion)
            }
            else {
                dismissCompletion()
            }
        }
    }
    
    public func topMostWindowController()->UIViewController? {
        
        var topController = rootViewController
        
        while let presentedController = topController?.presentedViewController {
            topController = presentedController
        }
        
        return topController
    }
    
    public func currentViewController()->UIViewController? {
        
        var currentViewController = topMostWindowController()
        
        while currentViewController != nil && currentViewController is UINavigationController && (currentViewController as! UINavigationController).topViewController != nil {
            currentViewController = (currentViewController as! UINavigationController).topViewController
        }
        
        return currentViewController
    }
}
