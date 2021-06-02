//
//  NotificationsVC.swift
//  InLocalCustomer
//
//  Created by Sudipta Patel on 02/06/21.
//  Copyright © 2021 ___ORGANIZATIONNAME___. All rights reserved.
//
//

import UIKit

class NotificationsVC: UIViewController {
    
    // MARK: Instance variables
	lazy var dataManager = NotificationsDataManager()
    var dependency: NotificationsDependency?
    
    
    @IBOutlet weak var tableViewNotification: UITableView!
    
    
    // MARK: - View Life Cycle Methods
	override func viewDidLoad() {
        super.viewDidLoad()
        
        dataManager.apiResponseDelegate = self
        setupUI()
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
    
    func setupUI() {
        tableViewNotification.estimatedRowHeight = 100
        tableViewNotification.rowHeight = UITableView.automaticDimension
    }
}

// MARK: - Load from storyboard with dependency
extension NotificationsVC {
    
    class func load(withDependency dependency: NotificationsDependency? = nil) -> NotificationsVC? {
        
        let storyboard = UIStoryboard(name: "Notifications", bundle: nil)
        
        guard let vc = storyboard.instantiateViewController(withIdentifier: "NotificationsVC") as? NotificationsVC else {
            return nil
        }
        vc.dependency = dependency
        return vc
    }
}

// MARK: - NotificationsAPIResponseDelegate
extension NotificationsVC: NotificationsAPIResponseDelegate {
    
}

extension NotificationsVC: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "NotificationTVC", for: indexPath) as! NotificationTVC
        return cell
    }
    
}

