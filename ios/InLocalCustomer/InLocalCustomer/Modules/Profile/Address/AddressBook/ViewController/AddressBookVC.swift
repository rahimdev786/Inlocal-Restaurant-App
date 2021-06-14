//
//  AddressBookVC.swift
//  InLocalCustomer
//
//  Created by Sudipta Patel on 14/06/21.
//  Copyright © 2021 ___ORGANIZATIONNAME___. All rights reserved.
//
//

import UIKit

class AddressBookVC: UIViewController {
    
    // MARK: Instance variables
	lazy var dataManager = AddressBookDataManager()
    var dependency: AddressBookDependency?
    
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
extension AddressBookVC {
    
    class func load(withDependency dependency: AddressBookDependency? = nil) -> AddressBookVC? {
        
        let storyboard = UIStoryboard(name: "AddressBook", bundle: nil)
        
        guard let vc = storyboard.instantiateViewController(withIdentifier: "AddressBookVC") as? AddressBookVC else {
            return nil
        }
        vc.dependency = dependency
        return vc
    }
}

// MARK: - AddressBookAPIResponseDelegate
extension AddressBookVC: AddressBookAPIResponseDelegate {
    
}
