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
    var notificationSettingRequest = NotificationSettingRequest()
    
    // MARK: - View Life Cycle Methods
	override func viewDidLoad() {
        super.viewDidLoad()
        dataManager.apiResponseDelegate = self
        setData()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        AppActivityIndicator.showActivityIndicator(displayStyle: .dark, displayMessage: "", showInView: self.view)
        dataManager.getNotificationSettingCall()
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
    
    @IBAction func onClickSave(_ sender: Any) {
        
        guard let post = notificationSettingRequest.post, let stories = notificationSettingRequest.stories, let comments = notificationSettingRequest.comments, let followers = notificationSettingRequest.followers,let orders = notificationSettingRequest.orders, let bookings = notificationSettingRequest.booking, let payment = notificationSettingRequest.payment else{
            return
        }
        AppActivityIndicator.showActivityIndicator(displayStyle: .dark, displayMessage: "", showInView: self.view)
        dataManager.updateNotificationSettings(post: post, stories: stories, comments: comments, followers: followers, orders: orders, booking: bookings, payments: payment)
    }
    
    func setData(){
        notificationSettingRequest.post = false
        notificationSettingRequest.stories = false
        notificationSettingRequest.comments = false
        notificationSettingRequest.followers = false
        notificationSettingRequest.orders = false
        notificationSettingRequest.booking = false
        notificationSettingRequest.payment = false
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
    func getNotificationSettingSuccess(withData: NotificationSettingResponseModel) {
        AppActivityIndicator.hideActivityIndicator()
        print(withData)
    }
    
    func updateNotificationSuccess(withData: UpdateSettingResponse) {
        AppActivityIndicator.hideActivityIndicator()
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

//MARK: UITableViewDataSource
extension NotificationSettingsVC: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrSettings.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: NotificationSettingsTVC.identifier, for: indexPath) as! NotificationSettingsTVC
        cell.lblTitle.text = arrSettings[indexPath.row]
        cell.settingsSwitch.tag = indexPath.row
        cell.settingsSwitch.addTarget(self, action: #selector(self.switchChanged(_:)), for: .valueChanged)
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 70.0
    }
    
    @objc func switchChanged(_ sender : UISwitch!){
          print("table row switch Changed \(sender.tag)")
          print("The switch is \(sender.isOn ? "ON" : "OFF")")
        let index = sender.tag
        switch index {
        case 0:
            if sender.isOn{
                notificationSettingRequest.post = true
            } else{
                notificationSettingRequest.post = false
            }
            
        case 1:
            if sender.isOn{
                notificationSettingRequest.stories = true
            } else{
                notificationSettingRequest.stories = false
            }
            
        case 2:
            if sender.isOn{
                notificationSettingRequest.comments = true
            } else{
                notificationSettingRequest.comments = false
            }
            
        case 3:
            if sender.isOn{
                notificationSettingRequest.followers = true
            } else{
                notificationSettingRequest.followers = false
            }
            
        case 4:
            if sender.isOn{
                notificationSettingRequest.orders = true
            } else{
                notificationSettingRequest.orders = false
            }
            
        case 5:
            if sender.isOn{
                notificationSettingRequest.booking = true
            } else{
                notificationSettingRequest.booking = false
            }
            
        case 6:
            if sender.isOn{
                notificationSettingRequest.payment = true
            } else{
                notificationSettingRequest.payment = false
            }
            
        default:
            print("")
        }
        
    }
}


//MARK: UITableViewDataSource
extension NotificationSettingsVC: UITableViewDelegate {
    
}
