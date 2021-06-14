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
        setupUI()
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
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func onClickSave(_ sender: Any) {
    }
    
    func setupUI() {
      
        txtFiledCurrentPassword.layer.cornerRadius = txtFiledCurrentPassword.layer.bounds.height/2
        txtFiledCurrentPassword.layer.masksToBounds = true
        txtFiledCurrentPassword.delegate = self
        txtFiledCurrentPassword.populateWithData(text: "", placeholderText: "Current password", fieldType: .password)
        txtFiledCurrentPassword.txtFldInput.returnKeyType = UIReturnKeyType.next
        
        txtFiledNewPassword.layer.cornerRadius = txtFiledNewPassword.layer.bounds.height/2
        txtFiledNewPassword.layer.masksToBounds = true
        txtFiledNewPassword.delegate = self
        txtFiledNewPassword.populateWithData(text: "", placeholderText: "New password", fieldType: .password)
        txtFiledNewPassword.txtFldInput.returnKeyType = UIReturnKeyType.default
        
        txtFiledConfirmNewPassword.layer.cornerRadius = txtFiledConfirmNewPassword.layer.bounds.height/2
        txtFiledConfirmNewPassword.layer.masksToBounds = true
        txtFiledConfirmNewPassword.delegate = self
        txtFiledConfirmNewPassword.populateWithData(text: "", placeholderText: "Confirm new password", fieldType: .password)
        txtFiledConfirmNewPassword.txtFldInput.returnKeyType = UIReturnKeyType.default
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

 extension ChangePasswordVC: TextFieldDelegate{
    
    func forgotPwdClicked() {
        
    }
    
    func textFieldViewDidChangeEditing(_ textFieldView: TextFieldView, string: String) {
        
    }
    
     func textFiedViewDidEndEditing(_ textFieldView: TextFieldView) {
         
     }
     
     func textFieldViewShouldReturn(_ textFieldView: TextFieldView) -> Bool {
    
         return true
     }
     
 }
