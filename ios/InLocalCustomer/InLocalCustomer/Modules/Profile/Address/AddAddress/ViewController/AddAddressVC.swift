//
//  AddAddressVC.swift
//  InLocalCustomer
//
//  Created by Sudipta Patel on 14/06/21.
//  Copyright © 2021 ___ORGANIZATIONNAME___. All rights reserved.
//
//

import UIKit

class AddAddressVC: UIViewController {
    
    // MARK: Instance variables
	lazy var dataManager = AddAddressDataManager()
    var dependency: AddAddressDependency?
    
    @IBOutlet weak var txtFieldHouseNo: TextFieldView!
    @IBOutlet weak var txtFiledLandmark: TextFieldView!
    @IBOutlet weak var txtFiledZipCode: TextFieldView!
    @IBOutlet weak var txtFieldCity: TextFieldView!
    @IBOutlet weak var txtFieldCountry: TextFieldView!
    
    @IBOutlet weak var btnSave: UIButton!
    
    var addAddressRequest = AddAddressRequest()
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
    
    func setupUI() {
      
        txtFieldHouseNo.delegate = self
        txtFieldHouseNo.populateWithData(text: "", placeholderText: "House no, street name", fieldType: .address)
        txtFieldHouseNo.txtFldInput.returnKeyType = UIReturnKeyType.next
        
        txtFiledLandmark.delegate = self
        txtFiledLandmark.populateWithData(text: "", placeholderText: "Landmark", fieldType: .landmark)
        txtFiledLandmark.txtFldInput.returnKeyType = UIReturnKeyType.default
        
        txtFiledZipCode.delegate = self
        txtFiledZipCode.populateWithData(text: "", placeholderText:"Zip Code", fieldType: .zipcode)
        txtFiledZipCode.txtFldInput.returnKeyType = UIReturnKeyType.next
        
        txtFieldCity.delegate = self
        txtFieldCity.populateWithData(text: "", placeholderText: "City", fieldType: .city)
        txtFieldCity.txtFldInput.returnKeyType = UIReturnKeyType.default
        
        txtFieldCountry.delegate = self
        txtFieldCountry.populateWithData(text: "", placeholderText: "Country", fieldType: .country)
        txtFieldCountry.txtFldInput.returnKeyType = UIReturnKeyType.default
        
        validateFields()
    }
    
    func validateFields() {
        if addAddressRequest.flatNo?.isNullString() ?? true || addAddressRequest.landmark?.isNullString() ?? true || addAddressRequest.zipCode?.isNullString() ?? true || addAddressRequest.city?.isNullString() ?? true || addAddressRequest.country?.isNullString() ?? true{
            btnSave.alpha = 0.5
            btnSave.isUserInteractionEnabled = false
        } else{
            btnSave.alpha = 1
            btnSave.isUserInteractionEnabled = true
        }
    }
}

// MARK: - Load from storyboard with dependency
extension AddAddressVC {
    
    class func load(withDependency dependency: AddAddressDependency? = nil) -> AddAddressVC? {
        
        let storyboard = UIStoryboard(name: "AddAddress", bundle: nil)
        
        guard let vc = storyboard.instantiateViewController(withIdentifier: "AddAddressVC") as? AddAddressVC else {
            return nil
        }
        vc.dependency = dependency
        return vc
    }
}

// MARK: - AddAddressAPIResponseDelegate
extension AddAddressVC: AddAddressAPIResponseDelegate {
    
}

extension AddAddressVC: TextFieldDelegate{
   func forgotPwdClicked() {
       
   }
   
    func textFieldViewDidChangeEditing(_ textFieldView: TextFieldView, string: String) {
        
        let strText = string
        let fieldType = textFieldView.fieldType!
        switch fieldType {
        case .address:
            if strText.isNullString() {
                addAddressRequest.flatNo = ""
                textFieldView.showError(with: "* Required")
            } else {
                addAddressRequest.flatNo = strText
                textFieldView.hideError()
            }
        
        case .landmark:
            if strText.isNullString() {
                addAddressRequest.landmark = ""
                textFieldView.showError(with: "* Required")
            } else {
                addAddressRequest.landmark = strText
                textFieldView.hideError()
            }
        
        case .zipcode:
            if strText.isNullString() {
                addAddressRequest.zipCode = ""
                textFieldView.showError(with: "* Required")
            } else {
                addAddressRequest.zipCode = strText
                textFieldView.hideError()
            }
         
        case .city:
            if strText.isNullString() {
                addAddressRequest.city = ""
                textFieldView.showError(with: "* Required")
            } else {
                addAddressRequest.city = strText
                textFieldView.hideError()
            }
            
        case .country:
            if strText.isNullString() {
                addAddressRequest.country = ""
                textFieldView.showError(with: "* Required")
            } else {
                addAddressRequest.country = strText
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
