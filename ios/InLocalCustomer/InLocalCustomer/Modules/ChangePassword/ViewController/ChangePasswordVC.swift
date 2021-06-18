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
    
    var changePasswordRequest = ChangePasswordRequest()
    
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
        
        let alert = UIAlertController(title: "Success", message: "Change Password Successful", preferredStyle: .alert)
        let action = UIAlertAction(title: "Ok", style: .default) { (sucess) in
            self.navigationController?.popViewController(animated: true)
        }
        alert.addAction(action)
        self.present(alert, animated: true) {
            self.navigationController?.popViewController(animated: true)
        }
    }
    
    func setupUI() {
      
        txtFiledCurrentPassword.delegate = self
        txtFiledCurrentPassword.populateWithData(text: "", placeholderText: "Current password", fieldType: .oldPassword)
        txtFiledCurrentPassword.txtFldInput.returnKeyType = UIReturnKeyType.next
        txtFiledCurrentPassword.txtFldInput.delegate = self
        txtFiledCurrentPassword.txtFldInput.tag = 0
        
        txtFiledNewPassword.delegate = self
        txtFiledNewPassword.populateWithData(text: "", placeholderText: "New password", fieldType: .newPassword)
        txtFiledNewPassword.txtFldInput.returnKeyType = UIReturnKeyType.next
        txtFiledNewPassword.txtFldInput.delegate = self
        txtFiledNewPassword.txtFldInput.tag = 1
        
        txtFiledConfirmNewPassword.delegate = self
        txtFiledConfirmNewPassword.populateWithData(text: "", placeholderText: "Confirm new password", fieldType: .cnfrmPassword)
        txtFiledConfirmNewPassword.txtFldInput.returnKeyType = UIReturnKeyType.done
        txtFiledConfirmNewPassword.txtFldInput.delegate = self
        txtFiledConfirmNewPassword.txtFldInput.tag = 2
        
        validateFields()
    }
    
    func validateFields() {
        if changePasswordRequest.currentPassword?.isNullString() ?? true || changePasswordRequest.newPassword?.isNullString() ?? true || changePasswordRequest.confirmNewPassword?.isNullString() ?? true {
            btnSave.alpha = 0.5
            btnSave.isUserInteractionEnabled = false
        } else{
            btnSave.alpha = 1
            btnSave.isUserInteractionEnabled = true
        }
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
        let strText = string
        let fieldType = textFieldView.fieldType!
        switch fieldType {
        
        case .oldPassword:
            changePasswordRequest.currentPassword = strText
            if strText.isNullString() {
                textFieldView.showError(with: "* Required")
            }else if strText.count >= 6{
                textFieldView.hideError()
            } else{
                textFieldView.showError(with: "Password should be atleast 6 characters")
            }
            
        case .newPassword:
            changePasswordRequest.newPassword = strText
                      
            if strText.isNullString() {
                textFieldView.showError(with: "* Required")
            } else if strText.count >= 6{
                textFieldView.hideError()
            } else{
                textFieldView.showError(with: "Password should be atleast 6 characters")
            }
               
            if changePasswordRequest.confirmNewPassword?.isNullString() ?? true{
                   
            } else{
                if strText == changePasswordRequest.confirmNewPassword{
                    textFieldView.hideError()
                } else{
                    textFieldView.showError(with: "Confirm password does not match")
                }
               
            }
            
        case .cnfrmPassword:
            changePasswordRequest.confirmNewPassword = strText
            if strText.isNullString() {
                textFieldView.showError(with: "* Required")
                
            } else if strText == changePasswordRequest.newPassword {
                textFieldView.hideError()
            } else{
                textFieldView.showError(with: "Confirm password does not match")
            }
            
        default:
            break
        }
        
        validateFields()
    }
    
     func textFiedViewDidEndEditing(_ textFieldView: TextFieldView) {
         
     }
     
     func textFieldViewShouldReturn(_ textFieldView: TextFieldView) -> Bool {
    
         return true
     }
     
 }
 
 extension ChangePasswordVC: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        
        if  txtFiledCurrentPassword.tag == textField.tag {
            txtFiledNewPassword.txtFldInput.becomeFirstResponder()
        } else if txtFiledNewPassword.tag == textField.tag {
            txtFiledConfirmNewPassword.txtFldInput.becomeFirstResponder()
        }else{
            textField.resignFirstResponder()
        }
        
        return true
        
    }
 }
