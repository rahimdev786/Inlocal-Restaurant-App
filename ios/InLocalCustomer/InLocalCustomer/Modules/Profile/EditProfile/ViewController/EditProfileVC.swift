//
//  EditProfileVC.swift
//  InLocalCustomer
//
//  Created by Sajib Ghosh on 07/06/21.
//  Copyright © 2021 ___ORGANIZATIONNAME___. All rights reserved.
//
//

import UIKit
import Photos

class EditProfileVC: UIViewController, UINavigationControllerDelegate {
    // MARK: Instance variables
	lazy var dataManager = EditProfileDataManager()
    var dependency: EditProfileDependency?
    
    @IBOutlet weak var txtFieldName: TextFieldView!
    @IBOutlet weak var txtFieldEmail: TextFieldView!
    @IBOutlet weak var txtFieldPhoneNumber: TextFieldView!
    @IBOutlet weak var profilePicView: UIView!
    @IBOutlet weak var imgViewProfile: UIImageView!
    
    @IBOutlet weak var btnSave: UIButton!
    
    let imagePicker = UIImagePickerController()
    var isImageSelected = false
        
    @IBOutlet weak var lblTitle: UILabel!

    var updateProfileRequest = UpdateProfileRequest()
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
        txtFieldName.populateWithData(text: "", placeholderText: "Name", fieldType: .firstName)
        txtFieldName.txtFldInput.returnKeyType = UIReturnKeyType.next
        txtFieldName.txtFldInput.text = "John Doe"
        updateProfileRequest.userName = "John Doe"
        //txtFieldName.txtFldInput.backgroundColor = .clear
        //txtFieldName.contentView.backgroundColor = .clear
        
        //txtFieldEmail.layer.cornerRadius = txtFieldPhoneNumber.layer.bounds.height/2
        txtFieldEmail.layer.masksToBounds = true
        txtFieldEmail.delegate = self
        txtFieldEmail.populateWithData(text: "", placeholderText: "Email", fieldType: .email)
        txtFieldEmail.txtFldInput.returnKeyType = UIReturnKeyType.default
        txtFieldEmail.txtFldInput.text = "a@b.com"
        updateProfileRequest.email = "a@b.com"
        //txtFieldEmail.txtFldInput.backgroundColor = .clear
        //txtFieldEmail.contentView.backgroundColor = .clear
        
        
        //txtFieldPhoneNumber.layer.cornerRadius = txtFieldPhoneNumber.layer.bounds.height/2
        txtFieldPhoneNumber.layer.masksToBounds = true
        txtFieldEmail.delegate = self
        txtFieldPhoneNumber.populateWithData(text: "", placeholderText: "Phone No", fieldType: .phone)
        txtFieldPhoneNumber.txtFldInput.returnKeyType = UIReturnKeyType.default
        txtFieldPhoneNumber.txtFldInput.text = "1234567890"
        updateProfileRequest.phoneNumber = "1234567890"
        //txtFieldPhoneNumber.txtFldInput.backgroundColor = .clear
        //txtFieldPhoneNumber.contentView.backgroundColor = .clear
        
    }
    
    func validateFields() {
        if updateProfileRequest.userName?.isNullString() ?? true || updateProfileRequest.email?.isNullString() ?? true || updateProfileRequest.phoneNumber?.isNullString() ?? true{
            btnSave.alpha = 0.5
            btnSave.isUserInteractionEnabled = false
        } else{
            btnSave.alpha = 1
            btnSave.isUserInteractionEnabled = true
        }
    }
    
    @IBAction func didTapOnBack(_ sender: UIButton) {
        navigationController?.popViewController(animated: true)
    }

    func showActionSheet() {
        if UIImagePickerController.isSourceTypeAvailable(.camera) {
            let alertCntlr = UIAlertController.init(title: "Please select", message: nil, preferredStyle: .actionSheet)
            let cancelAction = UIAlertAction.init(title: "Cancel", style: .cancel) { _ in
            }
            let cameraAction = UIAlertAction.init(title: "Camera", style: .default) { _ in
                self.checkCameraAccess()
            }
            let galleryAction = UIAlertAction.init(title: "Photo Library", style: .default) { _ in
                self.checkPhotoLibraryPermission()
            }
            alertCntlr.addAction(cancelAction)
            alertCntlr.addAction(galleryAction)
            alertCntlr.addAction(cameraAction)
            self.present(alertCntlr, animated: true, completion: nil)
        } else {
            self.checkPhotoLibraryPermission()
        }
    }
    
    func checkCameraAccess() {
        switch AVCaptureDevice.authorizationStatus(for: .video) {
        case .denied:
            ()
        case .restricted:
            ()
        case .authorized:
            DispatchQueue.main.async {
                self.openImagePicker(isCamera: true)
            }
        case .notDetermined:
            AVCaptureDevice.requestAccess(for: .video) { success in
                DispatchQueue.main.async {
                    if success {
                        self.openImagePicker(isCamera: true)
                    } else {
                    }
                }
            }
        default:
            ()
        }
    }
    
    func checkPhotoLibraryPermission() {
        let status = PHPhotoLibrary.authorizationStatus()
        switch status {
        case .authorized:
            DispatchQueue.main.async {
                self.openImagePicker(isCamera: false)
            }
        case .denied, .restricted :
            ()
        case .notDetermined:
            // ask for permissions
            PHPhotoLibrary.requestAuthorization { (status) in
                DispatchQueue.main.async {
                    switch status {
                    case .authorized:
                        self.openImagePicker(isCamera: false)
                    case .denied, .restricted:
                        ()
                    case .notDetermined:
                        ()
                    default:
                        ()
                    }
                }
            }
        default:
            ()
        }
    }
    
    func openImagePicker(isCamera: Bool) {
        self.imagePicker.delegate = self
        if isCamera {
            self.imagePicker.allowsEditing = true
            self.imagePicker.sourceType = .camera
            self.present(self.imagePicker, animated: true, completion: nil)
        } else {
            self.imagePicker.allowsEditing = true
            self.imagePicker.sourceType = .photoLibrary
            self.present(self.imagePicker, animated: true, completion: nil)
        }
    }
    
    // MARK: IBActions
    @IBAction func addProfPicClicked(_ sender: UIButton) {
        showActionSheet()
    }
    
    @IBAction func didTapOnCamera(_ sender: Any) {
        showActionSheet()
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
        let strText = string
        let fieldType = textFieldView.fieldType!
        switch fieldType {
        case .firstName:
             
            if strText.isNullString() {
                updateProfileRequest.userName = ""
                textFieldView.showError(with: "* Required")
            } else{
                updateProfileRequest.userName = strText
                textFieldView.hideError()
            }
            
        case .email:
            if strText.isNullString() {
                updateProfileRequest.email = ""
                textFieldView.showError(with: "* Required")
                
            } else if Validator.isValid(itemToValidate: strText , validationType: .email){
                updateProfileRequest.email = strText
                textFieldView.hideError()
            } else{
                updateProfileRequest.email = ""
                textFieldView.showError(with: "Enter a valid email")
            }
            
        case .phone:
            if strText.isNullString() {
                updateProfileRequest.phoneNumber = ""
                textFieldView.showError(with: "* Required")
            } else {
                updateProfileRequest.phoneNumber = strText
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
        
        if textFieldView == txtFieldPhoneNumber{
            txtFieldPhoneNumber.txtFldInput.becomeFirstResponder()
        } else{
            textFieldView.txtFldInput.resignFirstResponder()
        }
        return true
    }
    
}

// MARK: - UIImagePickerCintrollerDelegate
extension EditProfileVC: UIImagePickerControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey: Any]) {
        let img = info[UIImagePickerController.InfoKey.originalImage] as? UIImage
        
        isImageSelected = true
        imgViewProfile.image = img
        
        //        let fixedImg = img.fixOrientation()
        //        saveImageDocumentDirectory(with: fixedImg, name: "profile.png")
        //        imageChanged = true
        dismiss(animated: true, completion: nil)
    }
}
