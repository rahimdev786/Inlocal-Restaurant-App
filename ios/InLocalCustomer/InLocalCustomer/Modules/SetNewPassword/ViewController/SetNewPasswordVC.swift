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
        let appdelegate = UIApplication.shared.delegate as! AppDelegate
        appdelegate.moveToLoginVC()
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
    
}

extension SetNewPasswordVC: TextFieldDelegate{
   
   func forgotPwdClicked() {
       
   }
   
   func textFieldViewDidChangeEditing(_ textFieldView: TextFieldView, string: String) {
       let strText = string
       let fieldType = textFieldView.fieldType!
       switch fieldType {
       

       case .newPassword:
        setNewPasswordRequest.newPassword = strText
                     
           if strText.isNullString() {
               textFieldView.showError(with: "* Required")
           } else if strText.count >= 6{
               textFieldView.hideError()
           } else{
               textFieldView.showError(with: "Password should be atleast 6 characters")
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
        setNewPasswordRequest.conformPassword = strText
           if strText.isNullString() {
               textFieldView.showError(with: "* Required")
               
           } else if strText == setNewPasswordRequest.newPassword {
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
