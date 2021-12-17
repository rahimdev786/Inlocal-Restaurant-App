//
//  RestaurantInfoVC.swift
//  InLocalCustomer
//
//  Created by Sudipta Patel on 08/06/21.
//  Copyright © 2021 ___ORGANIZATIONNAME___. All rights reserved.
//
//

import UIKit

class RestaurantInfoVC: UIViewController {
    
    // MARK: Instance variables
	lazy var dataManager = RestaurantInfoDataManager()
    var dependency: RestaurantInfoDependency?
    
    @IBOutlet weak var collctionViewRestaurantImage: UICollectionView!
    @IBOutlet weak var tableViewOpeningHourse: UITableView!
    
    @IBOutlet weak var tableViewOpeningHourse_Height: NSLayoutConstraint!
    @IBOutlet weak var viewTblOpeninghourseBack: UIView!
    
    @IBOutlet weak var tabBar: UITabBar!
    @IBOutlet weak var tabItemHome: UITabBarItem!
    @IBOutlet weak var tabItemSearch: UITabBarItem!
    @IBOutlet weak var tabItemAddPost: UITabBarItem!
    @IBOutlet weak var tabItemCart: UITabBarItem!
    @IBOutlet weak var tabItemNotification: UITabBarItem!
    
    @IBOutlet weak var lblNavigationTitile: UILabel!
    @IBOutlet weak var lblRestaurantName: UILabel!
    @IBOutlet weak var lblAddress: UILabel!
    @IBOutlet weak var lblEmail: UILabel!
    @IBOutlet weak var lblContactNumber: UILabel!
    @IBOutlet weak var lblDeliveryChanges: UILabel!
    
    @IBOutlet weak var pageControlImage: UIPageControl!
    
    var openingHourse = [OpeningHourse]()
    
    // MARK: - View Life Cycle Methods
	override func viewDidLoad() {
        super.viewDidLoad()
        
        dataManager.apiResponseDelegate = self
        setupView()
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
        self.tableViewOpeningHourse.addObserver(self, forKeyPath: "contentSize", options: .new, context: nil)
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.tableViewOpeningHourse.removeObserver(self, forKeyPath: "contentSize")
    }
    
    // MARK: Deinitialization
    deinit {
       debugPrint("\(self) deinitialized")
    }
    
    @IBAction func onClickBack(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func onClickOptions(_ sender: Any) {
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
        
        viewTblOpeninghourseBack.layer.cornerRadius = 20
        viewTblOpeninghourseBack.layer.borderWidth = 1
        viewTblOpeninghourseBack.layer.borderColor = UIColor.lightGray.cgColor
    }
    
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        if keyPath == "contentSize"{
            if object is UITableView{
                if let newvalue = change?[.newKey]{
                    let newsize = newvalue as! CGSize
                    self.tableViewOpeningHourse_Height.constant = newsize.height
                }
            }
        }
    }
    
    func setData(){
        guard let restaurantDetail = dependency?.restaurantDetails else {
            return
        }
        
        lblNavigationTitile.text = restaurantDetail.name
        lblRestaurantName.text = restaurantDetail.name
        lblAddress.text = restaurantDetail.address
        lblEmail.text = restaurantDetail.email
        lblContactNumber.text = restaurantDetail.phone?.number
        
        openingHourse = restaurantDetail.openingHourse ?? []
        //lblDeliveryChanges.text = "€ \(restaurantDetail.)"
        tableViewOpeningHourse.reloadData()
        
    }
}

// MARK: - Load from storyboard with dependency
extension RestaurantInfoVC {
    
    class func load(withDependency dependency: RestaurantInfoDependency? = nil) -> RestaurantInfoVC? {
        
        let storyboard = UIStoryboard(name: "RestaurantInfo", bundle: nil)
        
        guard let vc = storyboard.instantiateViewController(withIdentifier: "RestaurantInfoVC") as? RestaurantInfoVC else {
            return nil
        }
        vc.dependency = dependency
        return vc
    }
}

// MARK: - RestaurantInfoAPIResponseDelegate
extension RestaurantInfoVC: RestaurantInfoAPIResponseDelegate {
    
}

extension RestaurantInfoVC: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 3
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "RestaurantImageCVC", for: indexPath) as! RestaurantImageCVC
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        self.pageControlImage.currentPage = indexPath.row
    }

}

extension RestaurantInfoVC : UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.size.width, height:  (204))
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }

}

extension RestaurantInfoVC: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return openingHourse.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "OpeningHourseTVC", for: indexPath) as! OpeningHourseTVC
        let workingData = openingHourse[indexPath.row]
        cell.lblDayName.text = workingData.weekdayName
        cell.lblTime.text = "\(workingData.starttime!) - \(workingData.closeTime!)"
        return cell
    }
}

extension RestaurantInfoVC: UITabBarDelegate {
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
