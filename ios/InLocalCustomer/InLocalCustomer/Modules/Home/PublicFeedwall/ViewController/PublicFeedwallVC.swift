//
//  PublicFeedwallVC.swift
//  InLocalCustomer
//
//  Created by Sudipta Patel on 03/06/21.
//  Copyright © 2021 ___ORGANIZATIONNAME___. All rights reserved.
//
//

import UIKit

class PublicFeedwallVC: UIViewController {
    
    // MARK: Instance variables
	lazy var dataManager = PublicFeedwallDataManager()
    var dependency: PublicFeedwallDependency?
    
    @IBOutlet weak var collectionViewStories: UICollectionView!
    @IBOutlet weak var tableViewPost: UITableView!
    
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
    
}

extension PublicFeedwallVC: UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 6
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "FeedwallStoryCVC", for: indexPath) as! FeedwallStoryCVC
        return cell
    }
    
}

extension PublicFeedwallVC: UICollectionViewDelegate{
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let viewStoryController = ViewStoryVC.load(withDependency: nil) else{
            return
        }
        self.navigationController?.pushViewController(viewStoryController, animated: true)
    }
}

extension PublicFeedwallVC: UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "FeedwallPostTVC", for: indexPath) as! FeedwallPostTVC
        return cell
    }

}
