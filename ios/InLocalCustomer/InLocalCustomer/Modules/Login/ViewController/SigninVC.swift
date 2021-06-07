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
        
        
        
    }
    
    @IBAction func onClickRegister(_ sender: Any) {
        moveToRegistration()
    }
    
    
    // MARK: Methods
    func setupUI() {
      
        txtFieldPhoneNumber.layer.cornerRadius = txtFieldPhoneNumber.layer.bounds.height/2
        txtFieldPhoneNumber.layer.masksToBounds = true
        txtFieldPhoneNumber.delegate = self
        txtFieldPhoneNumber.populateWithData(text: "", placeholderText: "Phone no", fieldType: .phone)
        txtFieldPhoneNumber.txtFldInput.returnKeyType = UIReturnKeyType.next
        
        txtFieldPassword.layer.cornerRadius = txtFieldPhoneNumber.layer.bounds.height/2
        txtFieldPassword.layer.masksToBounds = true
        txtFieldPassword.delegate = self
        txtFieldPassword.populateWithData(text: "", placeholderText: "Password", fieldType: .password)
        txtFieldPassword.txtFldInput.returnKeyType = UIReturnKeyType.default
        
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
    
}

 extension SigninVC: TextFieldDelegate{
    func forgotPwdClicked() {
        
    }
    
    func textFieldViewDidChangeEditing(_ textFieldView: TextFieldView, string: String) {
        
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
        self.present(forgotPasswordViewController, animated: true, completion: nil)
    }
    
 }
