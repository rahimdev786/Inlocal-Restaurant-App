//
//  SetNewPasswordVC.swift
//  InLocalCustomer
//
//  Created by Sudipta Patel on 18/06/21.
//  Copyright © 2021 ___ORGANIZATIONNAME___. All rights reserved.
//
//

import UIKit

class SetNewPasswordVC: UIViewController {
    
    // MARK: Instance variables
	lazy var dataManager = SetNewPasswordDataManager()
    var dependency: SetNewPasswordDependency?
    
    @IBOutlet weak var txtFieldPassword: TextFieldView!
    @IBOutlet weak var txtFieldConfirmPassword: TextFieldView!
    
    @IBOutlet weak var btnSave: UIButton!
    
    var setNewPasswordRequest = SetNewPasswordRequest()
    
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
        //let appdelegate = UIApplication.shared.delegate as! AppDelegate
        //appdelegate.moveToLoginVC()
        let id = "11"
        guard let password = setNewPasswordRequest.newPassword,let confirmPassword = setNewPasswordRequest.conformPassword else{
            return
        }
        AppActivityIndicator.showActivityIndicator(displayStyle: .dark, displayMessage: "", showInView: self.view)
        dataManager.setNewPasswordCall(id: id, password: password)
    }
    
    func setupUI() {
      
        txtFieldPassword.delegate = self
        txtFieldPassword.populateWithData(text: "", placeholderText: "Password", fieldType: .newPassword)
        txtFieldPassword.txtFldInput.returnKeyType = UIReturnKeyType.next
        txtFieldPassword.txtFldInput.delegate = self
        txtFieldPassword.txtFldInput.tag = 0
        
        txtFieldConfirmPassword.delegate = self
        txtFieldConfirmPassword.populateWithData(text: "", placeholderText: "Confirm password", fieldType: .cnfrmPassword)
        txtFieldConfirmPassword.txtFldInput.returnKeyType = UIReturnKeyType.done
        txtFieldConfirmPassword.txtFldInput.delegate = self
        txtFieldConfirmPassword.txtFldInput.tag = 1
        
        validateFields()
    }
    
    func validateFields() {
        if setNewPasswordRequest.newPassword?.isNullString() ?? true || setNewPasswordRequest.conformPassword?.isNullString() ?? true{
            btnSave.alpha = 0.5
            btnSave.isUserInteractionEnabled = false
        } else{
            btnSave.alpha = 1
            btnSave.isUserInteractionEnabled = true
        }
    }
    
}

// MARK: - Load from storyboard with dependency
extension SetNewPasswordVC {
    
    class func load(withDependency dependency: SetNewPasswordDependency? = nil) -> SetNewPasswordVC? {
        
        let storyboard = UIStoryboard(name: "SetNewPassword", bundle: nil)
        
        guard let vc = storyboard.instantiateViewController(withIdentifier: "SetNewPasswordVC") as? SetNewPasswordVC else {
            return nil
        }
        vc.dependency = dependency
        return vc
    }
}

// MARK: - SetNewPasswordAPIResponseDelegate
extension SetNewPasswordVC: SetNewPasswordAPIResponseDelegate {
    func setNewPasswordSuccess(withData: SetNewPasswordResponse) {
        print(withData)
    }
    
    func apiError(_ error: APIError) {
        
    }
    
    func networkError(_ error: Error) {
        
    }

}

extension SetNewPasswordVC: TextFieldDelegate{
   
   func forgotPwdClicked() {
       
   }
   
    func textFieldViewDidChangeEditing(_ textFieldView: TextFieldView, string: String) {
        let strText = string
        let fieldType = textFieldView.fieldType!
        switch fieldType {
        
        
        case .newPassword:
            if strText.isNullString() {
                setNewPasswordRequest.newPassword = ""
                textFieldView.showError(with: "* Required")
            } else if Validator.isValid(itemToValidate: strText , validationType: .password){
                setNewPasswordRequest.newPassword = strText
                textFieldView.hideError()
            } else{
                setNewPasswordRequest.newPassword = ""
                textFieldView.showError(with: "Password must be 8 characters, must contain at least 1 special character, must contaibn at least 1 number & 1 uppercase character")
            }
            
            if setNewPasswordRequest.conformPassword?.isNullString() ?? true{
                
            } else{
                if strText == setNewPasswordRequest.conformPassword{
                    textFieldView.hideError()
                } else{
                    textFieldView.showError(with: "Confirm password does not match")
                }
                
            }
            
        case .cnfrmPassword:
            
            if strText.isNullString() {
                setNewPasswordRequest.conformPassword = ""
                textFieldView.showError(with: "* Required")
                
            } else if strText == setNewPasswordRequest.newPassword {
                setNewPasswordRequest.conformPassword = strText
                textFieldView.hideError()
            } else{
                setNewPasswordRequest.conformPassword = ""
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

extension SetNewPasswordVC: UITextFieldDelegate {
   
   func textFieldShouldReturn(_ textField: UITextField) -> Bool {
       
    if  txtFieldPassword.txtFldInput.tag == textField.tag {
        txtFieldConfirmPassword.txtFldInput.becomeFirstResponder()
       } else{
           textField.resignFirstResponder()
       }
       
       return true
       
   }
}
