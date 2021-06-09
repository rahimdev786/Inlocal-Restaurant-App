//
//  FollowerVC.swift
//  InLocalCustomer
//
//  Created by Sajib Ghosh on 09/06/21.
//  Copyright © 2021 ___ORGANIZATIONNAME___. All rights reserved.
//
//

import UIKit

class FollowerVC: UIViewController {
    // MARK: Instance variables
	lazy var dataManager = FollowerDataManager()
    var dependency: FollowerDependency?
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
extension FollowerVC {
    class func loadFromXIB(withDependency dependency: FollowerDependency? = nil) -> FollowerVC? {
        let storyboard = UIStoryboard(name: "Follower", bundle: nil)
        guard let viewController = storyboard.instantiateViewController(withIdentifier: "FollowerVC") as? FollowerVC else {
            return nil
        }
        viewController.dependency = dependency
        return viewController
    }
}

// MARK: - FollowerAPIResponseDelegate
extension FollowerVC: FollowerAPIResponseDelegate {
}
