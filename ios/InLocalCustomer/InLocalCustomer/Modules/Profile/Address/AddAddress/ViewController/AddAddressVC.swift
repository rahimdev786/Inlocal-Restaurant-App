//
//  AddAddressVC.swift
//  InLocalCustomer
//
//  Created by Sudipta Patel on 14/06/21.
//  Copyright © 2021 ___ORGANIZATIONNAME___. All rights reserved.
//
//

import UIKit
import CountryList
import Toast_Swift
class AddAddressVC: UIViewController {
    
    // MARK: Instance variables
	lazy var dataManager = AddAddressDataManager()
    var dependency: AddAddressDependency?
    
    @IBOutlet weak var txtFieldHouseNo: TextFieldView!
    @IBOutlet weak var txtFiledLandmark: TextFieldView!
    @IBOutlet weak var txtFiledZipCode: TextFieldView!
    @IBOutlet weak var txtFieldCity: TextFieldView!
    
    //@IBOutlet weak var viewBackCountry: TextFieldView!
    @IBOutlet weak var btnSave: UIButton!
    @IBOutlet weak var imgViewCountry: UIImageView!
    @IBOutlet weak var lblCountry: UILabel!
    
    var countryList = CountryList()
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
    
    @IBAction func onClickSelectCountry(_ sender: Any) {
        let vc = UINavigationController(rootViewController: countryList)
        self.present(vc, animated: true, completion: nil)
    }
    
    @IBAction func onClickSave(_ sender: Any) {
        self.view.makeToast("Address added.")
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            self.navigationController?.popViewController(animated: true)
        }
    }
    
    func setupUI() {
      
        txtFieldHouseNo.delegate = self
        txtFieldHouseNo.txtFldInput.delegate = self
        txtFieldHouseNo.populateWithData(text: "", placeholderText: "House no, street name", fieldType: .houseNo)
        txtFieldHouseNo.txtFldInput.returnKeyType = UIReturnKeyType.next
        txtFieldHouseNo.txtFldInput.tag = 0
        
        txtFiledLandmark.delegate = self
        txtFiledLandmark.txtFldInput.delegate = self
        txtFiledLandmark.populateWithData(text: "", placeholderText: "Landmark", fieldType: .landmark)
        txtFiledLandmark.txtFldInput.returnKeyType = UIReturnKeyType.next
        txtFiledLandmark.txtFldInput.tag = 1
        
        txtFiledZipCode.delegate = self
        txtFiledZipCode.txtFldInput.delegate = self
        txtFiledZipCode.populateWithData(text: "", placeholderText:"Zip Code", fieldType: .zipcode)
        txtFiledZipCode.txtFldInput.returnKeyType = UIReturnKeyType.next
        txtFiledZipCode.txtFldInput.tag = 2
        
        txtFieldCity.delegate = self
        txtFieldCity.txtFldInput.delegate = self
        txtFieldCity.populateWithData(text: "", placeholderText: "City", fieldType: .city)
        txtFieldCity.txtFldInput.returnKeyType = UIReturnKeyType.default
        txtFieldCity.txtFldInput.tag = 3
        
        countryList.delegate = self
        
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
        case .houseNo:
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
            } else if !validZipCode(postalCode: strText){
                addAddressRequest.zipCode = ""
                textFieldView.showError(with: "Enter valid zip code.")
            } else{
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
    
    func validZipCode(postalCode:String)->Bool{
            let postalcodeRegex = "^[0-9]{6}(-[0-9]{4})?$"
            let pinPredicate = NSPredicate(format: "SELF MATCHES %@", postalcodeRegex)
            let bool = pinPredicate.evaluate(with: postalCode) as Bool
            return bool
    }
}

extension AddAddressVC: UITextFieldDelegate {
   
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        if textField.tag == txtFieldHouseNo.txtFldInput.tag{
            txtFiledLandmark.txtFldInput.becomeFirstResponder()
        } else if textField.tag == txtFiledLandmark.txtFldInput.tag{
            txtFiledZipCode.txtFldInput.becomeFirstResponder()
        } else if textField.tag == txtFiledZipCode.txtFldInput.tag{
            txtFieldCity.txtFldInput.becomeFirstResponder()
        } else{
            textField.resignFirstResponder()
        }
        return true
        
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if textField.tag == txtFiledZipCode.txtFldInput.tag{
            guard let text = textField.text else { return true }
            let newLength = text.count + string.count - range.length
            return newLength <= 6
        }
        
        return true
    }
}

extension AddAddressVC: CountryListDelegate {
    func selectedCountry(country: Country) {
        lblCountry.text = "\(country.flag!) \(country.name!)"
        addAddressRequest.country = country.name!
        validateFields()
    }
}
