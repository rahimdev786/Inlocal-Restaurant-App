//
//  CustomPickerVC.swift
//  InLocalCustomer
//
//  Created by Sajib Ghosh on 14/06/21.
//  Copyright © 2021 ___ORGANIZATIONNAME___. All rights reserved.
//
//

import UIKit

class CustomPickerVC: UIViewController {
    // MARK: Instance variables
	lazy var dataManager = CustomPickerDataManager()
    var dependency: CustomPickerDependency?
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
extension CustomPickerVC {
    class func loadFromXIB(withDependency dependency: CustomPickerDependency? = nil) -> CustomPickerVC? {
        let storyboard = UIStoryboard(name: "CustomPicker", bundle: nil)
        guard let viewController = storyboard.instantiateViewController(withIdentifier: "CustomPickerVC") as? CustomPickerVC else {
            return nil
        }
        viewController.dependency = dependency
        return viewController
    }
}

// MARK: - CustomPickerAPIResponseDelegate
extension CustomPickerVC: CustomPickerAPIResponseDelegate {
}
