//
//  BookingListVC.swift
//  InLocalCustomer
//
//  Created by Sajib Ghosh on 02/06/21.
//  Copyright © 2021 ___ORGANIZATIONNAME___. All rights reserved.
//
//

import UIKit

class BookingListVC: UIViewController {
    // MARK: Instance variables
	lazy var dataManager = BookingListDataManager()
    var dependency: BookingListDependency?
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
extension BookingListVC {
    class func loadFromXIB(withDependency dependency: BookingListDependency? = nil) -> BookingListVC? {
        let storyboard = UIStoryboard(name: "BookingList", bundle: nil)
        guard let viewController = storyboard.instantiateViewController(withIdentifier: "BookingListVC") as? BookingListVC else {
            return nil
        }
        viewController.dependency = dependency
        return viewController
    }
}

// MARK: - BookingListAPIResponseDelegate
extension BookingListVC: BookingListAPIResponseDelegate {
}
