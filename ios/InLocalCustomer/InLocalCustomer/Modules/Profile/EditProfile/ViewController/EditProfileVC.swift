//
//  EditProfileVC.swift
//  InLocalCustomer
//
//  Created by Sajib Ghosh on 07/06/21.
//  Copyright © 2021 ___ORGANIZATIONNAME___. All rights reserved.
//
//

import UIKit

class EditProfileVC: UIViewController {
    // MARK: Instance variables
	lazy var dataManager = EditProfileDataManager()
    var dependency: EditProfileDependency?
    
    @IBOutlet weak var txtFieldName: TextFieldView!
    @IBOutlet weak var txtFieldEmail: TextFieldView!
    @IBOutlet weak var txtFieldPhoneNumber: TextFieldView!
    
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
    
    // MARK: Methods
    func setupUI() {
      
        //txtFieldName.layer.cornerRadius = txtFieldPhoneNumber.layer.bounds.height/2
        txtFieldName.layer.masksToBounds = true
        txtFieldName.delegate = self
        txtFieldName.populateWithData(text: "", placeholderText: "Name", fieldType: .phone)
        txtFieldName.txtFldInput.returnKeyType = UIReturnKeyType.next
        txtFieldName.txtFldInput.text = "John Doe"
        txtFieldName.txtFldInput.backgroundColor = .clear
        txtFieldName.contentView.backgroundColor = .clear
        
        //txtFieldEmail.layer.cornerRadius = txtFieldPhoneNumber.layer.bounds.height/2
        txtFieldEmail.layer.masksToBounds = true
        txtFieldEmail.delegate = self
        txtFieldEmail.populateWithData(text: "", placeholderText: "Email", fieldType: .email)
        txtFieldEmail.txtFldInput.returnKeyType = UIReturnKeyType.default
        txtFieldEmail.txtFldInput.text = "a@b.com"
        txtFieldEmail.txtFldInput.backgroundColor = .clear
        
        //txtFieldPhoneNumber.layer.cornerRadius = txtFieldPhoneNumber.layer.bounds.height/2
        txtFieldPhoneNumber.layer.masksToBounds = true
        txtFieldEmail.delegate = self
        txtFieldPhoneNumber.populateWithData(text: "", placeholderText: "Phone No", fieldType: .phone)
        txtFieldPhoneNumber.txtFldInput.returnKeyType = UIReturnKeyType.default
        txtFieldPhoneNumber.txtFldInput.text = "+91 1234567890"
        txtFieldPhoneNumber.txtFldInput.backgroundColor = .clear
        
    }
    
    @IBAction func didTapOnBack(_ sender: UIButton) {
        navigationController?.popViewController(animated: true)
    }
    
}

// MARK: - Load from storyboard with dependency
extension EditProfileVC {
    class func loadFromXIB(withDependency dependency: EditProfileDependency? = nil) -> EditProfileVC? {
        let storyboard = UIStoryboard(name: "EditProfile", bundle: nil)
        guard let viewController = storyboard.instantiateViewController(withIdentifier: "EditProfileVC") as? EditProfileVC else {
            return nil
        }
        viewController.dependency = dependency
        return viewController
    }
}

// MARK: - EditProfileAPIResponseDelegate
extension EditProfileVC: EditProfileAPIResponseDelegate {
}

extension EditProfileVC: TextFieldDelegate{
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
