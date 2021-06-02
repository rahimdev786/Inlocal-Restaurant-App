//
//  AppDelegate.swift
//  InLocalCustomer
//
//  Created by Sudipta Patel on 27/05/21.
//

import UIKit
import IQKeyboardManagerSwift

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    static var shared: AppDelegate!
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
        
        moveToLoginVC()
        //moveToTabBarVC()
        // IQKeyboard
        IQKeyboardManager.shared.enable = true
        return true
    }

    func moveToLoginVC(){
        
        let signinStoryboard = UIStoryboard.init(name: "Signin", bundle: nil)
        let signinViewController = signinStoryboard.instantiateViewController(withIdentifier: "SigninVC")
        let navVC = UINavigationController(rootViewController: signinViewController)
        navVC.isNavigationBarHidden = true
        window?.rootViewController = navVC
        window?.makeKeyAndVisible()
    }

    func moveToTabBarVC(){
        
        let signinStoryboard = UIStoryboard.init(name: "BottumTabBar", bundle: nil)
        let signinViewController = signinStoryboard.instantiateViewController(withIdentifier: "BottumTabBarVC")
        window?.rootViewController = signinViewController
        window?.makeKeyAndVisible()
    }
    
}

