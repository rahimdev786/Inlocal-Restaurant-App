//
//  UploadStoryVC.swift
//  InLocalCustomer
//
//  Created by Sajib Ghosh on 12/06/21.
//  Copyright © 2021 ___ORGANIZATIONNAME___. All rights reserved.
//
//

import UIKit
import Photos

class UploadStoryVC: UIViewController, UINavigationControllerDelegate {
    // MARK: Instance variables
	lazy var dataManager = UploadStoryDataManager()
    var dependency: UploadStoryDependency!
    
    let imagePicker = UIImagePickerController()
    var isImageSelected = false
    
    // MARK: - View Life Cycle Methods
    
    var isTaggedRestaurant = false {
        didSet{
            setupUI()
        }
    }
    
    @IBOutlet weak var tagRestaurantView: UIView!
    @IBOutlet weak var restaurantView: UIView!
    @IBOutlet weak var lblName: UILabel!
    @IBOutlet weak var lblRestaurantName: UILabel!
    @IBOutlet weak var imgRestaurant: UIImageView!
    @IBOutlet weak var imgUpload: UIImageView!
    
    
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
    
    func setupUI() {
        
        tagRestaurantView.layer.borderWidth = 1.0
        tagRestaurantView.layer.borderColor = UIColor(hexString: "c2c2c2").cgColor
        
        if isTaggedRestaurant {
            tagRestaurantView.isHidden = true
            restaurantView.isHidden = false
        }else{
            restaurantView.isHidden = true
            tagRestaurantView.isHidden = false
        }
        
        imgUpload.image = dependency.selectedImage
    }
    
    @IBAction func didTapOnBack(_ sender: UIButton) {
        navigationController?.popViewController(animated: true)
    }
    
    @IBAction func didTapOnCross(_ sender: UIButton) {
    }
    
    @IBAction func didTapOnTagRestaurant(_ sender: UIButton) {
        isTaggedRestaurant = true
        let dependency = OrderListDependency(isComingFromUpload: true)
        guard let vc = OrderListVC.loadFromXIB(withDependency: dependency) else{
            return
        }
        navigationController?.pushViewController(vc, animated: true)
        
    }
    
    @IBAction func didTapOnUpload(_ sender: UIButton) {
        
        //showActionSheet()
        
        //self.checkCameraAccess()
        
        self.navigationController?.popViewController(animated: true)
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
            //self.imagePicker.allowsEditing = true
            self.imagePicker.sourceType = .camera
            //customize
            self.imagePicker.showsCameraControls = true
             self.imagePicker.cameraFlashMode = .on
             self.imagePicker.showsCameraControls = false
            let overlayView = Bundle.main.loadNibNamed("CustomCameraOverlay", owner: nil, options: nil)?.first as! CustomCameraOverlay
            overlayView.delegate = self
            overlayView.frame = (self.imagePicker.cameraOverlayView?.frame)!
            imagePicker.cameraViewTransform = CGAffineTransform(translationX: 0.0, y: 100.0)
            self.imagePicker.cameraOverlayView = overlayView
            self.imagePicker.cameraFlashMode = .on
            self.present(self.imagePicker, animated: true, completion: nil)
        } else {
            self.imagePicker.allowsEditing = true
            self.imagePicker.sourceType = .photoLibrary
            self.present(self.imagePicker, animated: true, completion: nil)
        }
    }
    
}

// MARK: - Load from storyboard with dependency
extension UploadStoryVC {
    class func loadFromXIB(withDependency dependency: UploadStoryDependency? = nil) -> UploadStoryVC? {
        let storyboard = UIStoryboard(name: "UploadStory", bundle: nil)
        guard let viewController = storyboard.instantiateViewController(withIdentifier: "UploadStoryVC") as? UploadStoryVC else {
            return nil
        }
        viewController.dependency = dependency
        return viewController
    }
}

// MARK: - UploadStoryAPIResponseDelegate
extension UploadStoryVC: UploadStoryAPIResponseDelegate {
}

// MARK: - UIImagePickerCintrollerDelegate
extension UploadStoryVC: UIImagePickerControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey: Any]) {
        let img = info[UIImagePickerController.InfoKey.originalImage] as? UIImage
        
        isImageSelected = true
        imgUpload.image = img
        dismiss(animated: true, completion: nil)
    }
}

extension UploadStoryVC: CustomCameraOverlayProtocol {
    
    func switchCamera(isSelected: Bool) {
        if isSelected {
            imagePicker.cameraDevice = .front
        }else{
            imagePicker.cameraDevice = .rear
        }
    }
    
    func cameraTapped(isSelected:Bool) {
        
        imagePicker.takePicture()
    }
    
    func cameraCancelled() {
        imagePicker.dismiss(animated: true) {
            
        }
    }
    
    func galleryTapped() {
        imagePicker.dismiss(animated: true) {
            //open gallery
            let customPicker = CustomPickerVC.loadFromXIB(withDependency: nil)
            customPicker?.delegate = self
            customPicker?.showModally(with: self)
        }
    }
    
    func flashTapped() {
        self.imagePicker.cameraFlashMode = .off
    }
    
    func storyTapped() {
        
    }
    
    func postTapped() {
        
    }
}

extension UploadStoryVC:CustomPickerVCProtocol {
    func didTapOnSave(image: UIImage) {
        imgUpload.image = image
    }
    func didTapOnCamera(){
        self.checkCameraAccess()
    }
}
