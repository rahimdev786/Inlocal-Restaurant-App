//
//  CustomPickerVC.swift
//  InLocalCustomer
//
//  Created by Sajib Ghosh on 14/06/21.
//  Copyright © 2021 ___ORGANIZATIONNAME___. All rights reserved.
//
//

import UIKit
import Photos

protocol CustomPickerVCProtocol: AnyObject {
    func didTapOnSave(image:UIImage)
    func didTapOnCamera()
}
class CustomPickerVC: UIViewController {
    // MARK: Instance variables
	lazy var dataManager = CustomPickerDataManager()
    var dependency: CustomPickerDependency!
    
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var imgPicked: UIImageView!
    @IBOutlet weak var pickerView: UIView!
    
    weak var delegate: CustomPickerVCProtocol?
    
    // MARK: - View Life Cycle Methods
	override func viewDidLoad() {
        super.viewDidLoad()
        dataManager.apiResponseDelegate = self
        
        openImagePicker()
        
        lblTitle.text = dependency.title
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
    
    @IBAction func didTapOnClose(_ sender: UIButton) {
        self.dismiss(animated: true) {
        }
    }
    
    @IBAction func didTapOnSave(_ sender: UIButton) {
        
        self.dismiss(animated: true) {
            //self.delegate?.didTapOnSave(image: self.imgPicked.image!)
            
            DispatchQueue.main.async {
                if let rootVC = UIApplication.shared.windows.first?.rootViewController?.children.first{
                    
                    if self.dependency.postType == .story {
                        let dependency = UploadStoryDependency(selectedImage: self.imgPicked.image!)
                        let vc = UploadStoryVC.loadFromXIB(withDependency: dependency)
                        rootVC.navigationController?.pushViewController(vc!, animated: true)
                    }else{
                        let dependency = UploadPostDependency(selectedImage: self.imgPicked.image!)
                        guard let uploadPostVC = UploadPostVC.loadFromXIB(withDependency: dependency) else {
                            return
                        }
                        rootVC.navigationController?.pushViewController(uploadPostVC, animated: true)
                    }
                    
                }
                
            }
        }
        
    }
    
    @IBAction func didTapOnCamera(_ sender: UIButton) {
        
        self.dismiss(animated: true) {
            self.delegate?.didTapOnCamera()
        }
        
    }
    
    
    func openImagePicker() {
        
        let imagePicker = ImagePickerController()
        
        let settings = imagePicker.settings
        settings.fetch.assets.supportedMediaTypes = [.image]
        settings.preview.enabled = false
        
        imagePicker.doneButton.tintColor = .black
        imagePicker.cancelButton.tintColor = .black
        imagePicker.albumButton.tintColor = .black
        
        settings.selection.max = 1
        
        //let button = createCancelButtonWith(text: "0 selected")
        
        //imagePicker.cancelButton.customView = button
        imagePicker.settings = settings
        
        //imagePicker.albumsViewController.view.frame = view.frame
        
        imagePicker.providesPresentationContextTransitionStyle = true
        imagePicker.definesPresentationContext = true
        imagePicker.modalPresentationStyle = UIModalPresentationStyle.overCurrentContext
        imagePicker.imagePickerDelegate = self
        imagePicker.view.frame = self.pickerView.bounds
        self.pickerView.addSubview(imagePicker.view)
        
    }
    
}

// MARK: - Load from storyboard with dependency
extension CustomPickerVC {
    class func loadFromXIB(withDependency dependency: CustomPickerDependency? = nil) -> CustomPickerVC? {
        let storyboard = UIStoryboard(name: "CustomPicker", bundle: nil)
        guard let viewController = storyboard.instantiateViewController(withIdentifier: "CustomPickerVC") as? CustomPickerVC else {
            return nil
        }
        viewController.dependency = dependency
        return viewController
    }
    
    func showModally(with viewController:UIViewController){
        
        self.providesPresentationContextTransitionStyle = true
        self.definesPresentationContext = true
        self.modalPresentationStyle = UIModalPresentationStyle.overCurrentContext
        viewController.present(self, animated: true, completion: nil)
        
    }
}

// MARK: - CustomPickerAPIResponseDelegate
extension CustomPickerVC: CustomPickerAPIResponseDelegate {
}

extension CustomPickerVC: ImagePickerControllerDelegate {
    func imagePicker(_ imagePicker: ImagePickerController, didSelectAsset asset: PHAsset) {
        self.imgPicked.image = getUIImage(asset: asset)
    }
    
    func imagePicker(_ imagePicker: ImagePickerController, didDeselectAsset asset: PHAsset) {
        
    }
    
    func imagePicker(_ imagePicker: ImagePickerController, didFinishWithAssets assets: [PHAsset]) {
        
    }
    
    func imagePicker(_ imagePicker: ImagePickerController, didCancelWithAssets assets: [PHAsset]) {
        
    }
    
    func imagePicker(_ imagePicker: ImagePickerController, didReachSelectionLimit count: Int) {
        
    }
    
    func getUIImage(asset: PHAsset) -> UIImage? {
        
        var img: UIImage?
        let manager = PHImageManager.default()
        let options = PHImageRequestOptions()
        options.version = .original
        options.isSynchronous = true
        manager.requestImageData(for: asset, options: options) { data, _, _, _ in
            
            if let data = data {
                img = UIImage(data: data)
            }
        }
        return img
    }
    
}
