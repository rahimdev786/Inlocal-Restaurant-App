//
//  MenuDetailVC.swift
//  InLocalCustomer
//
//  Created by Sudipta Patel on 07/06/21.
//  Copyright © 2021 ___ORGANIZATIONNAME___. All rights reserved.
//
//

import UIKit

class MenuDetailVC: UIViewController {
    
    // MARK: Instance variables
	lazy var dataManager = MenuDetailDataManager()
    var dependency: MenuDetailDependency?
    
    @IBOutlet weak var collectionViewMenuImage: UICollectionView!
    @IBOutlet weak var collectionViewMenuImage_height: NSLayoutConstraint!
    
    @IBOutlet weak var lblRestaurantName: UILabel!
    @IBOutlet weak var imageViewMenu: UIImageView!
    @IBOutlet weak var lblMenu: UILabel!
    @IBOutlet weak var lblDetails: UILabel!
    @IBOutlet weak var lblPrice: UILabel!
    
    @IBOutlet weak var stackViewAddItem: UIStackView!
    @IBOutlet weak var btnCount: UIButton!
    @IBOutlet weak var btnMinus: UIButton!
    @IBOutlet weak var btnPlus: UIButton!
    
    @IBOutlet weak var tabBar: UITabBar!
    @IBOutlet weak var tabItemHome: UITabBarItem!
    @IBOutlet weak var tabItemSearch: UITabBarItem!
    @IBOutlet weak var tabItemAddPost: UITabBarItem!
    @IBOutlet weak var tabItemCart: UITabBarItem!
    @IBOutlet weak var tabItemNotification: UITabBarItem!
    
    var pageType : PageType!
    var menuItemDetails : MenuListing?
    
    // MARK: - View Life Cycle Methods
	override func viewDidLoad() {
        super.viewDidLoad()
        
        dataManager.apiResponseDelegate = self
        setupView()
        
        AppActivityIndicator.showActivityIndicator(displayStyle: .dark, displayMessage: "", showInView: self.view)
        dataManager.menuDetailCall(menuItemId: 17, restaurantId: 19)
        
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.collectionViewMenuImage.addObserver(self, forKeyPath: "contentSize", options: .new, context: nil)
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.collectionViewMenuImage.removeObserver(self, forKeyPath: "contentSize")
    }
    
    // MARK: Deinitialization
    deinit {
       debugPrint("\(self) deinitialized")
    }
    
    @IBAction func onClickBack(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func onClickCount(_ sender: Any) {
        guard let vc = MenuCustomisationVC.load(withDependency: .init(menuDitails: menuItemDetails)) else{
            return
        }
        vc.customizeList = (menuItemDetails?.customizeList)!
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    @IBAction func onClickPlus(_ sender: Any) {
        var count = Int((btnCount.titleLabel?.text!)!)
        count = count! + 1
        btnCount.setTitle(String(count!), for: .normal)
    }
    
    
    @IBAction func onClickMinus(_ sender: Any) {
        var count = Int((btnCount.titleLabel?.text!)!)!
        if count > 1{
            count = count - 1
            btnCount.setTitle(String(count), for: .normal)
        }
    }
    
    func setupView(){
        switch pageType {
        case .menu:
            stackViewAddItem.isHidden = true
        case .delivery:
            stackViewAddItem.isHidden = false
        default:
            print("")
        }
        
        tabBar.delegate = self
        tabBar.unselectedItemTintColor = .white
        
        btnMinus.isHidden = true
        btnPlus.isHidden = true
        
        let widthValue = ((UIScreen.main.bounds.width-44)/2)
        let heightValue = widthValue
        let layout = UICollectionViewFlowLayout()
        layout.minimumInteritemSpacing = 10
        layout.minimumLineSpacing = 10
        layout.itemSize = CGSize(width: widthValue, height: heightValue)
        self.collectionViewMenuImage.setCollectionViewLayout(layout, animated: true)
    }
    
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        if keyPath == "contentSize"{
            if object is UICollectionView{
                if let newvalue = change?[.newKey]{
                    let newsize = newvalue as! CGSize
                    self.collectionViewMenuImage_height.constant = newsize.height
                }
            }
        }
    }
    
    func setData(){
        imageViewMenu.roundedCorners([.topLeft, .topRight], radius: 40)
        
        if let menuImage = menuItemDetails?.image{
            imageViewMenu.sd_setImage(with:  URL(string: menuImage), placeholderImage: nil)
        }
        
        if let menuName = menuItemDetails?.name{
            lblMenu.text = menuName
        }
        
        if let menuPrice = menuItemDetails?.price{
            lblPrice.text = "€ \(menuPrice)"
        }
        
        if let menuDescription = menuItemDetails?.description{
            lblDetails.text = menuDescription
        }
        
        lblRestaurantName.text = dependency?.restaurantName
    }
}

// MARK: - Load from storyboard with dependency
extension MenuDetailVC {
    
    class func load(withDependency dependency: MenuDetailDependency? = nil) -> MenuDetailVC? {
        
        let storyboard = UIStoryboard(name: "MenuDetail", bundle: nil)
        
        guard let vc = storyboard.instantiateViewController(withIdentifier: "MenuDetailVC") as? MenuDetailVC else {
            return nil
        }
        vc.dependency = dependency
        
        return vc
    }
}

// MARK: - MenuDetailAPIResponseDelegate
extension MenuDetailVC: MenuDetailAPIResponseDelegate {
    func menuDetailSuccess(withData: MenuDetailResponse) {
        AppActivityIndicator.hideActivityIndicator()
        menuItemDetails = withData.menuItemDetails
        setData()
        //print(withData.menuItemDetails)
    }
    
    func apiError(_ error: APIError) {
        AppActivityIndicator.hideActivityIndicator()
        self.view.makeToast("\(error.errorDescription ?? "")")
    }
    
    func networkError(_ error: Error) {
        AppActivityIndicator.hideActivityIndicator()
        if let error = error.asAFError?.underlyingError as NSError? {
            if error.code == APIError.noInternet.rawValue {
               self.view.makeToast("NoInternet".localiz())
            } else if error.code == -1001 {
                self.view.makeToast("TimeOut".localiz())
            } else {
                self.view.makeToast(error.localizedDescription)
            }
        } else {
            self.view.makeToast(error.localizedDescription)
        }
    }
}

extension MenuDetailVC: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 6
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "SearchPostCVC", for: indexPath) as! SearchPostCVC
        return cell
    }
}

extension MenuDetailVC: UITabBarDelegate {
    func tabBar(_ tabBar: UITabBar, didSelect item: UITabBarItem) {
        switch item {
        case tabItemHome:
            NotificationCenter.default.post(name: NSNotification.Name(rawValue: "onClickTab"), object: 0)
            self.navigationController?.popToRootViewController(animated: true)
            
        case tabItemSearch:
            NotificationCenter.default.post(name: NSNotification.Name(rawValue: "onClickTab"), object: 1)
            self.navigationController?.popToRootViewController(animated: true)
            
        case tabItemAddPost:
            NotificationCenter.default.post(name: NSNotification.Name(rawValue: "onClickTab"), object: 2)
            self.navigationController?.popToRootViewController(animated: true)
            
        case tabItemCart:
            NotificationCenter.default.post(name: NSNotification.Name(rawValue: "onClickTab"), object: 3)
            self.navigationController?.popToRootViewController(animated: true)
            
        case tabItemNotification:
            NotificationCenter.default.post(name: NSNotification.Name(rawValue: "onClickTab"), object: 4)
            self.navigationController?.popToRootViewController(animated: true)
            
        default:
            print("")
        }
    }
}
