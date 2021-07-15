// The MIT License (MIT)
//
// Copyright (c) 2019 Joakim Gyllström
//
// Permission is hereby granted, free of charge, to any person obtaining a copy
// of this software and associated documentation files (the "Software"), to deal
// in the Software without restriction, including without limitation the rights
// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
// copies of the Software, and to permit persons to whom the Software is
// furnished to do so, subject to the following conditions:
//
// The above copyright notice and this permission notice shall be included in all
// copies or substantial portions of the Software.
//
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
// SOFTWARE.

import UIKit
import Photos

// MARK: ImagePickerController
@objcMembers open class ImagePickerController: UINavigationController {
    // MARK: Public properties
    
    
    public weak var imagePickerDelegate: ImagePickerControllerDelegate?
    public var settings: Settings = Settings()
    public var doneButton: UIBarButtonItem = UIBarButtonItem(title: "", style: .done, target: nil, action: nil)
    public var cancelButton: UIBarButtonItem = UIBarButtonItem(barButtonSystemItem: .cancel, target: nil, action: nil)
    public var albumButton: UIButton = UIButton(type: .custom)
    public var selectedAssets: [PHAsset] {
        get {
            return assetStore.assets
        }
    }

    // Note this trick to get the apple localization no longer works.
    // Figure out why. Until then, expose the variable for users to set to whatever they want it localized to
    // TODO: Fix this ^^
    /// Title to use for button
    public var doneButtonTitle = Bundle(identifier: "com.apple.UIKit")?.localizedString(forKey: "OK", value: "OK", table: "") ?? "OK"

    // MARK: Internal properties
    var assetStore: AssetStore
    var onSelection: ((_ asset: PHAsset) -> Void)?
    var onDeselection: ((_ asset: PHAsset) -> Void)?
    var onCancel: ((_ assets: [PHAsset]) -> Void)?
    var onFinish: ((_ assets: [PHAsset]) -> Void)?
    
    let assetsViewController: AssetsViewController
    let albumsViewController = AlbumsViewController()
    let dropdownTransitionDelegate = DropdownTransitionDelegate()
    let zoomTransitionDelegate = ZoomTransitionDelegate()

    lazy var albums: [PHAssetCollection] = {
        // We don't want collections without assets.
        // I would like to do that with PHFetchOptions: fetchOptions.predicate = NSPredicate(format: "estimatedAssetCount > 0")
        // But that doesn't work...
        // This seems suuuuuper ineffective...
        let fetchOptions = settings.fetch.assets.options.copy() as! PHFetchOptions
        fetchOptions.fetchLimit = 1

        return settings.fetch.album.fetchResults.filter {
            $0.count > 0
        }.flatMap {
            $0.objects(at: IndexSet(integersIn: 0..<$0.count))
        }.filter {
            // We can't use estimatedAssetCount on the collection
            // It returns NSNotFound. So actually fetch the assets...
            let assetsFetchResult = PHAsset.fetchAssets(in: $0, options: fetchOptions)
            return assetsFetchResult.count > 0
        }
    }()

    public init(selectedAssets: [PHAsset] = []) {
        assetStore = AssetStore(assets: selectedAssets)
        assetsViewController = AssetsViewController(store: assetStore)
        super.init(nibName: nil, bundle: nil)
    }

    public required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    open override func viewDidLoad() {
        super.viewDidLoad()
        
        // Sync settings
        albumsViewController.settings = settings
        assetsViewController.settings = settings
        
        // Setup view controllers
        albumsViewController.delegate = self
        assetsViewController.delegate = self
        
        assetsViewController.pickerVC = self
        
        viewControllers = [assetsViewController]
        view.backgroundColor = settings.theme.backgroundColor

        // Setup delegates
        delegate = zoomTransitionDelegate
        presentationController?.delegate = self

        // Turn off translucency so drop down can match its color
        navigationBar.isTranslucent = false
        navigationBar.isOpaque = true
        
        // Setup buttons
        let firstViewController = viewControllers.first
        
//        albumButton.setTitleColor(albumButton.tintColor, for: .normal)
//        albumButton.titleLabel?.font = .systemFont(ofSize: 16)
//        albumButton.titleLabel?.adjustsFontSizeToFitWidth = true
//
//        let arrowView = ArrowView(frame: CGRect(x: 0, y: 0, width: 8, height: 8))
//        arrowView.backgroundColor = .clear
//        arrowView.strokeColor = albumButton.tintColor
//        let image = arrowView.asImage
//
//        albumButton.setImage(image, for: .normal)
//        albumButton.semanticContentAttribute = .forceRightToLeft // To set image to the right without having to calculate insets/constraints.
//        albumButton.addTarget(self, action: #selector(ImagePickerController.albumsButtonPressed(_:)), for: .touchUpInside)
//        firstViewController?.navigationItem.titleView = albumButton

//        doneButton.target = self
//        doneButton.action = #selector(doneButtonPressed(_:))
//        firstViewController?.navigationItem.rightBarButtonItem = doneButton

        //************ Changed
        
//        cancelButton.target = self
//        cancelButton.action = #selector(cancelButtonPressed(_:))
//        firstViewController?.navigationItem.leftBarButtonItem = cancelButton
        
        albumButton.setTitleColor(albumButton.tintColor, for: .normal)
        albumButton.titleLabel?.font = .systemFont(ofSize: 16)
        albumButton.titleLabel?.adjustsFontSizeToFitWidth = true

        let arrowView = ArrowView(frame: CGRect(x: 0, y: 0, width: 8, height: 8))
        arrowView.backgroundColor = .clear
        arrowView.strokeColor = albumButton.tintColor
        let image = arrowView.asImage

        albumButton.setImage(image, for: .normal)
        albumButton.semanticContentAttribute = .forceRightToLeft // To set image to the right without having to calculate insets/constraints.
        albumButton.addTarget(self, action: #selector(ImagePickerController.albumsButtonPressed(_:)), for: .touchUpInside)
        let contentView = UIView(frame: CGRect(x: 0.0, y: 0.0, width: 110, height: 25.0))
        albumButton.frame = CGRect(x: 18.0, y: 2.0, width: 90, height: 25.0)
        contentView.backgroundColor = .lightGray
        contentView.layer.cornerRadius = 12.5
        //contentView.bounds = contentView.bounds.offsetBy(dx: -50, dy: 0)
        contentView.addSubview(albumButton)
        let leftBarButton = UIBarButtonItem(customView: contentView)
        firstViewController?.navigationItem.leftBarButtonItem = leftBarButton
        firstViewController?.navigationController?.navigationBar.bounds = (firstViewController?.navigationController?.navigationBar.bounds.offsetBy(dx: 10, dy: 0))!
        updatedDoneButton()
        updateAlbumButton()

        // We need to have some color to be able to match with the drop down
        if navigationBar.barTintColor == nil {
            navigationBar.barTintColor = .systemBackgroundColor
        }

        if let firstAlbum = albums.first {
            select(album: firstAlbum)
        }
        
        firstViewController?.navigationController?.navigationBar.setValue(true, forKey: "hidesShadow")
    }
    
    // Actually it will update cancel button after modification

    func updatedDoneButton() {
        //doneButton.title = assetStore.count > 0 ? doneButtonTitle + " (\(assetStore.count))" : doneButtonTitle
        doneButton.title = "OK"
        let cancelTitle =  assetStore.count > 0 ?  "\(assetStore.count) selected" : "0 selected"
        cancelButton.customView = createCancelButtonWith(text: cancelTitle)
        doneButton.isEnabled = assetStore.count >= settings.selection.min
    }

    func updateAlbumButton() {
        albumButton.isHidden = albums.count < 2
    }
    
    // ********* Changed
    func createCancelButtonWith(text:String) -> UIButton {
        
        let button =  UIButton(type: .custom)
        button.setImage(UIImage(named: "crossgrnImg"), for: .normal)
        button.frame = CGRect(x: 0.0, y: 0.0, width: 100.0, height: 31.0)
        button.imageEdgeInsets = UIEdgeInsets(top: -1, left: -40, bottom: 1, right: 40)//move image to the left
        button.addTarget(self, action: Selector(("cancelButtonTapped")), for: .touchUpInside)
        let label = UILabel(frame: CGRect(x: 5.0, y: 5.0, width: 100.0, height: 20.0))
        label.font = UIFont.systemFont(ofSize: 12)
        label.text = text
        label.textAlignment = .center
        label.textColor = UIColor.black
        label.backgroundColor =   UIColor.clear
        button.addSubview(label)
        return button
    }
}
