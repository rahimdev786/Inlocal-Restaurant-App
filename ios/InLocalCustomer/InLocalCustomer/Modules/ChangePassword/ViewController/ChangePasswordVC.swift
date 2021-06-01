 //
//  ChangePasswordVC.swift
//  InLocalCustomer
//
//  Created by Sudipta Patel on 01/06/21.
//  Copyright © 2021 ___ORGANIZATIONNAME___. All rights reserved.
//
//

import UIKit

class ChangePasswordVC: UIViewController {
    
    // MARK: Instance variables
	lazy var dataManager = ChangePasswordDataManager()
    var dependency: ChangePasswordDependency?
    
    @IBOutlet weak var lblCurrentPassword: UILabel!
    @IBOutlet weak var lblNewPassword: UILabel!
    @IBOutlet weak var lblConfirmNewPassword: UILabel!
    
    @IBOutlet weak var txtFiledCurrentPassword: TextFieldView!
    @IBOutlet weak var txtFiledNewPassword: TextFieldView!
    @IBOutlet weak var txtFiledConfirmNewPassword: TextFieldView!
    
    @IBOutlet weak var btnSave: UIButton!
    
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
    
    @IBAction func onClickBack(_ sender: Any) {
    }
    
    @IBAction func onClickSave(_ sender: Any) {
    }
    
}

// MARK: - Load from storyboard with dependency
extension ChangePasswordVC {
    
    class func load(withDependency dependency: ChangePasswordDependency? = nil) -> ChangePasswordVC? {
        
        let storyboard = UIStoryboard(name: "ChangePassword", bundle: nil)
        
        guard let vc = storyboard.instantiateViewController(withIdentifier: "ChangePasswordVC") as? ChangePasswordVC else {
            return nil
        }
        vc.dependency = dependency
        return vc
    }
}

// MARK: - ChangePasswordAPIResponseDelegate
extension ChangePasswordVC: ChangePasswordAPIResponseDelegate {
    
}
