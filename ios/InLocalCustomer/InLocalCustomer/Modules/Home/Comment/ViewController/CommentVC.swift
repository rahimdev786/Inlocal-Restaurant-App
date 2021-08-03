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
    
    @IBOutlet weak var tableViewComment: UITableView!
    @IBOutlet weak var viewMenuBack: UIView!
    @IBOutlet weak var lblLike: UILabel!
    
    @IBOutlet weak var viewCommentBack: UIView!
    @IBOutlet weak var tableViewComment_Height: NSLayoutConstraint!
    
    @IBOutlet weak var widthMenuView: NSLayoutConstraint!
    @IBOutlet weak var imgViewPost: UIImageView!
    @IBOutlet weak var widthStackView: NSLayoutConstraint!
    @IBOutlet weak var lblDescription: UILabel!
    
    @IBOutlet weak var scollViewComment: UIScrollView!
    
    var isLiked = false
    var isMenuOpen = false
    var isFavorite = false
    // MARK: - View Life Cycle Methods
	override func viewDidLoad() {
        super.viewDidLoad()
        
        dataManager.apiResponseDelegate = self
        setupView()
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
    
    func setupView(){
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
    
}

extension CommentVC: UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CommentTVC", for: indexPath) as! CommentTVC
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
