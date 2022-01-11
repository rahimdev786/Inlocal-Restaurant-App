//
//  BottumTabBarVC.swift
//  InLocalCustomer
//
//  Created by Sudipta Patel on 01/06/21.
//  Copyright © 2021 ___ORGANIZATIONNAME___. All rights reserved.
//
//

import UIKit
import AZTabBar
import Photos
import ImageCropper

enum PostType {
    case story
    case post
}

class BottumTabBarVC: UIViewController, UINavigationControllerDelegate {
    
    // MARK: Instance variables
	lazy var dataManager = BottumTabBarDataManager()
    var dependency: BottumTabBarDependency?
    
    var counter = 0
    var tabController:AZTabBarController!
    
    let imagePicker = UIImagePickerController()
    var isImageSelected = false
    var selectedImage: UIImage?
    var postType:PostType = .post
    var isCropped = false
    // MARK: - View Life Cycle Methods
	override func viewDidLoad() {
        super.viewDidLoad()
        
        dataManager.apiResponseDelegate = self
        setUpTabBar()
        addObserver()
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
    
    func addObserver(){
        NotificationCenter.default.addObserver(self, selector: #selector(self.clickAtIndex), name: NSNotification.Name(rawValue: "onClickTab"), object: nil)
    }
    
    @objc func clickAtIndex(notification: Notification){
        guard let index = notification.object as? Int else {
            return
        }
        switch index {
        case 0,1,3,4:
            tabController.setIndex(index)
            
        case 2:
            self.tabController.onlyShowTextForSelectedButtons = !self.tabController.onlyShowTextForSelectedButtons
            self.checkCameraAccess()
            
        default:
            print("")
        }
        
    }
}

// MARK: - Load from storyboard with dependency
extension BottumTabBarVC {
    
    class func load(withDependency dependency: BottumTabBarDependency? = nil) -> BottumTabBarVC? {
        
        let storyboard = UIStoryboard(name: "BottumTabBar", bundle: nil)
        
        guard let vc = storyboard.instantiateViewController(withIdentifier: "BottumTabBarVC") as? BottumTabBarVC else {
            return nil
        }
        vc.dependency = dependency
        return vc
    }
}

// MARK: - BottumTabBarAPIResponseDelegate
extension BottumTabBarVC: BottumTabBarAPIResponseDelegate {
    
}

extension BottumTabBarVC{
    func setUpTabBar(){
        var icons = [UIImage]()
        icons.append(#imageLiteral(resourceName: "tab_home"))
        icons.append(#imageLiteral(resourceName: "tab_search"))
        icons.append(#imageLiteral(resourceName: "tab_addpost"))
        icons.append(#imageLiteral(resourceName: "tab_cart"))
        icons.append(#imageLiteral(resourceName: "tab_notification"))
        
        //init
        //tabController = .insert(into: self, withTabIconNames: icons)
        tabController = .insert(into: self, withTabIcons: icons, andSelectedIcons: icons)

        //set delegate
        tabController.delegate = self
        
        //set child controllers
        guard let publicFeedwallViewController = PublicFeedwallVC.load(withDependency: nil) else {
            return
        }
        tabController.setViewController(publicFeedwallViewController, atIndex: 0)
        
        guard let searchViewController = SearchVC.load(withDependency: nil) else {
            return
        }
        tabController.setViewController(searchViewController, atIndex: 1)
        
//        guard let uploadStoryVC = UploadStoryVC.loadFromXIB(withDependency: nil) else {
//            return
//        }
//        tabController.setViewController(uploadStoryVC, atIndex: 2)
//
        
        //CartVC
        guard let cartViewController = DineInCartVC.load(withDependency: nil) else {
            return
        }
        tabController.setViewController(cartViewController, atIndex: 3)
        
        guard let notificationViewController = NotificationsVC.load(withDependency: nil) else {
            return
        }
        tabController.setViewController(notificationViewController, atIndex: 4)
        
        
        
        /*
        //set child controllers
        tabController.setViewController(ColorSelectorController.instance(), atIndex: 0)

        let darkController = getNavigationController(root: LabelController.controller(text: "Search", title: "Recents"))
        darkController.navigationBar.barStyle = .black
        darkController.navigationBar.isTranslucent = false
        darkController.navigationBar.barTintColor = #colorLiteral(red: 0.2039215686, green: 0.2862745098, blue: 0.368627451, alpha: 1)


        tabController.setViewController(UIViewController(), atIndex: 1)

        tabController.setViewController(getNavigationController(root: LabelController.controller(text: "You should really focus on the tab bar.", title: "Chat")), atIndex: 3)

        let buttonController = ButtonController.controller(badgeCount: 0, currentIndex: 4)
        tabController.setViewController(getNavigationController(root: buttonController), atIndex: 4)
        */

        //customize
        let color = UIColor.init(hexString: "#1DA1F2")//(red: 14.0/255, green: 122.0/255, blue: 254.0/255, alpha: 1.0)

        tabController.selectedColor = color

        tabController.highlightColor = color

        tabController.highlightedBackgroundColor = .blue

        tabController.defaultColor = .white

        //tabController.highlightButton(atIndex: 2)
        tabController.buttonsBackgroundColor = UIColor.init(hexString: "#333333")

        tabController.selectionIndicatorHeight = 0

        tabController.selectionIndicatorColor = color

        tabController.tabBarHeight = 60

        tabController.notificationBadgeAppearance.backgroundColor = UIColor.init(hexString: "#1DA1F2")
        tabController.notificationBadgeAppearance.textColor = .white
        tabController.notificationBadgeAppearance.borderColor = .clear
        tabController.notificationBadgeAppearance.borderWidth = 0.2

        tabController.setBadgeText("3", atIndex: 4)

        //tabController.setIndex(10, animated: true)

        tabController.setAction(atIndex: 3){
            self.counter = 0
            self.tabController.setBadgeText(nil, atIndex: 3)
        }

        tabController.setAction(atIndex: 2) {
            self.tabController.onlyShowTextForSelectedButtons = !self.tabController.onlyShowTextForSelectedButtons
            self.checkCameraAccess()
        }

        tabController.setAction(atIndex: 4) {
            //self.tabController.setBar(hidden: true, animated: true)
        }

        tabController.setIndex(0, animated: true)

        tabController.animateTabChange = true
        tabController.onlyShowTextForSelectedButtons = false
        tabController.setTitle("", atIndex: 0)
        tabController.setTitle("", atIndex: 1)
        tabController.setTitle("", atIndex: 2)
        tabController.setTitle("", atIndex: 3)
        tabController.setTitle("", atIndex: 4)
        tabController.font = UIFont(name: "AvenirNext-Regular", size: 12)
        
        let container = tabController.buttonsContainer
        container?.layer.shadowOffset = CGSize(width: 0, height: -2)
        container?.layer.shadowRadius = 10
        container?.layer.shadowOpacity = 0.1
        container?.layer.shadowColor = UIColor.black.cgColor
        
        //tabController.setButtonTintColor(color: #colorLiteral(red: 0.8078431487, green: 0.02745098062, blue: 0.3333333433, alpha: 1), atIndex: 0)
    }
}

extension BottumTabBarVC: AZTabBarDelegate{
    func tabBar(_ tabBar: AZTabBarController, statusBarStyleForIndex index: Int) -> UIStatusBarStyle {
        return (index % 2) == 0 ? .default : .lightContent
    }
    
    func tabBar(_ tabBar: AZTabBarController, shouldLongClickForIndex index: Int) -> Bool {
        return true//index != 2 && index != 3
    }
    
    func tabBar(_ tabBar: AZTabBarController, shouldAnimateButtonInteractionAtIndex index: Int) -> Bool {
        return true
    }
    
    func tabBar(_ tabBar: AZTabBarController, didMoveToTabAtIndex index: Int) {
        print("didMoveToTabAtIndex \(index)")
    }
    
    func tabBar(_ tabBar: AZTabBarController, didSelectTabAtIndex index: Int) {
        print("didSelectTabAtIndex \(index)")
    }
    
    func tabBar(_ tabBar: AZTabBarController, willMoveToTabAtIndex index: Int) {
        print("willMoveToTabAtIndex \(index)")
    }
    
    func tabBar(_ tabBar: AZTabBarController, didLongClickTabAtIndex index: Int) {
        print("didLongClickTabAtIndex \(index)")
    }
    
//    func tabBar(_ tabBar: AZTabBarController, systemSoundIdForButtonAtIndex index: Int) -> SystemSoundID? {
//        return tabBar.selectedIndex == index ? nil : audioId
//    }
    
}

extension BottumTabBarVC{
    
    func checkCameraAccess() {
        switch AVCaptureDevice.authorizationStatus(for: .video) {
        case .denied:
            ()
        case .restricted:
            ()
        case .authorized:
            DispatchQueue.main.async {
                #if targetEnvironment(simulator)
                self.openImagePicker(isCamera: false)
                #else
                self.openImagePicker(isCamera: true)
                #endif
                
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
            
            self.imagePicker.sourceType = .camera
            self.imagePicker.allowsEditing = true
            
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

// MARK: - UIImagePickerCintrollerDelegate
extension BottumTabBarVC: UIImagePickerControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey: Any]) {
        let img = info[UIImagePickerController.InfoKey.originalImage] as? UIImage
        isImageSelected = true
        selectedImage = img
    
        dismiss(animated: true) { [self] in
            
            if self.postType == .story {
                let dependency = UploadStoryDependency(selectedImage: self.selectedImage!)
                guard let uploadStoryVC = UploadStoryVC.loadFromXIB(withDependency: dependency) else {
                    return
                }
                self.navigationController?.pushViewController(uploadStoryVC, animated: true)
            }else{
                
                var config = ImageCropperConfiguration(with: selectedImage!, and: .square)
                //config.maskFillColor = UIColor(displayP3Red: 0.7, green: 0.5, blue: 0.2, alpha: 0.75)
                config.maskFillColor = UIColor.black.withAlphaComponent(0.5)
                config.borderColor = UIColor.white
                config.showGrid = false
                config.gridColor = UIColor.white
                config.doneTitle = "CROP"
                config.cancelTitle = "Cancel"
                isCropped = false
                let cropper = ImageCropperViewController.initialize(with: config, completionHandler: { _croppedImage in
                  /*
                  Code to perform after finishing cropping process
                  */
                    guard let _img = _croppedImage else { return }
                    selectedImage = _img
                    isCropped = true
                    
                }) {
                  /*
                  Code to perform after dismissing controller
                  */
                    if isCropped{
                        let dependency = UploadPostDependency(selectedImage: self.selectedImage!)
                        guard let uploadPostVC = UploadPostVC.loadFromXIB(withDependency: dependency) else {
                            return
                        }
                        uploadPostVC.comeOnTabScreenDelegate = self
                        self.navigationController?.pushViewController(uploadPostVC, animated: true)
                    } else{
                        self.navigationController?.popToRootViewController(animated: false)
                        self.tabController.onlyShowTextForSelectedButtons = !self.tabController.onlyShowTextForSelectedButtons
                        self.checkCameraAccess()
                    }
                }
                self.navigationController?.pushViewController(cropper, animated: true)
                //self.present(cropper, animated: true, completion: nil)

                /*
                let dependency = UploadPostDependency(selectedImage: self.selectedImage!)
                guard let uploadPostVC = UploadPostVC.loadFromXIB(withDependency: dependency) else {
                    return
                }
                self.navigationController?.pushViewController(uploadPostVC, animated: true)
                */
            }
            
        }
    }
}

extension BottumTabBarVC: CustomCameraOverlayProtocol {
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
            var dependency: CustomPickerDependency?
            if self.postType == .story {
                dependency = CustomPickerDependency(title: "New Story", postType: .story)
            }else{
                dependency = CustomPickerDependency(title: "New Post", postType: .post)
            }
            let customPicker = CustomPickerVC.loadFromXIB(withDependency: dependency!)
            customPicker?.delegate = self
            customPicker?.showModally(with: self)
        }
    }
    
    func flashTapped(isSelected: Bool) {
        if isSelected{
            self.imagePicker.cameraFlashMode = .on
        } else{
            self.imagePicker.cameraFlashMode = .off
        }
        
    }
    
    func storyTapped() {
        postType = .story
    }
    
    func postTapped() {
        postType = .post
    }
}

extension BottumTabBarVC:CustomPickerVCProtocol {
    func didTapOnSave(image: UIImage) {
        selectedImage = image
    }
    func didTapOnCamera(){
        self.checkCameraAccess()
    }
}
//ComeOnTabScreen
extension BottumTabBarVC: ComeOnTabScreen{
    func setCropFlag() {
        isCropped = false
    }
}
