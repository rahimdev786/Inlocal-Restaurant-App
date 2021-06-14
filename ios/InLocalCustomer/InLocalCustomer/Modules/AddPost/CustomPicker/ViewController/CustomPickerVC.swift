//
//  CustomPickerVC.swift
//  InLocalCustomer
//
//  Created by Sajib Ghosh on 14/06/21.
//  Copyright © 2021 ___ORGANIZATIONNAME___. All rights reserved.
//
//

import UIKit

class CustomPickerVC: UIViewController {
    // MARK: Instance variables
	lazy var dataManager = CustomPickerDataManager()
    var dependency: CustomPickerDependency?
    
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var imgPicked: UIImageView!
    @IBOutlet weak var pickerView: UIView!
    
    
    
    // MARK: - View Life Cycle Methods
	override func viewDidLoad() {
        super.viewDidLoad()
        dataManager.apiResponseDelegate = self
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
        navigationController?.popViewController(animated: true)
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
        
        presentImagePicker(imagePicker, select: { (asset) in
            // User selected an asset. Do something with it. Perhaps begin processing/upload?

            
        }, deselect: { (asset) in
            // User deselected an asset. Cancel whatever you did when asset was selected.
        }, cancel: { (assets) in
            // User canceled selection.
        }, finish: { (assets) in
            // User finished selection assets.
            imagePicker.dismiss(animated: true, completion: {
                
//                if let image = self.getUIImage(asset: assets[0]) {
//
//                    self.presentCropViewControllerWith(selectedImage: image)
//                }
            })
        })
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
