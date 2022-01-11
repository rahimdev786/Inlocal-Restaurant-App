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
    
    var notificationList = [NotificationList]()
    
    // MARK: - View Life Cycle Methods
	override func viewDidLoad() {
        super.viewDidLoad()
        
        dataManager.apiResponseDelegate = self
        setupUI()
        
        AppActivityIndicator.showActivityIndicator(showInView: self.view)
        dataManager.getNotificationListCall(skip: 0, limit: 10)
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
    func readNotificationSuccess(withData: EmptyResponse?) {
        AppActivityIndicator.hideActivityIndicator()
    }
    
    func notificationListSuccess(withData: NotificationListResponse) {
        AppActivityIndicator.hideActivityIndicator()
        notificationList = withData.notificationList ?? []
        tableViewNotification.reloadData()
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

extension NotificationsVC: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return notificationList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "NotificationTVC", for: indexPath) as! NotificationTVC
        let notificationData = notificationList[indexPath.row]
        
        cell.deliveryTitle_Lbl.text = notificationData.title
        cell.deliveryDetails_Lbl.text = notificationData.message
        cell.deliveryImgView.sd_setImage(with:  URL(string: notificationData.fromImage ?? ""), placeholderImage: UIImage())

        let dateStr = convertDate(DateStr: notificationData.createdAt ?? "")
        cell.day_Lbl.text = dateStr
        
        let timeStr = convertTime(timeStr: notificationData.time ?? "")
        cell.date_Lbl.text = timeStr
        
        
        
        if indexPath.row < 3{
            cell.imgViewNewNotification.isHidden = false
        } else{
            cell.imgViewNewNotification.isHidden = true
        }
        return cell
    }
    
    func convertDate(DateStr:String) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:SS.000000Z"
        let date = dateFormatter.date(from: DateStr)
        dateFormatter.dateFormat = "dd.MM.yyyy"
        let resultString = dateFormatter.string(from: date!)
        return resultString
    }
    
    
        func convertTime(timeStr:String) -> String {
            let timeFormatter = DateFormatter()
            timeFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:SS.000000Z"
            let time = timeFormatter.date(from: timeStr)
            timeFormatter.dateFormat = "hh:mm a"
            let resultString = timeFormatter.string(from: time!)
            return resultString
        }
    
    
}

extension NotificationsVC: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        let notificationData = notificationList[indexPath.row]
//        AppActivityIndicator.showActivityIndicator(showInView: self.view)
//        dataManager.readNotificationCall(notificationId: notificationData.id!)
        
        guard let vc = OrderDetailsVC.loadFromXIB() else{
            return
        }
        vc.id = notificationList[indexPath.row].toID!
        navigationController?.pushViewController(vc, animated: true)
        
    }
}
