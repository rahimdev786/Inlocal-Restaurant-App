//
//  PublicFeedwallVC.swift
//  InLocalCustomer
//
//  Created by Sudipta Patel on 03/06/21.
//  Copyright © 2021 ___ORGANIZATIONNAME___. All rights reserved.
//
//

import UIKit

class PublicFeedwallVC: UIViewController {
    
    // MARK: Instance variables
	lazy var dataManager = PublicFeedwallDataManager()
    var dependency: PublicFeedwallDependency?
    
    // MARK: - View Life Cycle Methods
	override func viewDidLoad() {
        super.viewDidLoad()
        
        dataManager.apiResponseDelegate = self
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
extension PublicFeedwallVC {
    
    class func load(withDependency dependency: PublicFeedwallDependency? = nil) -> PublicFeedwallVC? {
        
        let storyboard = UIStoryboard(name: "PublicFeedwall", bundle: nil)
        
        guard let vc = storyboard.instantiateViewController(withIdentifier: "PublicFeedwallVC") as? PublicFeedwallVC else {
            return nil
        }
        vc.dependency = dependency
        return vc
    }
}

// MARK: - PublicFeedwallAPIResponseDelegate
extension PublicFeedwallVC: PublicFeedwallAPIResponseDelegate {
    
}
