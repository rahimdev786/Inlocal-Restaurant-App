//
//  ViewStoryVC.swift
//  InLocalCustomer
//
//  Created by Sudipta Patel on 03/06/21.
//  Copyright © 2021 ___ORGANIZATIONNAME___. All rights reserved.
//
//

import UIKit

class ViewStoryVC: UIViewController {
    
    // MARK: Instance variables
	lazy var dataManager = ViewStoryDataManager()
    var dependency: ViewStoryDependency?
    
    @IBOutlet weak var collectionViewStory: UICollectionView!
    
    // MARK: - View Life Cycle Methods
	override func viewDidLoad() {
        super.viewDidLoad()
        
        dataManager.apiResponseDelegate = self
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
    
    @IBAction func onClickBackButton(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func onClickMenu(_ sender: Any) {
    }
    
    @IBAction func onClickClose(_ sender: Any) {
        
    }
    
    @IBAction func onClickUserPhoto(_ sender: Any) {
        guard let vc = UserProfileVC.load(withDependency: nil) else{
            return
        }
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    @IBAction func onClickRestaurentPhoto(_ sender: Any) {
        guard let vc = RestaurantProfileVC.load(withDependency: nil) else{
            return
        }
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
}

// MARK: - Load from storyboard with dependency
extension ViewStoryVC {
    
    class func load(withDependency dependency: ViewStoryDependency? = nil) -> ViewStoryVC? {
        
        let storyboard = UIStoryboard(name: "ViewStory", bundle: nil)
        
        guard let vc = storyboard.instantiateViewController(withIdentifier: "ViewStoryVC") as? ViewStoryVC else {
            return nil
        }
        vc.dependency = dependency
        return vc
    }
}

// MARK: - ViewStoryAPIResponseDelegate
extension ViewStoryVC: ViewStoryAPIResponseDelegate {
    
}

extension ViewStoryVC: UICollectionViewDataSource{
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 3
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ViewStoryCVC", for: indexPath) as! ViewStoryCVC
        return cell
    }
    
}
