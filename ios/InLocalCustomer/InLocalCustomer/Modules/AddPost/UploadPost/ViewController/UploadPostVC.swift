//
//  UploadPostVC.swift
//  InLocalCustomer
//
//  Created by Sajib Ghosh on 15/06/21.
//  Copyright © 2021 ___ORGANIZATIONNAME___. All rights reserved.
//
//

import UIKit

protocol ComeOnTabScreen {
    func setCropFlag()
}

class UploadPostVC: UIViewController {
    // MARK: Instance variables
	lazy var dataManager = UploadPostDataManager()
    var dependency: UploadPostDependency!
    // MARK: - View Life Cycle Methods
    
    @IBOutlet weak var imgPicked: UIImageView!
    @IBOutlet weak var selectRestaurantView: UIView!
    @IBOutlet weak var placeholderView: UIView!
    
    var comeOnTabScreenDelegate : ComeOnTabScreen!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        dataManager.apiResponseDelegate = self
        
        selectRestaurantView.layer.borderWidth = 1.0
        selectRestaurantView.layer.borderColor = UIColor(hexString: "c2c2c2").cgColor
        
        placeholderView.layer.borderWidth = 1.0
        placeholderView.layer.borderColor = UIColor(hexString: "c2c2c2").cgColor
        
        imgPicked.image = dependency.selectedImage
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
        comeOnTabScreenDelegate.setCropFlag()
    }
    
    // MARK: Deinitialization
    deinit {
       debugPrint("\(self) deinitialized")
    }
    
    @IBAction func didTapOnBack(_ sender: UIButton) {
        navigationController?.popViewController(animated: true)
    }
    
    @IBAction func didTapOnPreviousOrder(_ sender: UIButton) {
        let dependency = OrderListDependency(isComingFromUpload: false)
        guard let vc = OrderListVC.loadFromXIB(withDependency: dependency) else{
            return
        }
        navigationController?.pushViewController(vc, animated: true)
        
    }
    
    @IBAction func didTapOnPost(_ sender: UIButton) {
        //navigationController?.popViewController(animated: true)
        navigationController?.popToRootViewController(animated: true)
    }
}

// MARK: - Load from storyboard with dependency
extension UploadPostVC {
    class func loadFromXIB(withDependency dependency: UploadPostDependency? = nil) -> UploadPostVC? {
        let storyboard = UIStoryboard(name: "UploadPost", bundle: nil)
        guard let viewController = storyboard.instantiateViewController(withIdentifier: "UploadPostVC") as? UploadPostVC else {
            return nil
        }
        viewController.dependency = dependency
        return viewController
    }
}

// MARK: - UploadPostAPIResponseDelegate
extension UploadPostVC: UploadPostAPIResponseDelegate {
}
