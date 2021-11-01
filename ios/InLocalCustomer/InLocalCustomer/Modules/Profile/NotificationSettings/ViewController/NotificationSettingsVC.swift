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
    
    @IBOutlet weak var tableViewSetting: UITableView!
    
	lazy var dataManager = NotificationSettingsDataManager()
    var dependency: NotificationSettingsDependency?
    
    var arrSettings = ["Posts","Stories","Comments","Followers","Orders","Bookings","Payment"]
    var notificationSettingRequest = NotificationSettingRequest()
    
    var notificationSettingResponseModel : NotificationSettingResponseModel?
    
    // MARK: - View Life Cycle Methods
	override func viewDidLoad() {
        super.viewDidLoad()
        dataManager.apiResponseDelegate = self
        //setData()
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
        notificationSettingRequest.post = notificationSettingResponseModel?.post
        notificationSettingRequest.stories = notificationSettingResponseModel?.stories
        notificationSettingRequest.comments = notificationSettingResponseModel?.comments
        notificationSettingRequest.followers = notificationSettingResponseModel?.followers
        notificationSettingRequest.orders = notificationSettingResponseModel?.orders
        notificationSettingRequest.booking = notificationSettingResponseModel?.booking
        notificationSettingRequest.payment = notificationSettingResponseModel?.payment
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
        notificationSettingResponseModel = withData
        setData()
        tableViewSetting.reloadData()
    }
    
    func updateNotificationSuccess(withData: EmptyResponse?) {
        AppActivityIndicator.hideActivityIndicator()
        AppActivityIndicator.showActivityIndicator(displayStyle: .dark, displayMessage: "", showInView: self.view)
        dataManager.getNotificationSettingCall()
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
        
        switch indexPath.row {
        case 0:
            if let status = notificationSettingResponseModel?.post{
                if status == "0"{
                    cell.settingsSwitch.isOn = false
                } else{
                    cell.settingsSwitch.isOn = true
                }
            }
        case 1:
            if let status = notificationSettingResponseModel?.stories{
                if status == "0"{
                    cell.settingsSwitch.isOn = false
                } else{
                    cell.settingsSwitch.isOn = true
                }
            }
            
        case 2:
            if let status = notificationSettingResponseModel?.comments{
                if status == "0"{
                    cell.settingsSwitch.isOn = false
                } else{
                    cell.settingsSwitch.isOn = true
                }
            }
            
        case 3:
            if let status = notificationSettingResponseModel?.followers{
                if status == "0"{
                    cell.settingsSwitch.isOn = false
                } else{
                    cell.settingsSwitch.isOn = true
                }
            }
        
        case 4:
            if let status = notificationSettingResponseModel?.orders{
                if status == "0"{
                    cell.settingsSwitch.isOn = false
                } else{
                    cell.settingsSwitch.isOn = true
                }
            }
            
        case 5:
            if let status = notificationSettingResponseModel?.booking{
                if status == "0"{
                    cell.settingsSwitch.isOn = false
                } else{
                    cell.settingsSwitch.isOn = true
                }
            }
        
        case 6:
            if let status = notificationSettingResponseModel?.payment{
                if status == "0"{
                    cell.settingsSwitch.isOn = false
                } else{
                    cell.settingsSwitch.isOn = true
                }
            }
            
        default:
            print("")
        }
        
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
                notificationSettingRequest.post = "1"
            } else{
                notificationSettingRequest.post = "0"
            }
            
        case 1:
            if sender.isOn{
                notificationSettingRequest.stories = "1"
            } else{
                notificationSettingRequest.stories = "0"
            }
            
        case 2:
            if sender.isOn{
                notificationSettingRequest.comments = "1"
            } else{
                notificationSettingRequest.comments = "0"
            }
            
        case 3:
            if sender.isOn{
                notificationSettingRequest.followers = "1"
            } else{
                notificationSettingRequest.followers = "0"
            }
            
        case 4:
            if sender.isOn{
                notificationSettingRequest.orders = "1"
            } else{
                notificationSettingRequest.orders = "0"
            }
            
        case 5:
            if sender.isOn{
                notificationSettingRequest.booking = "1"
            } else{
                notificationSettingRequest.booking = "0"
            }
            
        case 6:
            if sender.isOn{
                notificationSettingRequest.payment = "1"
            } else{
                notificationSettingRequest.payment = "0"
            }
            
        default:
            print("")
        }
        
    }
}


//MARK: UITableViewDataSource
extension NotificationSettingsVC: UITableViewDelegate {
    
}
