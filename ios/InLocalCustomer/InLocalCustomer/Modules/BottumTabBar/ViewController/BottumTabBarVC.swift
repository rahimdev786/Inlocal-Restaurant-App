//
//  BottumTabBarVC.swift
//  InLocalCustomer
//
//  Created by Sudipta Patel on 01/06/21.
//  Copyright © 2021 ___ORGANIZATIONNAME___. All rights reserved.
//
//

import UIKit
import AZTabBar

class BottumTabBarVC: UIViewController {
    
    // MARK: Instance variables
	lazy var dataManager = BottumTabBarDataManager()
    var dependency: BottumTabBarDependency?
    
    var counter = 0
    var tabController:AZTabBarController!
    
    // MARK: - View Life Cycle Methods
	override func viewDidLoad() {
        super.viewDidLoad()
        
        dataManager.apiResponseDelegate = self
        setUpTabBat()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
    }
    
    // MARK: Deinitialization
    deinit {
       debugPrint("\(self) deinitialized")
    }
}

// MARK: - Load from storyboard with dependency
extension BottumTabBarVC {
    
    class func load(withDependency dependency: BottumTabBarDependency? = nil) -> BottumTabBarVC? {
        
        let storyboard = UIStoryboard(name: "BottumTabBar", bundle: nil)
        
        guard let vc = storyboard.instantiateViewController(withIdentifier: "BottumTabBarVC") as? BottumTabBarVC else {
            return nil
        }
        vc.dependency = dependency
        return vc
    }
}

// MARK: - BottumTabBarAPIResponseDelegate
extension BottumTabBarVC: BottumTabBarAPIResponseDelegate {
    
}

extension BottumTabBarVC{
    func setUpTabBat(){
        var icons = [UIImage]()
        icons.append(#imageLiteral(resourceName: "tab_home"))
        icons.append(#imageLiteral(resourceName: "tab_search"))
        icons.append(#imageLiteral(resourceName: "tab_addpost"))
        icons.append(#imageLiteral(resourceName: "tab_cart"))
        icons.append(#imageLiteral(resourceName: "tab_notification"))
        
        var sIcons = [UIImage]()
        sIcons.append(#imageLiteral(resourceName: "tab_home"))
        sIcons.append(#imageLiteral(resourceName: "tab_search"))
        sIcons.append(#imageLiteral(resourceName: "tab_addpost"))
        sIcons.append(#imageLiteral(resourceName: "tab_cart"))
        sIcons.append(#imageLiteral(resourceName: "tab_notification"))

        
        //init
        //tabController = .insert(into: self, withTabIconNames: icons)
        tabController = .insert(into: self, withTabIcons: icons, andSelectedIcons: sIcons)

        //set delegate
        tabController.delegate = self
        /*
        //set child controllers
        tabController.setViewController(ColorSelectorController.instance(), atIndex: 0)

        let darkController = getNavigationController(root: LabelController.controller(text: "Search", title: "Recents"))
        darkController.navigationBar.barStyle = .black
        darkController.navigationBar.isTranslucent = false
        darkController.navigationBar.barTintColor = #colorLiteral(red: 0.2039215686, green: 0.2862745098, blue: 0.368627451, alpha: 1)


        tabController.setViewController(UIViewController(), atIndex: 1)

        tabController.setViewController(getNavigationController(root: LabelController.controller(text: "You should really focus on the tab bar.", title: "Chat")), atIndex: 3)

        let buttonController = ButtonController.controller(badgeCount: 0, currentIndex: 4)
        tabController.setViewController(getNavigationController(root: buttonController), atIndex: 4)
        */

        //customize

        let color = UIColor(red: 14.0/255, green: 122.0/255, blue: 254.0/255, alpha: 1.0)

        tabController.selectedColor = color

        tabController.highlightColor = color

        tabController.highlightedBackgroundColor = .blue

        tabController.defaultColor = .white

        //tabController.highlightButton(atIndex: 2)

        tabController.buttonsBackgroundColor = UIColor.init(hexString: "#333333") //UIColor(red: (247.0/255), green: (247.0/255), blue: (247.0/255), alpha: 1.0)

        tabController.selectionIndicatorHeight = 0

        tabController.selectionIndicatorColor = color

        tabController.tabBarHeight = 60

        tabController.notificationBadgeAppearance.backgroundColor = .red
        tabController.notificationBadgeAppearance.textColor = .white
        tabController.notificationBadgeAppearance.borderColor = .clear
        tabController.notificationBadgeAppearance.borderWidth = 0.2

        tabController.setBadgeText("0", atIndex: 4)

        tabController.setIndex(10, animated: true)

        tabController.setAction(atIndex: 3){
            self.counter = 0
            self.tabController.setBadgeText(nil, atIndex: 3)
        }

        tabController.setAction(atIndex: 2) {
            self.tabController.onlyShowTextForSelectedButtons = !self.tabController.onlyShowTextForSelectedButtons
        }

        tabController.setAction(atIndex: 4) {
            //self.tabController.setBar(hidden: true, animated: true)
        }

        tabController.setIndex(1, animated: true)

        tabController.animateTabChange = true
        tabController.onlyShowTextForSelectedButtons = false
        tabController.setTitle("", atIndex: 0)
        tabController.setTitle("", atIndex: 1)
        tabController.setTitle("", atIndex: 2)
        tabController.setTitle("", atIndex: 3)
        tabController.setTitle("", atIndex: 4)
        tabController.font = UIFont(name: "AvenirNext-Regular", size: 12)

        let container = tabController.buttonsContainer
        container?.layer.shadowOffset = CGSize(width: 0, height: -2)
        container?.layer.shadowRadius = 10
        container?.layer.shadowOpacity = 0.1
        container?.layer.shadowColor = UIColor.black.cgColor


        tabController.setButtonTintColor(color: #colorLiteral(red: 0.8078431487, green: 0.02745098062, blue: 0.3333333433, alpha: 1), atIndex: 0)
    }
}

extension BottumTabBarVC: AZTabBarDelegate{
    func tabBar(_ tabBar: AZTabBarController, statusBarStyleForIndex index: Int) -> UIStatusBarStyle {
        return (index % 2) == 0 ? .default : .lightContent
    }
    
    func tabBar(_ tabBar: AZTabBarController, shouldLongClickForIndex index: Int) -> Bool {
        return true//index != 2 && index != 3
    }
    
    func tabBar(_ tabBar: AZTabBarController, shouldAnimateButtonInteractionAtIndex index: Int) -> Bool {
        return true
    }
    
    func tabBar(_ tabBar: AZTabBarController, didMoveToTabAtIndex index: Int) {
        print("didMoveToTabAtIndex \(index)")
    }
    
    func tabBar(_ tabBar: AZTabBarController, didSelectTabAtIndex index: Int) {
        print("didSelectTabAtIndex \(index)")
    }
    
    func tabBar(_ tabBar: AZTabBarController, willMoveToTabAtIndex index: Int) {
        print("willMoveToTabAtIndex \(index)")
    }
    
    func tabBar(_ tabBar: AZTabBarController, didLongClickTabAtIndex index: Int) {
        print("didLongClickTabAtIndex \(index)")
    }
    
//    func tabBar(_ tabBar: AZTabBarController, systemSoundIdForButtonAtIndex index: Int) -> SystemSoundID? {
//        return tabBar.selectedIndex == index ? nil : audioId
//    }
    
}
