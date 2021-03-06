//
//  SignupVC.swift
//  InLocalCustomer
//
//  Created by Sudipta Patel on 31/05/21.
//  Copyright © 2021 ___ORGANIZATIONNAME___. All rights reserved.
//
//

import UIKit
import CountryPickerView

class SignupVC: UIViewController {
    
    // MARK: Instance variables
	lazy var dataManager = SignupDataManager()
    var dependency: SignupDependency?
    
    @IBOutlet weak var lblFullName: UILabel!
    @IBOutlet weak var lblEmailAddress: UILabel!
    @IBOutlet weak var lblPhoneNo: UILabel!
    @IBOutlet weak var lblPassword: UILabel!
    
    @IBOutlet weak var txtFieldFullName: TextFieldView!
    @IBOutlet weak var txtFieldEmailAddress: TextFieldView!
    @IBOutlet weak var txtFieldPhoneNo: TextFieldView!
    @IBOutlet weak var txtFieldPassword: TextFieldView!
    
    @IBOutlet weak var lblSignup: UILabel!
    @IBOutlet weak var lblIAgreeTo: UILabel!
    @IBOutlet weak var lblAnd: UILabel!
    @IBOutlet weak var lblIHaveAnAccount: UILabel!
    
    @IBOutlet weak var btnTemsAndCondition: UIButton!
    @IBOutlet weak var btnPrivacyPolicy: UIButton!
    @IBOutlet weak var btnContinue: UIButton!
    @IBOutlet weak var btnSignIn: UIButton!
    
    var signUpRequest = SignUpRequest()
    
    let otpView = ValidateOTP.instanceFromNib()
    var isTermConditionAccepted = false
    var signupResponse : SignupResponse?
    
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
    
    @IBAction func onClickCheckBox(_ sender: UIButton) {
        if isTermConditionAccepted{
            isTermConditionAccepted = false
            sender.setImage(#imageLiteral(resourceName: "empty_checkbox_gray"), for: .normal)
        } else{
            isTermConditionAccepted = true
            sender.setImage(#imageLiteral(resourceName: "checked_checkbox"), for: .normal)
        }
    }
    
    @IBAction func onClickTermsAndServicess(_ sender: Any) {
    }
    
    @IBAction func onClickPrivacyPolicy(_ sender: Any) {
    }
    
    @IBAction func onClickContinue(_ sender: Any) {
        
        guard let fullname = signUpRequest.fullName, let email = signUpRequest.email, let phone = signUpRequest.phone, let countryCode = signUpRequest.countryCode, let password = signUpRequest.password else{
            return
        }
        AppActivityIndicator.showActivityIndicator(displayStyle: .dark, displayMessage: "Registering You", showInView: self.view)
        dataManager.signupUserCall(fullname: fullname, email: email, phone: phone, countryCode: countryCode, password: password)
        
    }
    
    @IBAction func onClickSignIn(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    func setupUI() {
      
        otpView.frame = UIScreen.main.bounds
        otpView.delegate = self
        otpView.viewBckGrnd.applyAllAroundShadow()
        otpView.viewBckGrnd.layer.cornerRadius = 10
        otpView.imgViewBckGrnd.backgroundColor = .black
        otpView.imgViewBckGrnd.alpha = 0.6
        
        txtFieldFullName.delegate = self
        txtFieldFullName.populateWithData(text: "", placeholderText: "Full Name", fieldType: .firstName)
        txtFieldFullName.txtFldInput.returnKeyType = UIReturnKeyType.next
        txtFieldFullName.txtFldInput.delegate = self
        txtFieldFullName.txtFldInput.tag = 0
        
        txtFieldEmailAddress.delegate = self
        txtFieldEmailAddress.populateWithData(text: "", placeholderText: "Email Address", fieldType: .email)
        txtFieldEmailAddress.txtFldInput.returnKeyType = UIReturnKeyType.next
        txtFieldEmailAddress.txtFldInput.delegate = self
        txtFieldEmailAddress.txtFldInput.tag = 1
        
        txtFieldPhoneNo.delegate = self
        txtFieldPhoneNo.populateWithData(text: "", placeholderText: "Phone Number", fieldType: .phone)
        txtFieldPhoneNo.txtFldInput.returnKeyType = UIReturnKeyType.next
        txtFieldPhoneNo.txtFldInput.delegate = self
        txtFieldPhoneNo.txtFldInput.tag = 2
        
        txtFieldPhoneNo.countryPickerView.delegate = self
        txtFieldPhoneNo.countryPickerView.dataSource = self
        
        txtFieldPhoneNo.countryPickerView.showCountryCodeInView = false
        txtFieldPhoneNo.countryPickerView.tag = 1
        
        txtFieldPassword.delegate = self
        txtFieldPassword.populateWithData(text: "", placeholderText: "Password", fieldType: .password)
        txtFieldPassword.txtFldInput.returnKeyType = UIReturnKeyType.default
        txtFieldPassword.txtFldInput.delegate = self
        txtFieldPassword.txtFldInput.tag = 3
        
        signUpRequest.countryCode = "IN"
        
        validateFields()
    }
    
    func validateFields() {
        if signUpRequest.fullName?.isNullString() ?? true || signUpRequest.email?.isNullString() ?? true || signUpRequest.phone?.isNullString() ?? true || signUpRequest.password?.isNullString() ?? true{
            btnContinue.alpha = 0.5
            btnContinue.isUserInteractionEnabled = false
        } else{
            btnContinue.alpha = 1
            btnContinue.isUserInteractionEnabled = true
        }
    }
}
extension SignupVC : CountryPickerViewDelegate {
  
   func countryPickerView(_ countryPickerView: CountryPickerView, didSelectCountry country: Country) {
       
    
        signUpRequest.countryCode = country.code
    
       
   }
   
}

extension SignupVC : CountryPickerViewDataSource {
   
   func showOnlyPreferredSection(in countryPickerView: CountryPickerView) -> Bool {
       return countryPickerView.tag == txtFieldPhoneNo.countryPickerView.tag
   }
   
   func sectionTitleForPreferredCountries(in countryPickerView: CountryPickerView) -> String? {
       if countryPickerView.tag == txtFieldPhoneNo.countryPickerView.tag {
           return "Preferred title"
       }
       return nil
   }
   
   func navigationTitle(in countryPickerView: CountryPickerView) -> String? {
       return "Select a Country"
   }
   
   func searchBarPosition(in countryPickerView: CountryPickerView) -> SearchBarPosition {
       if countryPickerView.tag == txtFieldPhoneNo.countryPickerView.tag {
//            switch searchBarPosition.selectedSegmentIndex
       }
       return .tableViewHeader
   }
   
}// MARK: - Load from storyboard with dependency
extension SignupVC {
    
    class func load(withDependency dependency: SignupDependency? = nil) -> SignupVC? {
        
        let storyboard = UIStoryboard(name: "Signup", bundle: nil)
        
        guard let vc = storyboard.instantiateViewController(withIdentifier: "SignupVC") as? SignupVC else {
            return nil
        }
        vc.dependency = dependency
        return vc
    }
}

// MARK: - SignupAPIResponseDelegate
extension SignupVC: SignupAPIResponseDelegate {
    func verifyOTPSuccess(withData: LoginResponseModel) {
        AppActivityIndicator.hideActivityIndicator()
        let appdelegate = UIApplication.shared.delegate as! AppDelegate
        appdelegate.moveToTabBarVC()
    }
    
    func signupSuccess(withData: SignupResponse) {
        AppActivityIndicator.hideActivityIndicator()
        signupResponse = withData
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

extension SignupVC : ValidateOTPDelegate{
    
    func onClickContinue() {
        guard let id = signupResponse?.id, let otp = signupResponse?.otp else{
            return
        }
        
        AppActivityIndicator.showActivityIndicator(displayStyle: .dark, displayMessage: "Verifying OTP", showInView: self.view)
        dataManager.verifyOTP(id: id, otp: String(otp))
    }
}

extension SignupVC: TextFieldDelegate{
   func forgotPwdClicked() {
       
   }
   
    func textFieldViewDidChangeEditing(_ textFieldView: TextFieldView, string: String) {
        let strText = string
        let fieldType = textFieldView.fieldType!
        switch fieldType {
        case .firstName:
            signUpRequest.fullName = strText
            if strText.isNullString() {
                textFieldView.showError(with: "* Required")
            
            } else if Validator.isValid(itemToValidate: strText , validationType: .name){
                textFieldView.hideError()
            } else{
                textFieldView.showError(with: "Enter valid fullname")
            }
            
        case .phone:
            if strText.isNullString() {
                signUpRequest.phone = ""
                textFieldView.showError(with: "* Required")
            } else if strText.count > 9{
                signUpRequest.phone = strText
                textFieldView.hideError()
            } else {
                signUpRequest.phone = ""
                textFieldView.showError(with: "Enter valid phone number.")
            }
            
        case .email:
            if strText.isNullString() {
                signUpRequest.email = ""
                textFieldView.showError(with: "* Required")
                
            } else if Validator.isValid(itemToValidate: strText , validationType: .email){
                signUpRequest.email = strText
                textFieldView.hideError()
            } else{
                signUpRequest.email = ""
                textFieldView.showError(with: "Enter a valid email")
            }
            
        case .password:
            if strText.isNullString() {
                signUpRequest.password = ""
                textFieldView.showError(with: "* Required")
            } else if Validator.isValid(itemToValidate: strText , validationType: .password){
                signUpRequest.password = strText
                textFieldView.hideError()
            } else{
                signUpRequest.password = ""
                textFieldView.showError(with: "Password must be 8 characters, must contain at least 1 special character, must contaibn at least 1 number & 1 uppercase character")
            }

        default:
            break
        }
        
        validateFields()
    }
    
    func textFiedViewDidEndEditing(_ textFieldView: TextFieldView) {
        
    }
    
    func textFieldViewShouldReturn(_ textFieldView: TextFieldView) -> Bool {
       
//             if textFieldView == txtFieldPhoneNumber{
//                txtFieldPhoneNumber.txtFldInput.becomeFirstResponder()
//             } else{
//                 textFieldView.txtFldInput.resignFirstResponder()
//             }
        return true
    }
    
}


extension SignupVC: UITextFieldDelegate{
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        if  txtFieldFullName.txtFldInput.tag == textField.tag {
            txtFieldEmailAddress.txtFldInput.becomeFirstResponder()
        } else if txtFieldEmailAddress.txtFldInput.tag == textField.tag {
            txtFieldPhoneNo.txtFldInput.becomeFirstResponder()
        }else{
            textField.resignFirstResponder()
        }
        
        return true
        
    }
}
