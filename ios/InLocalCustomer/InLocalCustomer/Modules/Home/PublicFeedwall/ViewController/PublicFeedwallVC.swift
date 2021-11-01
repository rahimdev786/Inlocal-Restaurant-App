//
//  PublicFeedwallVC.swift
//  InLocalCustomer
//
//  Created by Sudipta Patel on 03/06/21.
//  Copyright © 2021 ___ORGANIZATIONNAME___. All rights reserved.
//
//

import UIKit
import SDWebImage

class PublicFeedwallVC: UIViewController {
    
    // MARK: Instance variables
	lazy var dataManager = PublicFeedwallDataManager()
    var dependency: PublicFeedwallDependency?
    var feedwallListing = [FeedwallListing]()
    var myFeedWallStories = [MyFeedWallStories]()
    

    @IBOutlet weak var collectionViewStories: UICollectionView!
    @IBOutlet weak var tableViewPost: UITableView!
    
    @IBOutlet weak var btnUserName: UIButton!
    @IBOutlet weak var btnUserProfileImage: UIButton!
    @IBOutlet weak var tableViewPost_Height: NSLayoutConstraint!
    @IBOutlet weak var scollViewFeedwall: UIScrollView!
    
    // MARK: - View Life Cycle Methods
	override func viewDidLoad() {
        super.viewDidLoad()
        
        dataManager.apiResponseDelegate = self
        scollViewFeedwall.delegate = self
        
        setData()
        
        dataManager.storyFeedwallListCall(skip: 0, limit: 10)
        
        AppActivityIndicator.showActivityIndicator(displayStyle: .dark, displayMessage: "", showInView: self.view)
        dataManager.feedwallListCall(skip: 0, limit: 10)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.tableViewPost.addObserver(self, forKeyPath: "contentSize", options: .new, context: nil)
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.tableViewPost.removeObserver(self, forKeyPath: "contentSize")
    }
    
    // MARK: Deinitialization
    deinit {
       debugPrint("\(self) deinitialized")
    }
    
    @IBAction func didTapOnProfile(_ sender: UIButton) {
        
        guard let vc = ProfileInfoVC.loadFromXIB() else {
            return
        }
        navigationController?.pushViewController(vc, animated: true)
    }
    
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        if keyPath == "contentSize"{
            if object is UITableView{
                if let newvalue = change?[.newKey]{
                    let newsize = newvalue as! CGSize
                    self.tableViewPost_Height.constant = newsize.height
                }
            }
        }
    }
    
    func setData(){
        var user: User? {
            return IEUserDefaults.shared.userDetails
        }
        
        btnUserProfileImage.imageView?.layer.cornerRadius = btnUserProfileImage.frame.height/2
        if let photoUrl = user?.personalInfo?.profilePicture{
            btnUserProfileImage.sd_setImage(with: URL(string: photoUrl), for: UIControl.State.normal) { (image, error, catche, rul) in
            }
        }
        
        if let userName = user?.personalInfo?.fullname{
            btnUserName.setTitle(userName, for: .normal)
        }
    } 
}

// MARK: - Load from storyboard with dependency
extension PublicFeedwallVC {
    
    class func load(withDependency dependency: PublicFeedwallDependency? = nil) -> PublicFeedwallVC? {
        
        let storyboard = UIStoryboard(name: "PublicFeedwall", bundle: nil)
        
        guard let vc = storyboard.instantiateViewController(withIdentifier: "PublicFeedwallVC") as? PublicFeedwallVC else {
            return nil
        }
        vc.dependency = dependency
        return vc
    }
}

// MARK: - PublicFeedwallAPIResponseDelegate
extension PublicFeedwallVC: PublicFeedwallAPIResponseDelegate {
    
    func postSaveSuccess(withData: EmptyResponse?) {
        AppActivityIndicator.hideActivityIndicator()
    }
    
    func storyFeedListSuccess(withData: StoryFeedwallListResponse) {
        myFeedWallStories = withData.myFeedWallStories ?? []
        collectionViewStories.reloadData()
    }
    
    func feedListSuccess(withData: FeedWallListResponse) {
        AppActivityIndicator.hideActivityIndicator()
        feedwallListing = withData.feedWallListing ?? []
        tableViewPost.reloadData()
    }
    
    func postLikeSuccess(withData: EmptyResponse?) {
        AppActivityIndicator.hideActivityIndicator()
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

extension PublicFeedwallVC: UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return myFeedWallStories.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "FeedwallStoryCVC", for: indexPath) as! FeedwallStoryCVC
        let storyData = myFeedWallStories[indexPath.row]
        cell.lblName.text = storyData.name
        if let storyImageUrl = storyData.storyImage{
            cell.imageViewStory.sd_setImage(with:  URL(string: storyImageUrl), placeholderImage: nil)
        }
        return cell
    }
}

extension PublicFeedwallVC: UICollectionViewDelegate{
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        guard let viewStoryController = ViewStoryVC.load(withDependency: nil) else{
            return
        }
        viewStoryController.myFeedWallStories = myFeedWallStories[indexPath.row]
        self.navigationController?.pushViewController(viewStoryController, animated: true)
        
    }
    
}

extension PublicFeedwallVC: UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return feedwallListing.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "FeedwallPostTVC", for: indexPath) as! FeedwallPostTVC
        
        let feedData = feedwallListing[indexPath.row]
        
        cell.lblDescription.text = feedData.message
        cell.lblLikeCount.text = "\(feedData.likeCounter!)"
        if let photoUrl = feedData.postImage{
            cell.imgViewPost.sd_setImage(with:  URL(string: photoUrl), placeholderImage: #imageLiteral(resourceName: "feedwall_post_image"))
        }

        cell.btnUserName.setTitle(feedData.name, for: .normal)
        if let photoUrl = feedData.profileImage{
            cell.btnUserProfile.sd_setImage(with: URL(string: photoUrl), for: UIControl.State.normal) { (image, error, catche, rul) in
            }
        }
        
        if let photoUrl = feedData.restaurantImg{
            cell.btnRestaurent.sd_setImage(with: URL(string: photoUrl), for: UIControl.State.normal) { (image, error, catche, rul) in
            }
        }
        
        if feedData.isLiked!{
            cell.btnLike.setImage(#imageLiteral(resourceName: "like_filled"), for: .normal)
        } else{
            cell.btnLike.setImage(#imageLiteral(resourceName: "like_empty_white"), for: .normal)
        }
        
        cell.btnLike.addTarget(self, action: #selector(onClickLike(sender:)), for: .touchUpInside)
        cell.btnLike.tag = indexPath.row
        
        cell.btnSavedPost.addTarget(self, action: #selector(onClickSavePost(sender:)), for: .touchUpInside)
        cell.btnSavedPost.tag = indexPath.row
        
        cell.btnUserProfile.addTarget(self, action: #selector(onUserProfile(sender:)), for: .touchUpInside)
        cell.btnUserProfile.tag = indexPath.row
        
        cell.btnUserName.addTarget(self, action: #selector(onUserProfile(sender:)), for: .touchUpInside)
        cell.btnUserName.tag = indexPath.row
        
        cell.btnRestaurent.addTarget(self, action: #selector(onClickRestaurent(sender:)), for: .touchUpInside)
        cell.btnRestaurent.tag = indexPath.row
        
        cell.btnMenu.addTarget(self, action: #selector(onClickMenu(sender:)), for: .touchUpInside)
        cell.btnMenu.tag = indexPath.row
            
        cell.btnComment.addTarget(self, action: #selector(onClickComment(sender:)), for: .touchUpInside)
        cell.btnComment.tag = indexPath.row
        return cell
    }

}

extension PublicFeedwallVC {
    @objc func onClickLike(sender: UIButton){
        let buttonTag = sender.tag
        var postData = feedwallListing[buttonTag]
        
        if !postData.isLiked!{
            feedwallListing[buttonTag].isLiked = true
            guard let postId = postData.postId else {
                return
            }
            AppActivityIndicator.showActivityIndicator(displayStyle: .dark, displayMessage: "", showInView: self.view)
            dataManager.postLikeCall(id: postId, likeStatus: "Like")
        }
    }

    @objc func onClickSavePost(sender: UIButton){
        let buttonTag = sender.tag
        var postData = feedwallListing[buttonTag]
        if !postData.isFavorite!{
            feedwallListing[buttonTag].isLiked = true
            guard let postId = postData.postId else {
                return
            }
            AppActivityIndicator.showActivityIndicator(displayStyle: .dark, displayMessage: "", showInView: self.view)
            dataManager.postSaveCall(id: postId, favoriteStatus: "Favorite")
        }
    }
    
    
    @objc func onUserProfile(sender: UIButton){
        let buttonTag = sender.tag
        guard let vc = UserProfileVC.load(withDependency: nil) else{
            return
        }
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    @objc func onClickRestaurent(sender: UIButton){
        let buttonTag = sender.tag
        guard let vc = RestaurantProfileVC.load(withDependency: nil) else{
            return
        }
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    @objc func onClickMenu(sender: UIButton){
        guard let vc = MenuDetailVC.load(withDependency: nil) else{
            return
        }
        vc.pageType = .menu
        self.navigationController?.pushViewController(vc, animated: true)
        
    }
    
    @objc func onClickComment(sender: UIButton){
        guard let viewStoryController = CommentVC.load(withDependency: nil) else{
            return
        }
        self.navigationController?.pushViewController(viewStoryController, animated: true)
    }
}

extension PublicFeedwallVC: UIScrollViewDelegate {
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        print("Scrolling")
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: "closeSideBarOfFeedwall"), object: nil)
    }
    
}
