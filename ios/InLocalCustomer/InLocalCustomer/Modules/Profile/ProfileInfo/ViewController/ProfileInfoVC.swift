//
//  ProfileInfoVC.swift
//  InLocalCustomer
//
//  Created by Sajib Ghosh on 02/06/21.
//  Copyright © 2021 ___ORGANIZATIONNAME___. All rights reserved.
//
//

import UIKit

class ProfileInfoVC: UIViewController {
    // MARK: Instance variables
	lazy var dataManager = ProfileInfoDataManager()
    var dependency: ProfileInfoDependency?
    
    @IBOutlet weak var tableView: UITableView!
    
    var arrDetails: [AccountDetails]?
    
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
    
    @IBAction func didTapOnBack(_ sender: UIButton) {
        navigationController?.popViewController(animated: true)
    }
    
    @IBAction func didTapOnEditProfile(_ sender: UIButton) {
        guard let vc = EditProfileVC.loadFromXIB() else{
            return
        }
        navigationController?.pushViewController(vc, animated: true)
    }
    
    @IBAction func didTapOnLogout(_ sender: UIButton) {
        
        
        let alertVC = UIAlertController(title: "Logout", message: "Are you sure you want to logout of the app?", preferredStyle: .alert)
        let okAction = UIAlertAction(title: "Yes", style: .default) { (_) in

            guard let introVC = SigninVC.load()else {
                fatalError("IntroVC or LoginVC could not be loaded.")
            }
            let navVC = PopNavigationController(rootViewController: introVC)
            navVC.isNavigationBarHidden = true
            
            AppDelegate.shared.window?.replaceRootViewControllerWith(navVC, animated: true, completion: {
                //do nothing as of now
            })
        }
        
        //okAction.setValue(AppColors.themeOrange.color, forKey: "titleTextColor")
        
        let cancelAction = UIAlertAction(title: "No", style: .cancel) { (_) in
            alertVC.dismiss(animated: true, completion: nil)
        }
        //cancelAction.setValue(AppColors.txtDarkGray.color, forKey: "titleTextColor")
        alertVC.addAction(okAction)
        alertVC.addAction(cancelAction)
        self.present(alertVC, animated: true, completion: nil)
        
        
    }
    
    func setupUI() {
        
        let view = UIView.init(frame: CGRect(x: 0, y: 0, width: self.view.frame.width, height: 30))
        view.backgroundColor = .clear
        tableView.tableHeaderView = view
        tableView.tableFooterView = view
        
        arrDetails = [AccountDetails(title: "My Orders", image: #imageLiteral(resourceName: "myBookings"), type: .orders),
        AccountDetails(title: "My Bookings", image: #imageLiteral(resourceName: "myBookings"), type: .bookings),
        AccountDetails(title: "Saved Posts", image: #imageLiteral(resourceName: "savedPost"), type: .savedPosts),
        AccountDetails(title: "Address Book", image: #imageLiteral(resourceName: "myBookings"), type: .addressBook),
        AccountDetails(title: "Change Password", image: #imageLiteral(resourceName: "changePassword"), type: .changePassword),
        AccountDetails(title: "Notification Settings", image: #imageLiteral(resourceName: "notificationSettings"), type: .notificationSettings),
        ]
    }
}

// MARK: - Load from storyboard with dependency
extension ProfileInfoVC {
    class func loadFromXIB(withDependency dependency: ProfileInfoDependency? = nil) -> ProfileInfoVC? {
        let storyboard = UIStoryboard(name: "ProfileInfo", bundle: nil)
        guard let viewController = storyboard.instantiateViewController(withIdentifier: "ProfileInfoVC") as? ProfileInfoVC else {
            return nil
        }
        viewController.dependency = dependency
        return viewController
    }
}

// MARK: - ProfileInfoAPIResponseDelegate
extension ProfileInfoVC: ProfileInfoAPIResponseDelegate {
}

//MARK: UITableViewDataSource
extension ProfileInfoVC: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrDetails?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: ProfileInfoTVC.identifier, for: indexPath) as! ProfileInfoTVC
        let obj = arrDetails![indexPath.row]
        cell.lblTitle.text = obj.title
        cell.imgIcon.image = obj.image
        
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60.0
    }
}
//MARK: UITableViewDataSource
extension ProfileInfoVC: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let obj = arrDetails![indexPath.row]
        
        switch obj.type {
        case .orders:
            guard let vc = OrderListVC.loadFromXIB() else{
                return
            }
            navigationController?.pushViewController(vc, animated: true)
        case .bookings:
            guard let vc = BookingListVC.loadFromXIB() else{
                return
            }
            navigationController?.pushViewController(vc, animated: true)
        case .savedPosts:
            guard let vc = SavedPostsVC.loadFromXIB() else{
                return
            }
            navigationController?.pushViewController(vc, animated: true)
        case .addressBook:
            guard let vc = AddressBookVC.load() else{
                return
            }
            navigationController?.pushViewController(vc, animated: true)
        case .changePassword:
            guard let vc = ChangePasswordVC.load() else{
                return
            }
            navigationController?.pushViewController(vc, animated: true)
        case .notificationSettings:
            guard let vc = NotificationSettingsVC.loadFromXIB() else{
                return
            }
            navigationController?.pushViewController(vc, animated: true)
        default:
            ()
        }
 
    }
}

