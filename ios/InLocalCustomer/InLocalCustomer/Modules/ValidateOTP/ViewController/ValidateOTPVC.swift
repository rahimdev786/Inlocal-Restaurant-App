//
//  ValidateOTPVC.swift
//  InLocalCustomer
//
//  Created by Sudipta Patel on 31/05/21.
//  Copyright © 2021 ___ORGANIZATIONNAME___. All rights reserved.
//
//

import UIKit

class ValidateOTPVC: UIViewController {
    
    // MARK: Instance variables
	lazy var dataManager = ValidateOTPDataManager()
    var dependency: ValidateOTPDependency?
    
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
extension ValidateOTPVC {
    
    class func load(withDependency dependency: ValidateOTPDependency? = nil) -> ValidateOTPVC? {
        
        let storyboard = UIStoryboard(name: "ValidateOTP", bundle: nil)
        
        guard let vc = storyboard.instantiateViewController(withIdentifier: "ValidateOTPVC") as? ValidateOTPVC else {
            return nil
        }
        vc.dependency = dependency
        return vc
    }
}

// MARK: - ValidateOTPAPIResponseDelegate
extension ValidateOTPVC: ValidateOTPAPIResponseDelegate {
    
}
