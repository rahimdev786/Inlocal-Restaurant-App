//
//  RestaurantProfileVC.swift
//  InLocalCustomer
//
//  Created by Sudipta Patel on 04/06/21.
//  Copyright © 2021 ___ORGANIZATIONNAME___. All rights reserved.
//
//

import UIKit

class RestaurantProfileVC: UIViewController {
    
    // MARK: Instance variables
	lazy var dataManager = RestaurantProfileDataManager()
    var dependency: RestaurantProfileDependency?
    var restaurantDetails: RestaurantDetails?
    var restaurantPostList = [RestaurantPostList]()
    
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var viewProfileBack: UIView!
    @IBOutlet weak var collectionViewPost: UICollectionView!
    
    @IBOutlet weak var collectionViewPost_height: NSLayoutConstraint!
    
    
    @IBOutlet weak var imageViewCover: UIImageView!
    @IBOutlet weak var imageViewRestaurant: UIImageView!
    
    @IBOutlet weak var btnFollow: UIButton!
    @IBOutlet weak var btnMenu: UIButton!
    @IBOutlet weak var btnDelivery: UIButton!
    @IBOutlet weak var btnReservation: UIButton!
    @IBOutlet weak var btnInfo: UIButton!
    
    @IBOutlet weak var btnPostCount: UIButton!
    @IBOutlet weak var btnPostName: UIButton!
    @IBOutlet weak var btnInsideCount: UIButton!
    @IBOutlet weak var btnInsightName: UIButton!
    
    @IBOutlet weak var bntFollowersCount: UIButton!
    @IBOutlet weak var btnFollowingCount: UIButton!
    
    @IBOutlet weak var viewToHightlightPost: UIView!
    @IBOutlet weak var viewToHightlightInsight: UIView!
    
    @IBOutlet weak var lblFollow: UILabel!
    
    @IBOutlet weak var tabBar: UITabBar!
    @IBOutlet weak var tabItemHome: UITabBarItem!
    @IBOutlet weak var tabItemSearch: UITabBarItem!
    @IBOutlet weak var tabItemAddPost: UITabBarItem!
    @IBOutlet weak var tabItemCart: UITabBarItem!
    @IBOutlet weak var tabItemNotification: UITabBarItem!
    
    // MARK: - View Life Cycle Methods
	override func viewDidLoad() {
        super.viewDidLoad()
        
        dataManager.apiResponseDelegate = self
        setupView()
        
        AppActivityIndicator.showActivityIndicator(displayStyle: .dark, displayMessage: "", showInView: self.view)
        dataManager.restaurentDetailsCall(restaurantId: 19)
        
        dataManager.restaurentPostListCall(restaurantId: 19, skip: 0, limit: 10)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.collectionViewPost.addObserver(self, forKeyPath: "contentSize", options: .new, context: nil)
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.collectionViewPost.removeObserver(self, forKeyPath: "contentSize")
    }
    
    // MARK: Deinitialization
    deinit {
       debugPrint("\(self) deinitialized")
    }
    
    @IBAction func onClickBack(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func onClickPost(_ sender: Any) {
        btnPostCount.setTitleColor(UIColor.init(hexString: "#1DA1F2"), for: .normal)
        btnPostName.setTitleColor(UIColor.init(hexString: "#1DA1F2"), for: .normal)
        
        btnInsideCount.setTitleColor(UIColor.black, for: .normal)
        btnInsightName.setTitleColor(UIColor.black, for: .normal)
        
        viewToHightlightPost.backgroundColor = UIColor.init(hexString: "#1DA1F2")
        viewToHightlightInsight.backgroundColor = UIColor.white
        
    }
    
    @IBAction func onClickInsight(_ sender: Any) {
        
        btnPostCount.setTitleColor(UIColor.black, for: .normal)
        btnPostName.setTitleColor(UIColor.black, for: .normal)
        
        btnInsideCount.setTitleColor(UIColor.init(hexString: "#1DA1F2"), for: .normal)
        btnInsightName.setTitleColor(UIColor.init(hexString: "#1DA1F2"), for: .normal)
        
        viewToHightlightPost.backgroundColor = UIColor.white
        viewToHightlightInsight.backgroundColor = UIColor.init(hexString: "#1DA1F2")
    }
    
    @IBAction func onClickFollowers(_ sender: Any) {
        guard let vc = FollowerVC.loadFromXIB(withDependency: nil) else{
            return
        }
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    @IBAction func onClickFollowing(_ sender: Any) {
        guard let vc = FollowerVC.loadFromXIB(withDependency: nil) else{
            return
        }
        self.navigationController?.pushViewController(vc, animated: true)
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
    
    @IBAction func onClickMenu(_ sender: Any) {
        guard let vc = RestaurantMenuVC.load(withDependency: nil) else{
            return
        }
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    @IBAction func onClickDelivery(_ sender: Any) {
        guard let vc = DeliveryVC.load(withDependency: .init(restaurantName: restaurantDetails?.name)) else{
            return
        }
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    @IBAction func onClickFollow(_ sender: UIButton) {
        
        if sender.isSelected {
            sender.isSelected = false
            sender.setImage(#imageLiteral(resourceName: "follow_white"), for: .normal)
            sender.backgroundColor = UIColor.init(hexString: "#1DA1F2")
            lblFollow.text = "Follow"
        } else{
            sender.isSelected = true
            sender.setImage(#imageLiteral(resourceName: "unfollow_icon"), for: .normal)
            sender.backgroundColor =  UIColor.init(hexString: "#333333")
            lblFollow.text = "Unfollow"
        }
    }
    
    @IBAction func onClickReservation(_ sender: Any) {
    //ReservationVC
        guard let vc = ReservationVC.load(withDependency: nil) else{
            return
        }
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    @IBAction func onClickInfo(_ sender: Any) {
        //RestaurantInfoVC
        guard let vc = RestaurantInfoVC.load(withDependency: nil) else{
            return
        }
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    func setupView(){
        tabBar.delegate = self
        tabBar.unselectedItemTintColor = .white
        
        btnFollow.layer.cornerRadius = btnFollow.frame.height/2
        btnMenu.layer.cornerRadius = btnMenu.frame.height/2
        btnDelivery.layer.cornerRadius = btnDelivery.frame.height/2
        btnReservation.layer.cornerRadius = btnReservation.frame.height/2
        btnInfo.layer.cornerRadius = btnInfo.frame.height/2
        
        imageViewRestaurant.layer.cornerRadius = 60
        imageViewRestaurant.layer.masksToBounds = false
        imageViewRestaurant.clipsToBounds = true
        
        imageViewCover.roundCorners([.layerMinXMinYCorner, .layerMaxXMinYCorner], radius: 20)
        
        viewProfileBack.roundCorners([.layerMinXMinYCorner, .layerMaxXMinYCorner], radius: 20)
        
        let widthValue = ((UIScreen.main.bounds.width-44)/2)
        let heightValue = widthValue
        let layout = UICollectionViewFlowLayout()
        layout.minimumInteritemSpacing = 10
        layout.minimumLineSpacing = 10
        layout.itemSize = CGSize(width: widthValue, height: heightValue)
        self.collectionViewPost.setCollectionViewLayout(layout, animated: true)
    }
    
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        if keyPath == "contentSize"{
            if object is UICollectionView{
                if let newvalue = change?[.newKey]{
                    let newsize = newvalue as! CGSize
                    self.collectionViewPost_height.constant = newsize.height
                }
            }
        }
    }
    
    func setDataToView(){
        lblTitle.text = restaurantDetails?.name
        if let postCount = restaurantDetails?.postsCounter{
            btnPostCount.setTitle("\(postCount)", for: .normal)
        }
        
        if let insideCount = restaurantDetails?.insightCounter{
            btnInsideCount.setTitle("\(insideCount)", for: .normal)
        }
        if let followersCount = restaurantDetails?.followers{
            bntFollowersCount.setTitle("\(followersCount)", for: .normal)
        }
        if let followingCount = restaurantDetails?.followings{
            btnFollowingCount.setTitle("\(followingCount)", for: .normal)
        }
        if let coverPhotoUrl = restaurantDetails?.coverImage{
            imageViewCover.sd_setImage(with:  URL(string: coverPhotoUrl), placeholderImage: nil)
        }
        if let restaurantPhotoUrl = restaurantDetails?.coverImage{
            imageViewRestaurant.sd_setImage(with:  URL(string: restaurantPhotoUrl), placeholderImage: nil)
        }
    }
}

// MARK: - Load from storyboard with dependency
extension RestaurantProfileVC {
    
    class func load(withDependency dependency: RestaurantProfileDependency? = nil) -> RestaurantProfileVC? {
        
        let storyboard = UIStoryboard(name: "RestaurantProfile", bundle: nil)
        
        guard let vc = storyboard.instantiateViewController(withIdentifier: "RestaurantProfileVC") as? RestaurantProfileVC else {
            return nil
        }
        vc.dependency = dependency
        return vc
    }
}

// MARK: - RestaurantProfileAPIResponseDelegate
extension RestaurantProfileVC: RestaurantProfileAPIResponseDelegate {
    func restaurantDetailSuccess(withData: RestaurentDetailResponse) {
        AppActivityIndicator.hideActivityIndicator()
        restaurantDetails = withData.restaurantDetails
        if restaurantDetails != nil{
            setDataToView()
        }
    }
    
    func restaurantPostListSuccess(withData: RestaurantPostResponse) {
        restaurantPostList = withData.restaurantPostList ?? []
        collectionViewPost.reloadData()
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

extension RestaurantProfileVC: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return restaurantPostList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "SearchPostCVC", for: indexPath) as! SearchPostCVC
        let postData = restaurantPostList[indexPath.row]
        
        if let postImageUrl = postData.postImage{
            cell.imgViewUserPost.sd_setImage(with:  URL(string: postImageUrl), placeholderImage: nil)
        }
        
        return cell
    }
}

extension RestaurantProfileVC: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let vc = TagedPhotosVC.load(withDependency: nil) else{
            return
        }
        self.navigationController?.pushViewController(vc, animated: true)
    }
}

extension RestaurantProfileVC: UITabBarDelegate {
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


