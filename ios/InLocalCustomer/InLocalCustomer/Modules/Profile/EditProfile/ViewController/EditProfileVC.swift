//
//  EditProfileVC.swift
//  InLocalCustomer
//
//  Created by Sajib Ghosh on 07/06/21.
//  Copyright © 2021 ___ORGANIZATIONNAME___. All rights reserved.
//
//

import UIKit

class EditProfileVC: UIViewController {
    // MARK: Instance variables
	lazy var dataManager = EditProfileDataManager()
    var dependency: EditProfileDependency?
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
extension EditProfileVC {
    class func loadFromXIB(withDependency dependency: EditProfileDependency? = nil) -> EditProfileVC? {
        let storyboard = UIStoryboard(name: "EditProfile", bundle: nil)
        guard let viewController = storyboard.instantiateViewController(withIdentifier: "EditProfileVC") as? EditProfileVC else {
            return nil
        }
        viewController.dependency = dependency
        return viewController
    }
}

// MARK: - EditProfileAPIResponseDelegate
extension EditProfileVC: EditProfileAPIResponseDelegate {
}
