//
//  AppDelegate.swift
//  InLocalCustomer
//
//  Created by Sudipta Patel on 27/05/21.
//

import UIKit
import GoogleMaps
import GooglePlaces
import IQKeyboardManagerSwift

//@main
@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    static var shared: AppDelegate!
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
        AppDelegate.shared = self
        
        GMSPlacesClient.provideAPIKey("AIzaSyBSwxGcA3qxi0HX7J5TlGaRng2z-KUBgFI")
        GMSServices.provideAPIKey("AIzaSyBSwxGcA3qxi0HX7J5TlGaRng2z-KUBgFI")
        
        moveToLoginVC()
        //moveToTabBarVC()
        
        // IQKeyboard
        IQKeyboardManager.shared.enable = true
        return true
    }

    func moveToLoginVC(){
        guard let signinViewController = SigninVC.load(withDependency: nil) else {
            return
        }
        let navVC = UINavigationController(rootViewController: signinViewController)
        navVC.isNavigationBarHidden = true
        window?.rootViewController = navVC
        window?.makeKeyAndVisible()
    }

    func moveToTabBarVC(){
        guard let tabViewController = BottumTabBarVC.load(withDependency: nil) else {
            return
        }
        let navVC = UINavigationController(rootViewController: tabViewController)
        navVC.isNavigationBarHidden = true
        window?.rootViewController = navVC
        window?.makeKeyAndVisible()
    }
    
}

