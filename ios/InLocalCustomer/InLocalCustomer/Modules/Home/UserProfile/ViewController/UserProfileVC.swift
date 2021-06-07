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
    
    @IBOutlet weak var viewProfileImageBack: UIView!
    @IBOutlet weak var collectionViewPost: UICollectionView!
    
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
    @IBAction func onClickBack(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    func setupView(){
        viewProfileImageBack.roundCorners([.layerMinXMinYCorner, .layerMaxXMinYCorner], radius: 20)
        
        let widthValue = ((UIScreen.main.bounds.width-44)/2)
        let heightValue = widthValue
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: widthValue, height: heightValue)
        self.collectionViewPost.setCollectionViewLayout(layout, animated: true)
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
    
}

extension UserProfileVC: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 6
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "SearchPostCVC", for: indexPath) as! SearchPostCVC
        return cell
    }
}

extension UserProfileVC: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let vc = TagedPhotosVC.load(withDependency: nil) else{
            return
        }
        self.navigationController?.pushViewController(vc, animated: true)
    }
}
