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
}


extension SavedPostsVC:UICollectionViewDataSource, UICollectionViewDelegateFlowLayout,UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 20
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let item = collectionView.dequeueReusableCell(withReuseIdentifier: FavouriteCVC.identifier, for: indexPath) as! FavouriteCVC
        return item
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let width = collectionView.frame.size.width/2 - 4.0
        let size = CGSize(width: width, height: width)
        return size
    }
}
