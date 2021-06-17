//
//  FollowerVC.swift
//  InLocalCustomer
//
//  Created by Sajib Ghosh on 09/06/21.
//  Copyright © 2021 ___ORGANIZATIONNAME___. All rights reserved.
//
//

import UIKit

enum UserType {
    case followers
    case following
}

class FollowerVC: UIViewController {
    // MARK: Instance variables
	lazy var dataManager = FollowerDataManager()
    var dependency: FollowerDependency?
    
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var tableView: UITableView!
    
    var type: UserType = .followers
    
    var numberOfItems = 10
    
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
    
    @IBAction func didTapOnSegmentedControl(_ sender: UISegmentedControl) {
        
        if sender.selectedSegmentIndex == 0 {
            type = .followers
            lblTitle.text = "Followers"
        }else{
            type = .following
            lblTitle.text = "Following"
        }
        
        tableView.reloadData()
    }
    
    @IBAction func onClickBack(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
}

// MARK: - Load from storyboard with dependency
extension FollowerVC {
    class func loadFromXIB(withDependency dependency: FollowerDependency? = nil) -> FollowerVC? {
        let storyboard = UIStoryboard(name: "Follower", bundle: nil)
        guard let viewController = storyboard.instantiateViewController(withIdentifier: "FollowerVC") as? FollowerVC else {
            return nil
        }
        viewController.dependency = dependency
        return viewController
    }
}

// MARK: - FollowerAPIResponseDelegate
extension FollowerVC: FollowerAPIResponseDelegate {
}

//MARK: UITableViewDataSource
extension FollowerVC: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return numberOfItems
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if type == .followers {
            let cell = tableView.dequeueReusableCell(withIdentifier: FollowerTVC.identifier, for: indexPath) as! FollowerTVC
            cell.delegate = self
            return cell
        }else{
            let cell = tableView.dequeueReusableCell(withIdentifier: FollowingTVC.identifier, for: indexPath) as! FollowingTVC
            return cell
        }
        
        
    }
    
}

extension FollowerVC: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 87.0
    }
}
extension FollowerVC: FollowerTVCProtocol{
    
    func didTapOnCross() {
        
        let alertCntlr = UIAlertController.init(title: "Alert", message: "Do you want to remove this follower", preferredStyle: .alert)
        let cancelAction = UIAlertAction.init(title: "No", style: .cancel) { _ in
            
        }
        let okAction = UIAlertAction.init(title: "OK", style: .default) { _ in
            self.numberOfItems = self.numberOfItems - 1
            self.tableView.reloadData()
        }
        
        alertCntlr.addAction(cancelAction)
        alertCntlr.addAction(okAction)
        self.present(alertCntlr, animated: true, completion: nil)
    }
}
