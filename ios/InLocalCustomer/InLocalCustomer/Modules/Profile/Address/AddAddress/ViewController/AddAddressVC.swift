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
      
        txtFieldHouseNo.layer.cornerRadius = txtFieldHouseNo.layer.bounds.height/2
        txtFieldHouseNo.layer.masksToBounds = true
        txtFieldHouseNo.delegate = self
        txtFieldHouseNo.populateWithData(text: "", placeholderText: "House no, street name", fieldType: .address)
        txtFieldHouseNo.txtFldInput.returnKeyType = UIReturnKeyType.next
        
        txtFiledLandmark.layer.cornerRadius = txtFiledLandmark.layer.bounds.height/2
        txtFiledLandmark.layer.masksToBounds = true
        txtFiledLandmark.delegate = self
        txtFiledLandmark.populateWithData(text: "", placeholderText: "Landmark", fieldType: .landmark)
        txtFiledLandmark.txtFldInput.returnKeyType = UIReturnKeyType.default
        
        txtFiledZipCode.layer.cornerRadius = txtFiledZipCode.layer.bounds.height/2
        txtFiledZipCode.layer.masksToBounds = true
        txtFiledZipCode.delegate = self
        txtFiledZipCode.populateWithData(text: "", placeholderText:"Zip Code", fieldType: .zipcode)
        txtFiledZipCode.txtFldInput.returnKeyType = UIReturnKeyType.next
        
        txtFieldCity.layer.cornerRadius = txtFieldCity.layer.bounds.height/2
        txtFieldCity.layer.masksToBounds = true
        txtFieldCity.delegate = self
        txtFieldCity.populateWithData(text: "", placeholderText: "City", fieldType: .city)
        txtFieldCity.txtFldInput.returnKeyType = UIReturnKeyType.default
        
        txtFieldCountry.layer.cornerRadius = txtFieldCountry.layer.bounds.height/2
        txtFieldCountry.layer.masksToBounds = true
        txtFieldCountry.delegate = self
        txtFieldCountry.populateWithData(text: "", placeholderText: "Country", fieldType: .country)
        txtFieldCountry.txtFldInput.returnKeyType = UIReturnKeyType.default
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
       
   }
   
    func textFiedViewDidEndEditing(_ textFieldView: TextFieldView) {
        
    }
    
    func textFieldViewShouldReturn(_ textFieldView: TextFieldView) -> Bool {
       
        return true
    }
    
}
