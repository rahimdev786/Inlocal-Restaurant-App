//
//  TagedPhotosVC.swift
//  InLocalCustomer
//
//  Created by Sudipta Patel on 04/06/21.
//  Copyright © 2021 ___ORGANIZATIONNAME___. All rights reserved.
//
//

import UIKit

class TagedPhotosVC: UIViewController {
    
    // MARK: Instance variables
	lazy var dataManager = TagedPhotosDataManager()
    var dependency: TagedPhotosDependency?
    
    @IBOutlet weak var tableViewPosts: UITableView!
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var tableViewPostHeight: NSLayoutConstraint!
    
    @IBOutlet weak var tabBar: UITabBar!
    @IBOutlet weak var tabItemHome: UITabBarItem!
    @IBOutlet weak var tabItemSearch: UITabBarItem!
    @IBOutlet weak var tabItemAddPost: UITabBarItem!
    @IBOutlet weak var tabItemCart: UITabBarItem!
    @IBOutlet weak var tabItemNotification: UITabBarItem!
    
    @IBOutlet weak var scollViewTaggedPhoto: UIScrollView!
    
    var headerTitle = "Taged photos"
    var customerAllPostList = [CustomerAllPostList]()
    
    // MARK: - View Life Cycle Methods
	override func viewDidLoad() {
        super.viewDidLoad()
        
        dataManager.apiResponseDelegate = self
        setView()
        AppActivityIndicator.showActivityIndicator(displayStyle: .dark, displayMessage: "", showInView: self.view)
        dataManager.customerPostListCall(skip: 0, limit: 10, customerId: 10)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.tableViewPosts.addObserver(self, forKeyPath: "contentSize", options: .new, context: nil)
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.tableViewPosts.removeObserver(self, forKeyPath: "contentSize")
    }
    
    // MARK: Deinitialization
    deinit {
       debugPrint("\(self) deinitialized")
    }
    
    @IBAction func onClickBack(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func didTapOnMore(_ sender: UIButton) {
        
        openActionSheet()
    }
    
    func openActionSheet(){
        let alertController = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
    
        let action0 = UIAlertAction(title: "Report", style: .default) { (action) in
            
        }
        action0.setValue(UIColor.black, forKey: "titleTextColor")
        
        let action1 = UIAlertAction(title: "Share", style: .default) { (action) in
            
        }
        action1.setValue(UIColor.black, forKey: "titleTextColor")
        
        let action2 = UIAlertAction(title: "Cancel", style: .default) { (action) in
            
        }
        action2.setValue(UIColor.black, forKey: "titleTextColor")
        
        alertController.addAction(action0)
        alertController.addAction(action1)
        alertController.addAction(action2)
        self.present(alertController, animated: true, completion: nil)
    }
    
    func setView(){
        lblTitle.text = headerTitle
        tabBar.delegate = self
        tabBar.unselectedItemTintColor = .white
        
        scollViewTaggedPhoto.delegate = self
    }
    
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        if keyPath == "contentSize"{
            if object is UITableView{
                if let newvalue = change?[.newKey]{
                    let newsize = newvalue as! CGSize
                    self.tableViewPostHeight.constant = newsize.height
                }
            }
        }
    }

}

// MARK: - Load from storyboard with dependency
extension TagedPhotosVC {
    
    class func load(withDependency dependency: TagedPhotosDependency? = nil) -> TagedPhotosVC? {
        
        let storyboard = UIStoryboard(name: "TagedPhotos", bundle: nil)
        
        guard let vc = storyboard.instantiateViewController(withIdentifier: "TagedPhotosVC") as? TagedPhotosVC else {
            return nil
        }
        vc.dependency = dependency
        return vc
    }
}

// MARK: - TagedPhotosAPIResponseDelegate
extension TagedPhotosVC: TagedPhotosAPIResponseDelegate {
    func customerPostListSuccess(withData: CustomerPostListResponse) {
        AppActivityIndicator.hideActivityIndicator()
        customerAllPostList = withData.customerPostList ?? []
        tableViewPosts.reloadData()
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
//TagedPhotoTVC
extension TagedPhotosVC: UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return customerAllPostList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TagedPhotoTVC", for: indexPath) as! TagedPhotoTVC
        
        let postData = customerAllPostList[indexPath.row]
        
        cell.lblDescription.text = postData.message
        cell.lblLikeCount.text = "\(postData.likeCounter!)"
        if let photoUrl = postData.postImage{
            cell.imgViewPost.sd_setImage(with:  URL(string: photoUrl), placeholderImage: #imageLiteral(resourceName: "feedwall_post_image"))
        }

        if let photoUrl = postData.restaurantImg{
            cell.btnRestaurent.sd_setImage(with: URL(string: photoUrl), for: UIControl.State.normal) { (image, error, catche, rul) in
            }
        }
        
        if postData.isLiked!{
            cell.btnLike.setImage(#imageLiteral(resourceName: "like_filled"), for: .normal)
        } else{
            cell.btnLike.setImage(#imageLiteral(resourceName: "like_empty_white"), for: .normal)
        }
        
        cell.btnRestaurent.addTarget(self, action: #selector(onClickRestaurent(sender:)), for: .touchUpInside)
        cell.btnRestaurent.tag = indexPath.row
        
        cell.btnMenu.addTarget(self, action: #selector(onClickMenu(sender:)), for: .touchUpInside)
        cell.btnMenu.tag = indexPath.row
        
        cell.btnSavedPost.addTarget(self, action: #selector(onClickSavedPost(sender:)), for: .touchUpInside)
        cell.btnSavedPost.tag = indexPath.row
        
        cell.btnComment.addTarget(self, action: #selector(onClickComment(sender:)), for: .touchUpInside)
        cell.btnComment.tag = indexPath.row
        return cell
    }

}

extension TagedPhotosVC {
    
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
    
    @objc func onClickSavedPost(sender: UIButton){
    }
    
    @objc func onClickComment(sender: UIButton){
        let buttonTag = sender.tag
        guard let viewStoryController = CommentVC.load(withDependency: nil) else{
            return
        }
        self.navigationController?.pushViewController(viewStoryController, animated: true)
    }
}

extension TagedPhotosVC: UITabBarDelegate {
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

extension TagedPhotosVC: UIScrollViewDelegate {
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: "closeSideBarOfTaggedPhoto"), object: nil)
    }
    
}
