//
//  DeliveryVC.swift
//  InLocalCustomer
//
//  Created by Sudipta Patel on 07/06/21.
//  Copyright © 2021 ___ORGANIZATIONNAME___. All rights reserved.
//
//

import UIKit

class DeliveryVC: UIViewController {
    
    // MARK: Instance variables
	lazy var dataManager = DeliveryDataManager()
    var dependency: DeliveryDependency?
    
    @IBOutlet weak var collectionViewMenuCategory: UICollectionView!
    @IBOutlet weak var tableViewDeliveryMenu: UITableView!
    
    @IBOutlet weak var tabBar: UITabBar!
    @IBOutlet weak var tabItemHome: UITabBarItem!
    @IBOutlet weak var tabItemSearch: UITabBarItem!
    @IBOutlet weak var tabItemAddPost: UITabBarItem!
    @IBOutlet weak var tabItemCart: UITabBarItem!
    @IBOutlet weak var tabItemNotification: UITabBarItem!
    
    var categoryArray = ["All", "Starter", "Burger", "Drinks", "Soup", "Pizza"]
    var previousCell: MenuCategoryCVC?
    
    var menuCategoryList = [MenuCategoryList]()
    var menuListing = [MenuListing]()
    
    // MARK: - View Life Cycle Methods
	override func viewDidLoad() {
        super.viewDidLoad()
        
        dataManager.apiResponseDelegate = self
        setupView()
        
        AppActivityIndicator.showActivityIndicator(displayStyle: .dark, displayMessage: "", showInView: self.view)
        dataManager.menuCategoryListCall(skip: 0, limit: 10, restaurantId: 19)
        
        dataManager.menuListCall(skip: 0, limit: 10, restaurantId: 19, menuCategoryId: 14, deliveryAvailable: 0, eatInsideAvailable: 0)
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
    
    @IBAction func onClickOption(_ sender: Any) {
        let alertController = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        let action0 = UIAlertAction(title: "Block", style: .default) { (action) in
            
        }
        action0.setValue(UIColor.black, forKey: "titleTextColor")
        
        let action1 = UIAlertAction(title: "Report", style: .default) { (action) in
            
        }
        action1.setValue(UIColor.black, forKey: "titleTextColor")
        
        let action2 = UIAlertAction(title: "Share", style: .default) { (action) in
            
        }
        action2.setValue(UIColor.black, forKey: "titleTextColor")
        
        let action3 = UIAlertAction(title: "Cancel", style: .default) { (action) in
            
        }
        action3.setValue(UIColor.black, forKey: "titleTextColor")
        
        alertController.addAction(action0)
        alertController.addAction(action1)
        alertController.addAction(action2)
        alertController.addAction(action3)
        self.present(alertController, animated: true, completion: nil)
    }
    
    func setupView(){
        tabBar.delegate = self
        tabBar.unselectedItemTintColor = .white
    }
}

// MARK: - Load from storyboard with dependency
extension DeliveryVC {
    
    class func load(withDependency dependency: DeliveryDependency? = nil) -> DeliveryVC? {
        
        let storyboard = UIStoryboard(name: "Delivery", bundle: nil)
        
        guard let vc = storyboard.instantiateViewController(withIdentifier: "DeliveryVC") as? DeliveryVC else {
            return nil
        }
        vc.dependency = dependency
        return vc
    }
}

// MARK: - DeliveryAPIResponseDelegate
extension DeliveryVC: DeliveryAPIResponseDelegate {
    func menuCategoryListSuccess(withData: MenuCategoryListResponse) {
        AppActivityIndicator.hideActivityIndicator()
        print(withData.categoryList)
        self.menuCategoryList = withData.categoryList ?? []
        collectionViewMenuCategory.reloadData()
    }
    
    func menuListSuccess(withData: MenuListResponse) {
        AppActivityIndicator.hideActivityIndicator()
        self.menuListing = withData.menuListing ?? []
        tableViewDeliveryMenu.reloadData()
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
//DeliveryMenuTVC
extension DeliveryVC: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return menuCategoryList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MenuCategoryCVC", for: indexPath) as! MenuCategoryCVC
        cell.lblCategoryName.text = menuCategoryList[indexPath.row].name!
        if indexPath.row == 0 {
            previousCell = cell
            cell.viewLblBackground.backgroundColor = UIColor(hexString: "1DA1F2")
        }else{
            cell.viewLblBackground.backgroundColor = UIColor(hexString: "333333")
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        let cell = collectionView.cellForItem(at: indexPath) as! MenuCategoryCVC
        cell.viewLblBackground.backgroundColor = UIColor(hexString: "1DA1F2")
        previousCell?.viewLblBackground.backgroundColor = UIColor(hexString: "333333")
        previousCell = cell
        
    }
}

extension DeliveryVC: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return menuListing.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "DeliveryMenuTVC", for: indexPath) as! DeliveryMenuTVC
        let menuData = menuListing[indexPath.row]
        cell.lblMenuName.text = menuData.name
        cell.lblMenuDetails.text = menuData.description
        if let menuPrice = menuData.price{
            cell.lblMenuPrice.text = "€ \(menuPrice)"
        }
        if let menuIconURL = menuData.image{
            cell.imageViewMenu.sd_setImage(with:  URL(string: menuIconURL), placeholderImage: nil)
        }
        return cell
    }
    
}

extension DeliveryVC : UITableViewDelegate{
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let vc = MenuDetailVC.load(withDependency: nil) else{
            return
        }
        vc.pageType = .delivery
        self.navigationController?.pushViewController(vc, animated: true)
    }
}

extension DeliveryVC{
    @objc func onClickCustomizable(sender: UIButton){
        let buttonTag = sender.tag
        guard let vc = MenuCustomisationVC.load(withDependency: nil) else{
            return
        }
        self.navigationController?.pushViewController(vc, animated: true)
    }
}

extension DeliveryVC: UITabBarDelegate {
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
