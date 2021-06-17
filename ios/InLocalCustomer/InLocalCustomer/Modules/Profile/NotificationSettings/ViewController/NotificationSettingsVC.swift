//
//  NotificationSettingsVC.swift
//  InLocalCustomer
//
//  Created by Sajib Ghosh on 02/06/21.
//  Copyright © 2021 ___ORGANIZATIONNAME___. All rights reserved.
//
//

import UIKit

class NotificationSettingsVC: UIViewController {
    // MARK: Instance variables
	lazy var dataManager = NotificationSettingsDataManager()
    var dependency: NotificationSettingsDependency?
    
    var arrSettings = ["Posts","Stories","Comments","Followers","Orders","Bookings","Payment"]
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
    
    @IBAction func didTapOnBack(_ sender: UIButton) {
        navigationController?.popViewController(animated: true)
    }
    
}

// MARK: - Load from storyboard with dependency
extension NotificationSettingsVC {
    class func loadFromXIB(withDependency dependency: NotificationSettingsDependency? = nil) -> NotificationSettingsVC? {
        let storyboard = UIStoryboard(name: "NotificationSettings", bundle: nil)
        guard let viewController = storyboard.instantiateViewController(withIdentifier: "NotificationSettingsVC") as? NotificationSettingsVC else {
            return nil
        }
        viewController.dependency = dependency
        return viewController
    }
}

// MARK: - NotificationSettingsAPIResponseDelegate
extension NotificationSettingsVC: NotificationSettingsAPIResponseDelegate {
}

//MARK: UITableViewDataSource
extension NotificationSettingsVC: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrSettings.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: NotificationSettingsTVC.identifier, for: indexPath) as! NotificationSettingsTVC
        cell.lblTitle.text = arrSettings[indexPath.row]
        cell.settingsSwitch.tag = indexPath.row
        
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 70.0
    }
}
//MARK: UITableViewDataSource
extension NotificationSettingsVC: UITableViewDelegate {
}
