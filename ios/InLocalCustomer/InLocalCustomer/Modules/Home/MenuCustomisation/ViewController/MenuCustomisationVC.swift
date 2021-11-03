//
//  MenuCustomisationVC.swift
//  InLocalCustomer
//
//  Created by Sudipta Patel on 11/06/21.
//  Copyright © 2021 ___ORGANIZATIONNAME___. All rights reserved.
//
//

import UIKit

class MenuCustomisationVC: UIViewController {
    
    // MARK: Instance variables
    lazy var dataManager = MenuCustomisationDataManager()
    var dependency: MenuCustomisationDependency?
    
    @IBOutlet weak var lblItemTotal: UILabel!
    @IBOutlet weak var lblNemuName: UILabel!
    @IBOutlet weak var lblPrice: UILabel!
    @IBOutlet weak var imageViewMenu: UIImageView!
    @IBOutlet weak var tableViewCustomisation: UITableView!
    
    @IBOutlet weak var tableViewCustomisation_Height: NSLayoutConstraint!
    
    @IBOutlet weak var btnMinus: UIButton!
    @IBOutlet weak var btnCount: UIButton!
    @IBOutlet weak var btnPlus: UIButton!
    
    var customizeList = [CustomizeList]()
    var addOnArray = [Dictionary<String,Any>]()
    
    // MARK: - View Life Cycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        
        dataManager.apiResponseDelegate = self
        setData()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.tableViewCustomisation.addObserver(self, forKeyPath: "contentSize", options: .new, context: nil)
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.tableViewCustomisation.removeObserver(self, forKeyPath: "contentSize")
    }
    
    // MARK: Deinitialization
    deinit {
       debugPrint("\(self) deinitialized")
    }
    
    @IBAction func onClickBack(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func onClickMinus(_ sender: Any) {
        var count = Int((btnCount.titleLabel?.text!)!)!
        if count > 1{
            count = count - 1
            btnCount.setTitle(String(count), for: .normal)
        }
    }
    
    @IBAction func onClickPlus(_ sender: Any) {
        var count = Int((btnCount.titleLabel?.text!)!)
        count = count! + 1
        btnCount.setTitle(String(count!), for: .normal)
    }
    
    @IBAction func onClickAddToCart(_ sender: Any) {
        AppActivityIndicator.showActivityIndicator(displayStyle: .dark, displayMessage: "", showInView: self.view)
        
        guard let menuDetails = dependency?.menuDitails else {
            return
        }
        
        guard let restaurantId = menuDetails.id, let menuItemId = menuDetails.id, let menuItemName = menuDetails.name, let price = menuDetails.price else {
            return
        }
        
        guard let priceInDouble = Double(price) else{
            return
        }
        
        guard let quantity = Int((btnCount.titleLabel?.text!)!) else {
            return
        }
        
        dataManager.addToCartCall(restaurantId: 19, menuItemId: menuItemId, menuItemName: menuItemName, price: priceInDouble, quantity: quantity, subaddon:addOnArray)
    }
    
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        if keyPath == "contentSize"{
            if object is UITableView{
                if let newvalue = change?[.newKey]{
                    let newsize = newvalue as! CGSize
                    self.tableViewCustomisation_Height.constant = newsize.height
                }
            }
        }
    }
    
    func setData(){
        
        imageViewMenu.roundedCorners([.topLeft, .topRight], radius: 20)
        
        guard let menuDetails = dependency?.menuDitails else {
            return
        }
        
        if let menuName = menuDetails.name{
            lblNemuName.text = menuName
        }
        
        if let menuPrice = menuDetails.price{
            lblPrice.text = "€ \(menuPrice)"
        }
        
        if let menuImage = menuDetails.image{
            imageViewMenu.sd_setImage(with:  URL(string: menuImage), placeholderImage: nil)
        }
        
        if let isInCart = menuDetails.inInCart{
            
            if isInCart{
                
            } else{
                
                if let menuPrice = menuDetails.price{
                    lblItemTotal.text = "€ \(menuPrice)"
                }
            }
        }
    }
}

// MARK: - Load from storyboard with dependency
extension MenuCustomisationVC {
    
    class func load(withDependency dependency: MenuCustomisationDependency? = nil) -> MenuCustomisationVC? {
        
        let storyboard = UIStoryboard(name: "MenuCustomisation", bundle: nil)
        
        guard let vc = storyboard.instantiateViewController(withIdentifier: "MenuCustomisationVC") as? MenuCustomisationVC else {
            return nil
        }
        vc.dependency = dependency
        return vc
    }
}

// MARK: - MenuCustomisationAPIResponseDelegate
extension MenuCustomisationVC: MenuCustomisationAPIResponseDelegate {
    func addToCartSuccess(withData: AddToCartResponse) {
        AppActivityIndicator.hideActivityIndicator()
        print(withData)
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

extension MenuCustomisationVC: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return customizeList.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return customizeList[section].menuitemsubaddon!.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MenuCustomisationTVC", for: indexPath) as! MenuCustomisationTVC
        
        if customizeList[indexPath.section].menuitemsubaddon![indexPath.row].isSelectedInCart!{
            cell.btnFirst.setImage(#imageLiteral(resourceName: "tick_round_blue"), for: .normal)
            let addOnId = customizeList[indexPath.section].id!
            let addOnName = customizeList[indexPath.section].title!
            let subAddOnId = customizeList[indexPath.section].menuitemsubaddon![indexPath.row].id!
            let subAddOnName = customizeList[indexPath.section].menuitemsubaddon![indexPath.row].name!
            let price = customizeList[indexPath.section].menuitemsubaddon![indexPath.row].price!
            
            let addOn = ["addon_id" : addOnId,
                          "addon_name" : addOnName,
                          "sub_addon_id" : subAddOnId,
                          "sub_addon_name" : subAddOnName,
                          "price" : price,
                          "qty" : 1
            ] as [String : Any]
            addOnArray.append(addOn)
            
        } else{
            cell.btnFirst.setImage(#imageLiteral(resourceName: "radio_unselect"), for: .normal)
        }
        cell.lblFirst.text = customizeList[indexPath.section].menuitemsubaddon![indexPath.row].name
        cell.lblPrice.text = "€ \(customizeList[indexPath.section].menuitemsubaddon![indexPath.row].price!)"
        return cell
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return customizeList[section].title
    }
}

extension MenuCustomisationVC: UITableViewDelegate{
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        customizeList[indexPath.section].menuitemsubaddon![indexPath.row].isSelectedInCart = true
        tableView.reloadData()
    }
}
