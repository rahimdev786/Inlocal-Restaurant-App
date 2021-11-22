//
//  CommentVC.swift
//  InLocalCustomer
//
//  Created by Sudipta Patel on 08/06/21.
//  Copyright © 2021 ___ORGANIZATIONNAME___. All rights reserved.
//
//

import UIKit

class CommentVC: UIViewController {
    
    // MARK: Instance variables
	lazy var dataManager = CommentDataManager()
    var dependency: CommentDependency?
    
    
    @IBOutlet weak var imageViewPost: UIImageView!
    @IBOutlet weak var lblDetails: UILabel!
    @IBOutlet weak var lblRestaurantName: UILabel!
    @IBOutlet weak var buttonRestarantImage: UIButton!
    @IBOutlet weak var tableViewComment: UITableView!
    @IBOutlet weak var viewMenuBack: UIView!
    @IBOutlet weak var lblLike: UILabel!
    @IBOutlet weak var buttonLike: UIButton!
    
    @IBOutlet weak var viewCommentBack: UIView!
    @IBOutlet weak var tableViewComment_Height: NSLayoutConstraint!
    
    @IBOutlet weak var widthMenuView: NSLayoutConstraint!
    @IBOutlet weak var imgViewPost: UIImageView!
    @IBOutlet weak var widthStackView: NSLayoutConstraint!
    @IBOutlet weak var lblDescription: UILabel!
    
    @IBOutlet weak var txtFieldComment: UITextField!
    @IBOutlet weak var scollViewComment: UIScrollView!
    
    var isLiked = false
    var isMenuOpen = false
    var isFavorite = false
    
    var commentList : CommentList?
    var comments = [Comments]()
    var commentRequest = CommentRequest()
    
    // MARK: - View Life Cycle Methods
	override func viewDidLoad() {
        super.viewDidLoad()
        
        dataManager.apiResponseDelegate = self
        setupView()
        
        AppActivityIndicator.showActivityIndicator(displayStyle: .dark, displayMessage: "", showInView: self.view)
        guard let postId = dependency?.postId else{
            return
        }
        dataManager.commentListCall(skip: 0, limit: 10, postId: postId)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.tableViewComment.addObserver(self, forKeyPath: "contentSize", options: .new, context: nil)
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.tableViewComment.removeObserver(self, forKeyPath: "contentSize")
    }
    
    // MARK: Deinitialization
    deinit {
       debugPrint("\(self) deinitialized")
    }
    
    @IBAction func onClickBack(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func onClickRestaurant(_ sender: Any) {
        guard let vc = RestaurantProfileVC.load(withDependency: nil) else{
            return
        }
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    @IBAction func onClickMenu(_ sender: Any) {
        guard let vc = MenuDetailVC.load(withDependency: nil) else{
            return
        }
        vc.pageType = .menu
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    @IBAction func onClickSavedPost(_ sender: UIButton) {
        if isFavorite{
            isFavorite = false
            sender.setImage(#imageLiteral(resourceName: "favorite_white"), for: .normal)
        } else{
            isFavorite = true
            sender.setImage(#imageLiteral(resourceName: "favrite_blue"), for: .normal)
        }
    }
    
    @IBAction func onClickLike(_ sender: UIButton) {
        if isLiked{
            isLiked = false
            sender.setImage(#imageLiteral(resourceName: "like_empty_white"), for: .normal)
        } else{
            isLiked = true
            sender.setImage(#imageLiteral(resourceName: "like_filled"), for: .normal)
        }
    }
    
    @IBAction func clickOnAddComment(_ sender: Any) {
        commentRequest.comment = txtFieldComment.text!
        guard let message = commentRequest.comment else{
            return
        }
        if message != ""{
            AppActivityIndicator.showActivityIndicator(displayStyle: .dark, displayMessage: "", showInView: self.view)
            dataManager.addCommentCall(postId: 1, message: message)
        }
    }
    
    func setupView(){
        
        imageViewPost.roundCorners([.layerMinXMinYCorner, .layerMaxXMinYCorner], radius: 20)
        viewMenuBack.roundCorners([.layerMinXMinYCorner, .layerMinXMaxYCorner], radius: 20.0)
        //lblLike.roundCorners([.layerMinXMinYCorner, .layerMinXMaxYCorner, .layerMaxXMinYCorner, .layerMinXMinYCorner], radius: lblLike.frame.height/2)
        lblLike.layer.cornerRadius = lblLike.frame.height / 2
        lblLike.layer.masksToBounds = true
        
        viewCommentBack.applyLightShadow()
        
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(imageTapped(tapGestureRecognizer:)))
        imgViewPost.isUserInteractionEnabled = true
        imgViewPost.addGestureRecognizer(tapGestureRecognizer)
        
        if isMenuOpen{
            self.widthMenuView.constant = 54
            self.widthStackView.constant = 38
            self.lblDescription.numberOfLines = 5
        } else{
            self.widthMenuView.constant = 0
            self.widthStackView.constant = 0
            self.lblDescription.numberOfLines = 2
        }
        
        scollViewComment.delegate = self
    }
    
    func setDataToView(){
        lblDetails.text = commentList?.message
        //lblRestaurantName.text = commentList.
        if let likeCountValue = commentList?.likeCounter{
            lblLike.text = "\(likeCountValue)"
        }
        if let postImageURL = commentList?.postImage{
            imageViewPost.sd_setImage(with:  URL(string: postImageURL), placeholderImage: nil)
        }
    }
    
    @objc func imageTapped(tapGestureRecognizer: UITapGestureRecognizer){
        //let tappedImage = tapGestureRecognizer.view as! UIImageView
        // Your action
        if isMenuOpen{
            UIView.animate(withDuration: 0.3) {
                self.widthMenuView.constant = 0
                self.widthStackView.constant = 0
                self.lblDescription.numberOfLines = 2
                self.view.layoutIfNeeded()
            } completion: { [self] (state) in
                isMenuOpen = false
            }
        } else{
            UIView.animate(withDuration: 0.3) {
                self.widthMenuView.constant = 54
                self.widthStackView.constant = 38
                self.lblDescription.numberOfLines = 5
                self.view.layoutIfNeeded()
            } completion: { [self] (state) in
                isMenuOpen = true
            }
        }
    }
    
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        if keyPath == "contentSize"{
            if object is UITableView{
                if let newvalue = change?[.newKey]{
                    let newsize = newvalue as! CGSize
                    self.tableViewComment_Height.constant = newsize.height
                }
            }
        }
    }
}

// MARK: - Load from storyboard with dependency
extension CommentVC {
    
    class func load(withDependency dependency: CommentDependency? = nil) -> CommentVC? {
        
        let storyboard = UIStoryboard(name: "Comment", bundle: nil)
        
        guard let vc = storyboard.instantiateViewController(withIdentifier: "CommentVC") as? CommentVC else {
            return nil
        }
        vc.dependency = dependency
        return vc
    }
}

// MARK: - CommentAPIResponseDelegate
extension CommentVC: CommentAPIResponseDelegate {
    func addCommentSuccess(withData: EmptyResponse?) {
        txtFieldComment.text = ""
        dataManager.commentListCall(skip: 0, limit: 10, postId: 1)
    }
    
    func commentListSuccess(withData: CommentListResponse) {
        AppActivityIndicator.hideActivityIndicator()
        commentList = withData.commentList
        comments = withData.commentList?.comments ?? []
        setDataToView()
        tableViewComment.reloadData()
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

extension CommentVC: UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return comments.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CommentTVC", for: indexPath) as! CommentTVC
        let commentData = comments[indexPath.row]
        cell.lblName.text = commentData.name
        cell.lblDetails.text = commentData.message
        if let userImageURL = commentData.userProfileImage{
            cell.imageViewUser.sd_setImage(with:  URL(string: userImageURL), placeholderImage: nil)
        }
        
        return cell
    }

}

extension CommentVC: UIScrollViewDelegate {
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        if isMenuOpen{
            UIView.animate(withDuration: 0.3) {
                self.widthMenuView.constant = 0
                self.widthStackView.constant = 0
                self.lblDescription.numberOfLines = 2
                self.view.layoutIfNeeded()
            } completion: { [self] (state) in
                isMenuOpen = false
            }
        }
    }
}
