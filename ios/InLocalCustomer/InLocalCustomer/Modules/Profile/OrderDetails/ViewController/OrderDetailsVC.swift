//
//  OrderDetailsVC.swift
//  InLocalCustomer
//
//  Created by Sajib Ghosh on 02/06/21.
//  Copyright © 2021 ___ORGANIZATIONNAME___. All rights reserved.
//
//

import UIKit

class OrderDetailsVC: UIViewController {
    // MARK: Instance variables
	lazy var dataManager = OrderDetailsDataManager()
    var dependency: OrderDetailsDependency?
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
extension OrderDetailsVC {
    class func loadFromXIB(withDependency dependency: OrderDetailsDependency? = nil) -> OrderDetailsVC? {
        let storyboard = UIStoryboard(name: "OrderDetails", bundle: nil)
        guard let viewController = storyboard.instantiateViewController(withIdentifier: "OrderDetailsVC") as? OrderDetailsVC else {
            return nil
        }
        viewController.dependency = dependency
        return viewController
    }
}

// MARK: - OrderDetailsAPIResponseDelegate
extension OrderDetailsVC: OrderDetailsAPIResponseDelegate {
}
