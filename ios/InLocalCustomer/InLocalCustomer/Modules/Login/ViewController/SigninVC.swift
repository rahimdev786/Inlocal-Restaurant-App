 //
//  SigninVC.swift
//  InLocalCustomer
//
//  Created by Sudipta Patel on 31/05/21.
//  Copyright © 2021 ___ORGANIZATIONNAME___. All rights reserved.
//
//

import UIKit

class SigninVC: UIViewController {
    
    // MARK: Instance variables
	lazy var dataManager = SigninDataManager()
    var dependency: SigninDependency?
    
    @IBOutlet weak var lblLogin: UILabel!
    @IBOutlet weak var lblPhoneNumber: UILabel!
    @IBOutlet weak var lblPassword: UILabel!
    @IBOutlet weak var lblDontHaveAnAccount: UILabel!
    
    @IBOutlet weak var txtFieldPhoneNumber: TextFieldView!
    @IBOutlet weak var txtFieldPassword: TextFieldView!
    
    @IBOutlet weak var btnForgotPassword: UIButton!
    @IBOutlet weak var btnLogin: UIButton!
    @IBOutlet weak var btnRegister: UIButton!
    
    var userLoginData = LoginDetails()
    
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
    
    @IBAction func onClickForgotPassword(_ sender: Any) {
        moveToForgotPassword()
    }
    
    @IBAction func onClickLogin(_ sender: Any) {
        let appdelegate = UIApplication.shared.delegate as! AppDelegate
        appdelegate.moveToTabBarVC()
        
        guard let phone = userLoginData.phone,let password = userLoginData.password else{
            return
        }
        AppActivityIndicator.showActivityIndicator(displayStyle: .dark, displayMessage: "LogginYouIn", showInView: self.view)
        dataManager.loginUserCall(phone: phone, password: password)
    }
    
    @IBAction func onClickRegister(_ sender: Any) {
        moveToRegistration()
    }
      
    // MARK: Methods
    func setupUI() {
      
        txtFieldPhoneNumber.delegate = self
        txtFieldPhoneNumber.populateWithData(text: "", placeholderText: "Phone no", fieldType: .phone)
        txtFieldPhoneNumber.txtFldInput.returnKeyType = UIReturnKeyType.next
        
        txtFieldPassword.delegate = self
        txtFieldPassword.populateWithData(text: "", placeholderText: "Password", fieldType: .password)
        txtFieldPassword.txtFldInput.returnKeyType = UIReturnKeyType.default
        
        validateFields()
    }
    
    func validateFields() {
        if userLoginData.phone?.isNullString() ?? true || userLoginData.password?.isNullString() ?? true{
            btnLogin.alpha = 0.5
            btnLogin.isUserInteractionEnabled = false
        } else{
           btnLogin.alpha = 1
           btnLogin.isUserInteractionEnabled = true
        }
    }
}

// MARK: - Load from storyboard with dependency
extension SigninVC {
    
    class func load(withDependency dependency: SigninDependency? = nil) -> SigninVC? {
        
        let storyboard = UIStoryboard(name: "Signin", bundle: nil)
        
        guard let vc = storyboard.instantiateViewController(withIdentifier: "SigninVC") as? SigninVC else {
            return nil
        }
        vc.dependency = dependency
        return vc
    }
}

// MARK: - SigninAPIResponseDelegate
extension SigninVC: SigninAPIResponseDelegate {
    func loginSuccess(withData: LoginResponseModel) {
        AppActivityIndicator.hideActivityIndicator()
        
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

 extension SigninVC: TextFieldDelegate{
    func forgotPwdClicked() {
        
    }
    
    func textFieldViewDidChangeEditing(_ textFieldView: TextFieldView, string: String) {
        let strText = string
        let fieldType = textFieldView.fieldType!
        switch fieldType {
        case .phone:
            if strText.isNullString() {
                userLoginData.phone = ""
                textFieldView.showError(with: "* Required")
            } else if strText.count > 9{
                userLoginData.phone = strText
                textFieldView.hideError()
            } else {
                userLoginData.phone = ""
                textFieldView.showError(with: "Enter valid phone number.")
            }
            
        case .password:
            if strText.isNullString() {
                userLoginData.password = ""
                textFieldView.showError(with: "* Required")
            } else if Validator.isValid(itemToValidate: strText , validationType: .password){
                userLoginData.password = strText
                textFieldView.hideError()
            } else{
                userLoginData.password = ""
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
        
             if textFieldView == txtFieldPhoneNumber{
                txtFieldPhoneNumber.txtFldInput.becomeFirstResponder()
             } else{
                 textFieldView.txtFldInput.resignFirstResponder()
             }
         return true
     }
     
 }

 extension SigninVC{
    
    func moveToRegistration() {
        
        guard let signupViewController = SignupVC.load(withDependency: nil) else {
            return
        }
        self.present(signupViewController, animated: true, completion: nil)
    }
    
    func moveToForgotPassword() {
        
        guard let forgotPasswordViewController = ForgotPasswordVC.load(withDependency: nil) else {
            return
        }
        self.navigationController?.pushViewController(forgotPasswordViewController, animated: true)
    }
    
 }
