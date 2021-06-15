//
//  ForgotPasswordVC.swift
//  InLocalCustomer
//
//  Created by Sudipta Patel on 01/06/21.
//  Copyright © 2021 ___ORGANIZATIONNAME___. All rights reserved.
//
//

import UIKit

class ForgotPasswordVC: UIViewController {
    
    // MARK: Instance variables
	lazy var dataManager = ForgotPasswordDataManager()
    var dependency: ForgotPasswordDependency?
    
    @IBOutlet weak var lblForgotPassword: UILabel!
    @IBOutlet weak var lblRetrievePassword: UILabel!
    @IBOutlet weak var lblRetrieveMessage: UILabel!
    @IBOutlet weak var lblPhoneNumber: UILabel!
    
    @IBOutlet weak var txtFieldPhoneNumber: TextFieldView!
    @IBOutlet weak var btnContinue: UIButton!
    
    var forgotPasswordRequest = ForgotPasswordRequest()
    
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
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func onClickContinue(_ sender: Any) {
    }
    
    // MARK: Methods
    func setupUI() {
        txtFieldPhoneNumber.delegate = self
        txtFieldPhoneNumber.populateWithData(text: "", placeholderText: "Phone no", fieldType: .phone)
        txtFieldPhoneNumber.txtFldInput.returnKeyType = UIReturnKeyType.next
        
        validateFields()
    }
    
    func validateFields() {
        if forgotPasswordRequest.phone?.isNullString() ?? true{
            btnContinue.alpha = 0.5
            btnContinue.isUserInteractionEnabled = false
        } else{
            btnContinue.alpha = 1
            btnContinue.isUserInteractionEnabled = true
        }
    }
}

// MARK: - Load from storyboard with dependency
extension ForgotPasswordVC {
    
    class func load(withDependency dependency: ForgotPasswordDependency? = nil) -> ForgotPasswordVC? {
        
        let storyboard = UIStoryboard(name: "ForgotPassword", bundle: nil)
        
        guard let vc = storyboard.instantiateViewController(withIdentifier: "ForgotPasswordVC") as? ForgotPasswordVC else {
            return nil
        }
        vc.dependency = dependency
        return vc
    }
}

// MARK: - ForgotPasswordAPIResponseDelegate
extension ForgotPasswordVC: ForgotPasswordAPIResponseDelegate {
    
}

extension ForgotPasswordVC: TextFieldDelegate{
   func forgotPwdClicked() {
       
   }
   
    func textFieldViewDidChangeEditing(_ textFieldView: TextFieldView, string: String) {
        let strText = string
        let fieldType = textFieldView.fieldType!
        switch fieldType {
        case .phone:
            if strText.isNullString() {
                forgotPasswordRequest.phone = ""
                textFieldView.showError(with: "* Required")
            } else {
                forgotPasswordRequest.phone = strText
                textFieldView.hideError()
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
