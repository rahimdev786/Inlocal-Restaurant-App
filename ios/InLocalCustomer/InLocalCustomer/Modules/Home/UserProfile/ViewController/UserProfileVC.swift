//
//  UserProfileVC.swift
//  InLocalCustomer
//
//  Created by Sudipta Patel on 04/06/21.
//  Copyright © 2021 ___ORGANIZATIONNAME___. All rights reserved.
//
//

import UIKit

class UserProfileVC: UIViewController {
    
    // MARK: Instance variables
	lazy var dataManager = UserProfileDataManager()
    var dependency: UserProfileDependency?
    
    @IBOutlet weak var lblCustomerName: UILabel!
    @IBOutlet weak var viewProfileImageBack: UIView!
    @IBOutlet weak var imageViewCustomerProfile: UIImageView!
    @IBOutlet weak var collectionViewPost: UICollectionView!
    
    @IBOutlet weak var collectionViewPost_height: NSLayoutConstraint!
    @IBOutlet weak var btnFollow: UIButton!
    
    @IBOutlet weak var tabBar: UITabBar!
    @IBOutlet weak var tabItemHome: UITabBarItem!
    @IBOutlet weak var tabItemSearch: UITabBarItem!
    @IBOutlet weak var tabItemAddPost: UITabBarItem!
    @IBOutlet weak var tabItemCart: UITabBarItem!
    @IBOutlet weak var tabItemNotification: UITabBarItem!
    
    @IBOutlet weak var btnPostCount: UILabel!
    @IBOutlet weak var btnFollowersCount: UIButton!
    @IBOutlet weak var btnFollowingCount: UIButton!
    
    var isFollowSelected = false
    var customerDetails: CustomerDetails?
    var customerPostList = [CustomerPostList]()
    
    // MARK: - View Life Cycle Methods
	override func viewDidLoad() {
        super.viewDidLoad()
        
        dataManager.apiResponseDelegate = self
        setupView()
        
        AppActivityIndicator.showActivityIndicator(displayStyle: .dark, displayMessage: "", showInView: self.view)
        dataManager.customerDetailsCall(customerId: 10)
        dataManager.userPostListCall(userId: 10, skip: 0, limit: 10)
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
    
    func setupView(){
        tabBar.delegate = self
        tabBar.unselectedItemTintColor = .white
        
        viewProfileImageBack.roundCorners([.layerMinXMinYCorner, .layerMaxXMinYCorner], radius: 20)
        imageViewCustomerProfile.layer.cornerRadius = 50
        imageViewCustomerProfile.layer.masksToBounds = false
        imageViewCustomerProfile.clipsToBounds = true
        
        btnFollow.layer.cornerRadius = 3.0
        
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
        lblCustomerName.text = customerDetails?.name
        if let customerPhotoUrl = customerDetails?.profilePicture{
            imageViewCustomerProfile.sd_setImage(with:  URL(string: customerPhotoUrl), placeholderImage: nil)
        }

        if let postCount = customerDetails?.postsCounter{
            btnPostCount.text = "\(postCount)"
        }
        
        if let followersCount = customerDetails?.followers{
            btnFollowersCount.setTitle("\(followersCount)", for: .normal)
        }
        
        if let following = customerDetails?.followings{
            btnFollowingCount.setTitle("\(following)", for: .normal)
        }
    }
    
    @IBAction func didTapOnFollow(_ sender: UIButton) {
        if isFollowSelected{
            isFollowSelected = false
            sender.setTitle("FOLLOW", for: .normal)
            sender.backgroundColor = UIColor.init(hexString: "#1DA1F2")
        } else{
            isFollowSelected = true
            sender.setTitle("UNFOLLOW", for: .normal)
            sender.backgroundColor = UIColor.lightGray
        }
    }
    
}

// MARK: - Load from storyboard with dependency
extension UserProfileVC {
    
    class func load(withDependency dependency: UserProfileDependency? = nil) -> UserProfileVC? {
        
        let storyboard = UIStoryboard(name: "UserProfile", bundle: nil)
        
        guard let vc = storyboard.instantiateViewController(withIdentifier: "UserProfileVC") as? UserProfileVC else {
            return nil
        }
        vc.dependency = dependency
        return vc
    }
}

// MARK: - UserProfileAPIResponseDelegate
extension UserProfileVC: UserProfileAPIResponseDelegate {
    func customerDetailSuccess(withData: CustomerDetailResponse) {
        AppActivityIndicator.hideActivityIndicator()
        customerDetails = withData.customerDetails
        if customerDetails != nil{
            setDataToView()
        }
    }
    
    func userPostListSuccess(withData: UserPostListResponse) {
        customerPostList = withData.customerPostList ?? []
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

extension UserProfileVC: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return customerPostList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "SearchPostCVC", for: indexPath) as! SearchPostCVC
        let postData = customerPostList[indexPath.row]
        
        if let postImageUrl = postData.postImage{
            cell.imgViewUserPost.sd_setImage(with:  URL(string: postImageUrl), placeholderImage: nil)
        }
        return cell
    }
}

extension UserProfileVC: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let vc = TagedPhotosVC.load(withDependency: nil) else{
            return
        }
        vc.headerTitle = "Posts"
        self.navigationController?.pushViewController(vc, animated: true)
    }
}

extension UserProfileVC: UITabBarDelegate {
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

