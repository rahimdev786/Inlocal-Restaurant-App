//
//  SavedPostsVC.swift
//  InLocalCustomer
//
//  Created by Sajib Ghosh on 07/06/21.
//  Copyright © 2021 ___ORGANIZATIONNAME___. All rights reserved.
//
//

import UIKit

class SavedPostsVC: UIViewController {
    // MARK: Instance variables
	lazy var dataManager = SavedPostsDataManager()
    var dependency: SavedPostsDependency?
    
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var segmentedControl: UISegmentedControl!
    
    var favoritePostList = [FavoritePostList]()
    
    // MARK: - View Life Cycle Methods
	override func viewDidLoad() {
        super.viewDidLoad()
        dataManager.apiResponseDelegate = self
        
        
        if #available(iOS 13.0, *){
            let titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
            UISegmentedControl.appearance().setTitleTextAttributes(titleTextAttributes, for: .selected)
            UISegmentedControl.appearance().setTitleTextAttributes(titleTextAttributes, for: .normal)
        }else{

            segmentedControl.tintColor = UIColor(hexString: "1DA1F2")
            segmentedControl.setTitleTextAttributes([NSAttributedString.Key.foregroundColor: UIColor.white], for: UIControl.State.selected)
            segmentedControl.setTitleTextAttributes([NSAttributedString.Key.foregroundColor: UIColor.white], for: UIControl.State.normal)
            segmentedControl.backgroundColor = UIColor(hexString: "333333")
            segmentedControl.layer.cornerRadius = 4
        }
        
        AppActivityIndicator.showActivityIndicator(displayStyle: .dark, displayMessage: "", showInView: self.view)
        dataManager.getSavedPostCall(skip: 0, limit: 10, loginUserType: "Customer")
    }
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
//        let titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
//        UISegmentedControl.appearance().setTitleTextAttributes(titleTextAttributes, for: .selected)
//        UISegmentedControl.appearance().setTitleTextAttributes(titleTextAttributes, for: .normal)
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
    
    @IBAction func didTapOnBack(_ sender: UIButton) {
        navigationController?.popViewController(animated: true)
    }
    
    @IBAction func chageTab(_ sender: UISegmentedControl) {
        if sender.selectedSegmentIndex == 0{
            
            AppActivityIndicator.showActivityIndicator(displayStyle: .dark, displayMessage: "", showInView: self.view)
            dataManager.getSavedPostCall(skip: 0, limit: 10, loginUserType: "Customer")
        } else{
            
            AppActivityIndicator.showActivityIndicator(displayStyle: .dark, displayMessage: "", showInView: self.view)
            dataManager.getSavedPostCall(skip: 0, limit: 10, loginUserType: "Restaurant")
        }
    }
    
}

// MARK: - Load from storyboard with dependency
extension SavedPostsVC {
    class func loadFromXIB(withDependency dependency: SavedPostsDependency? = nil) -> SavedPostsVC? {
        let storyboard = UIStoryboard(name: "SavedPosts", bundle: nil)
        guard let viewController = storyboard.instantiateViewController(withIdentifier: "SavedPostsVC") as? SavedPostsVC else {
            return nil
        }
        viewController.dependency = dependency
        return viewController
    }
}

// MARK: - SavedPostsAPIResponseDelegate
extension SavedPostsVC: SavedPostsAPIResponseDelegate {
    func getSavedPostSuccess(withData: SavedPostResponse) {
        AppActivityIndicator.hideActivityIndicator()
        favoritePostList.removeAll()
        favoritePostList = withData.favoritePostList ?? []
        collectionView.reloadData()
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

extension SavedPostsVC:UICollectionViewDataSource, UICollectionViewDelegateFlowLayout,UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return favoritePostList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let item = collectionView.dequeueReusableCell(withReuseIdentifier: FavouriteCVC.identifier, for: indexPath) as! FavouriteCVC
        let postData = favoritePostList[indexPath.row]
        if let postPhotoUrl = postData.image{
            item.imageViewPost.sd_setImage(with:  URL(string: postPhotoUrl), placeholderImage: #imageLiteral(resourceName: "feedwall_post_image"))
        }
        return item
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let width = collectionView.frame.size.width/2 - 4.0
        let size = CGSize(width: width, height: width)
        return size
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let vc = TagedPhotosVC.load(withDependency: nil) else{
            return
        }
        vc.headerTitle = "Posts"
        self.navigationController?.pushViewController(vc, animated: true)
    }
}
