//
//  AppDelegate.swift
//  InLocalCustomer
//
//  Created by Sudipta Patel on 27/05/21.
//SKU: 20210721
//com.innofied.app.InLocalCustomer
//com.app.InLocalCustomer
//Key Id : Q6L58AP2U6

import UIKit
import GoogleMaps
import GooglePlaces
import IQKeyboardManagerSwift
import Firebase

//@main
@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    static var shared: AppDelegate!
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
        AppDelegate.shared = self
        
        //Client key - AIzaSyAwRfuPEhmSsjGxT-kB57Yr4yeqKX5xr7Y
        GMSPlacesClient.provideAPIKey("AIzaSyAwRfuPEhmSsjGxT-kB57Yr4yeqKX5xr7Y")
        GMSServices.provideAPIKey("AIzaSyAwRfuPEhmSsjGxT-kB57Yr4yeqKX5xr7Y")
        
        thirdPartyConfiguration(application: application, launchOptions: launchOptions)
        
        if IEUserDefaults.shared.isUserLoggedIn{
            moveToTabBarVC()
        } else{
            moveToLoginVC()
        }
        
        // IQKeyboard
        IQKeyboardManager.shared.enable = true
        return true
    }

    func thirdPartyConfiguration(application: UIApplication, launchOptions: [UIApplication.LaunchOptionsKey: Any]?) {
          
        IEUserDefaults.shared.selectedLanguage = SelectedLanguage.English.lngName
          
        IQKeyboardManager.shared.enable = true
        IQKeyboardManager.shared.shouldResignOnTouchOutside = true
        
        //PushNotification
        FirebaseApp.configure()
        self.pushNotificationPermissionAuthorization(application: application)
        Messaging.messaging().delegate = self
        fetchFCMToken()
        
        //Development mode
        ServerConfig.mode = .localDevelopment
    }
    
    /*
    func application(_ app: UIApplication, open url: URL,
                     options: [UIApplication.OpenURLOptionsKey : Any] = [:]) -> Bool {
        if let scheme = url.scheme,
            scheme.localizedCaseInsensitiveCompare("com.inlocalCustomer") == .orderedSame,
            let view = url.host {
            
            var parameters: [String: String] = [:]
            URLComponents(url: url, resolvingAgainstBaseURL: false)?.queryItems?.forEach {
                parameters[$0.name] = $0.value
            }
            
            //redirect(to: view, with: parameters)
        }
        return true
    }
    */
    /*
    public func application(_ application: UIApplication,
                            continue userActivity: NSUserActivity,
                            restorationHandler: @escaping ([Any]?) -> Void) -> Bool {
        if let url = userActivity.webpageURL {
            var view = url.lastPathComponent
            var parameters: [String: String] = [:]
            URLComponents(url: url, resolvingAgainstBaseURL: false)?.queryItems?.forEach {
                parameters[$0.name] = $0.value
            }
            
            //redirect(to: view, with: parameters)
        }
        return true
    }
    */
    
    func application(_ application: UIApplication, continue userActivity: NSUserActivity, restorationHandler: @escaping ([UIUserActivityRestoring]?) -> Void) -> Bool {
        
        if let url = userActivity.webpageURL {
            print(url)
            
            let urlString = String(describing: url)
            
            let array = urlString.components(separatedBy: "/")
            
            let rid = array[4]
            let tid = array[6]
            
            /*
            //var view = url.lastPathComponent
            var parameters: [String: String] = [:]
            URLComponents(url: url, resolvingAgainstBaseURL: false)?.queryItems?.forEach {
                parameters[$0.name] = $0.value
            }
            print(parameters)
            //redirect(to: view, with: parameters)
            */
        }
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

