//
//  SignupVC.swift
//  InLocalCustomer
//
//  Created by Sudipta Patel on 31/05/21.
//  Copyright © 2021 ___ORGANIZATIONNAME___. All rights reserved.
//
//

import UIKit

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
    
    let otpView = ValidateOTP.instanceFromNib()
    var isTermConditionAccepted = false
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
        self.view.addSubview(otpView)
    }
    
    @IBAction func onClickSignIn(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    func setupUI() {
      
        otpView.frame = UIScreen.main.bounds
        //otpView.delegate = self
        otpView.viewBckGrnd.applyAllAroundShadow()
        otpView.viewBckGrnd.layer.cornerRadius = 10
        otpView.imgViewBckGrnd.backgroundColor = .black
        otpView.imgViewBckGrnd.alpha = 0.6
        
        txtFieldFullName.layer.cornerRadius = txtFieldFullName.layer.bounds.height/2
        txtFieldFullName.layer.masksToBounds = true
        txtFieldFullName.delegate = self
        txtFieldFullName.populateWithData(text: "", placeholderText: "Full Name", fieldType: .firstName)
        txtFieldFullName.txtFldInput.returnKeyType = UIReturnKeyType.next
        
        txtFieldEmailAddress.layer.cornerRadius = txtFieldEmailAddress.layer.bounds.height/2
        txtFieldEmailAddress.layer.masksToBounds = true
        txtFieldEmailAddress.delegate = self
        txtFieldEmailAddress.populateWithData(text: "", placeholderText: "Email Address", fieldType: .email)
        txtFieldEmailAddress.txtFldInput.returnKeyType = UIReturnKeyType.default
        
        txtFieldPhoneNo.layer.cornerRadius = txtFieldPhoneNo.layer.bounds.height/2
        txtFieldPhoneNo.layer.masksToBounds = true
        txtFieldPhoneNo.delegate = self
        txtFieldPhoneNo.populateWithData(text: "", placeholderText: "Phone Number", fieldType: .phone)
        txtFieldPhoneNo.txtFldInput.returnKeyType = UIReturnKeyType.next
        
        txtFieldPassword.layer.cornerRadius = txtFieldPassword.layer.bounds.height/2
        txtFieldPassword.layer.masksToBounds = true
        txtFieldPassword.delegate = self
        txtFieldPassword.populateWithData(text: "", placeholderText: "Password", fieldType: .password)
        txtFieldPassword.txtFldInput.returnKeyType = UIReturnKeyType.default
    }
}

// MARK: - Load from storyboard with dependency
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
    
}

extension SignupVC: TextFieldDelegate{
   func forgotPwdClicked() {
       
   }
   
   func textFieldViewDidChangeEditing(_ textFieldView: TextFieldView, string: String) {
       
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


