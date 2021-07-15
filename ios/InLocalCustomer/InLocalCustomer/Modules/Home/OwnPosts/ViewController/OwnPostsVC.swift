//
//  OwnPostsVC.swift
//  InLocalCustomer
//
//  Created by Sudipta Patel on 05/07/21.
//  Copyright © 2021 ___ORGANIZATIONNAME___. All rights reserved.
//
//

import UIKit

class OwnPostsVC: UIViewController {
    
    // MARK: Instance variables
	lazy var dataManager = OwnPostsDataManager()
    var dependency: OwnPostsDependency?
    
    @IBOutlet weak var viewProfileImageBack: UIView!
    @IBOutlet weak var collectionViewPost: UICollectionView!
    
    @IBOutlet weak var collectionViewPost_height: NSLayoutConstraint!
    
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
    
    @IBAction func onClickOption(_ sender: Any) {
        let alertController = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        let action0 = UIAlertAction(title: "Share", style: .default) { (action) in
            
        }
        action0.setValue(UIColor.black, forKey: "titleTextColor")
        
        let action1 = UIAlertAction(title: "Cancel", style: .default) { (action) in
            
        }
        action1.setValue(UIColor.black, forKey: "titleTextColor")
        
        alertController.addAction(action0)
        alertController.addAction(action1)
        self.present(alertController, animated: true, completion: nil)
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
    
    @IBAction func onClickEditProfile(_ sender: Any) {
        //EditProfileVC
        guard let vc = EditProfileVC.loadFromXIB(withDependency: nil) else{
            return
        }
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    func setupView(){
        viewProfileImageBack.roundCorners([.layerMinXMinYCorner, .layerMaxXMinYCorner], radius: 20)
        //btnFollow.roundCorners([.layerMinXMinYCorner, .layerMaxXMinYCorner, .layerMinXMaxYCorner, .layerMaxXMaxYCorner], radius: btnFollow.frame.height/2)
       
        let widthValue = ((UIScreen.main.bounds.width-36)/2)
        let heightValue = widthValue
        let layout = UICollectionViewFlowLayout()
        layout.minimumInteritemSpacing = 2
        layout.minimumLineSpacing = 2
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
}

// MARK: - Load from storyboard with dependency
extension OwnPostsVC {
    
    class func load(withDependency dependency: OwnPostsDependency? = nil) -> OwnPostsVC? {
        
        let storyboard = UIStoryboard(name: "OwnPosts", bundle: nil)
        
        guard let vc = storyboard.instantiateViewController(withIdentifier: "OwnPostsVC") as? OwnPostsVC else {
            return nil
        }
        vc.dependency = dependency
        return vc
    }
}

// MARK: - OwnPostsAPIResponseDelegate
extension OwnPostsVC: OwnPostsAPIResponseDelegate {
    
}
extension OwnPostsVC: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 6
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "SearchPostCVC", for: indexPath) as! SearchPostCVC
        return cell
    }
}

extension OwnPostsVC: UICollectionViewDelegate {
    
    
}
