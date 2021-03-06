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
    let otpView = ValidateOTP.instanceFromNib()
    var forgotPasswordResponse: ForgotPasswordResponse?
    
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
    
    @IBAction func onClickContinue(_ sender: Any) {
    
        guard let phone = forgotPasswordRequest.phone, let countryCode = forgotPasswordRequest.countryCode else{
            return
        }
        AppActivityIndicator.showActivityIndicator(displayStyle: .dark, displayMessage: "Verifying Phone", showInView: self.view)
        dataManager.forgotPasswordCall(countryCode: countryCode, phone: phone)
        
    }
    
    // MARK: Methods
    func setupUI() {
        otpView.frame = UIScreen.main.bounds
        otpView.delegate = self
        otpView.viewBckGrnd.applyAllAroundShadow()
        otpView.viewBckGrnd.layer.cornerRadius = 10
        otpView.imgViewBckGrnd.backgroundColor = .black
        otpView.imgViewBckGrnd.alpha = 0.6
        
        txtFieldPhoneNumber.delegate = self
        txtFieldPhoneNumber.populateWithData(text: "", placeholderText: "Phone no", fieldType: .phone)
        txtFieldPhoneNumber.txtFldInput.returnKeyType = UIReturnKeyType.next
        
        forgotPasswordRequest.countryCode = "IN"
       
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
    func forgotPasswordVerifyOTPSuccess(withData: EmptyResponse?) {
        guard let forgotPasswordViewController = SetNewPasswordVC.load(withDependency: .init(userId: forgotPasswordResponse?.id)) else {
            return
        }
        self.navigationController?.pushViewController(forgotPasswordViewController, animated: true)
    }
    
    func forgotPasswordSuccess(withData: ForgotPasswordResponse) {
        AppActivityIndicator.hideActivityIndicator()
        forgotPasswordResponse = withData
        self.view.addSubview(otpView)
    }
    
    func apiError(_ error: APIError) {
        AppActivityIndicator.hideActivityIndicator()
        self.view.makeToast("\(error.errorDescription ?? "")")
    }
    
    func networkError(_ error: Error) {
        AppActivityIndicator.hideActivityIndicator()
        if let error = error.asAFError?.underlyingError as NSError? {
            if error.code == APIError.noInternet.rawValue {
               self.view.makeToast("NoInternet".localiz())
            } else if error.code == -1001 {
                self.view.makeToast("TimeOut".localiz())
            } else {
                self.view.makeToast(error.localizedDescription)
            }
        } else {
            self.view.makeToast(error.localizedDescription)
        }

    }
    
}

extension ForgotPasswordVC : ValidateOTPDelegate{
    func onClickContinue() {
        
        guard let id = forgotPasswordResponse?.id, let otp = forgotPasswordResponse?.otp else{
            return
        }
        AppActivityIndicator.showActivityIndicator(displayStyle: .dark, displayMessage: "Verifying OTP", showInView: self.view)
        dataManager.changePasswordVerifyOTPCall(id: id, otp: String(otp))
        
    }
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
            } else if strText.count > 9{
                forgotPasswordRequest.phone = strText
                textFieldView.hideError()
            } else {
                forgotPasswordRequest.phone = ""
                textFieldView.showError(with: "Enter valid phone number.")
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
