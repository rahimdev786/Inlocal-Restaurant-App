//
//  SavedPostsVC.swift
//  InLocalCustomer
//
//  Created by Sajib Ghosh on 07/06/21.
//  Copyright © 2021 ___ORGANIZATIONNAME___. All rights reserved.
//
//

import UIKit

class SavedPostsVC: UIViewController {
    // MARK: Instance variables
	lazy var dataManager = SavedPostsDataManager()
    var dependency: SavedPostsDependency?
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
extension SavedPostsVC {
    class func loadFromXIB(withDependency dependency: SavedPostsDependency? = nil) -> SavedPostsVC? {
        let storyboard = UIStoryboard(name: "SavedPosts", bundle: nil)
        guard let viewController = storyboard.instantiateViewController(withIdentifier: "SavedPostsVC") as? SavedPostsVC else {
            return nil
        }
        viewController.dependency = dependency
        return viewController
    }
}

// MARK: - SavedPostsAPIResponseDelegate
extension SavedPostsVC: SavedPostsAPIResponseDelegate {
}
