//
//  AppDelegate.swift
//  InLocalCustomer
//
//  Created by Sudipta Patel on 27/05/21.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    static var shared: AppDelegate!
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
        moveToLoginVC()
        
        return true
    }

    func moveToLoginVC(){
        
        let signinStoryboard = UIStoryboard.init(name: "Signin", bundle: nil)
        let signinViewController = signinStoryboard.instantiateViewController(withIdentifier: "SigninVC")
        window?.rootViewController = signinViewController
        window?.makeKeyAndVisible()
    }

}

