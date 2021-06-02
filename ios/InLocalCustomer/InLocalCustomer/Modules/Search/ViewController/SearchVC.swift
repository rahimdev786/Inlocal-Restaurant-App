//
//  SearchVC.swift
//  InLocalCustomer
//
//  Created by Sudipta Patel on 02/06/21.
//  Copyright © 2021 ___ORGANIZATIONNAME___. All rights reserved.
//
//

import UIKit

class SearchVC: UIViewController {
    
    // MARK: Instance variables
	lazy var dataManager = SearchDataManager()
    var dependency: SearchDependency?
    
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
extension SearchVC {
    
    class func load(withDependency dependency: SearchDependency? = nil) -> SearchVC? {
        
        let storyboard = UIStoryboard(name: "Search", bundle: nil)
        
        guard let vc = storyboard.instantiateViewController(withIdentifier: "SearchVC") as? SearchVC else {
            return nil
        }
        vc.dependency = dependency
        return vc
    }
}

// MARK: - SearchAPIResponseDelegate
extension SearchVC: SearchAPIResponseDelegate {
    
}
