//
//  AddressBookVC.swift
//  InLocalCustomer
//
//  Created by Sudipta Patel on 14/06/21.
//  Copyright © 2021 ___ORGANIZATIONNAME___. All rights reserved.
//
//

import UIKit

class AddressBookVC: UIViewController {
    
    // MARK: Instance variables
	lazy var dataManager = AddressBookDataManager()
    var dependency: AddressBookDependency?
    
    @IBOutlet weak var tableViewAddressBook: UITableView!
    @IBOutlet weak var btnPlus: UIButton!
    
    var selectedIndexPath: IndexPath?
    var previousSelectedCell: AddressBookTVC?
    var addressList = [AddressList]()
    
    
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
        AppActivityIndicator.showActivityIndicator(showInView: self.view)
        dataManager.getAddressListCall(skip: 0, limit: 10)
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
    
    @IBAction func onClickBack(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func onClickAddNew(_ sender: Any) {
        guard let vc = AddAddressVC.load() else{
            return
        }
        navigationController?.pushViewController(vc, animated: true)
    }
    
    func openActionSheet(index: Int){
        let alertController = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
    
        let action0 = UIAlertAction(title: "Set Default", style: .default) { [self] (action) in
            /*
            let cell = self.tableViewAddressBook.cellForRow(at: self.selectedIndexPath!) as! AddressBookTVC
            cell.btnSelect.isSelected = true
            self.previousSelectedCell?.btnSelect.isSelected = false
            self.previousSelectedCell = cell
            */
            let addressDara = addressList[index]
            guard let addressId = addressDara.id else{
                return
            }
            AppActivityIndicator.showActivityIndicator(showInView: self.view)
            self.dataManager.setDefaultAddressCall(addressId: addressId)
        }
        
        action0.setValue(UIColor.black, forKey: "titleTextColor")
        
        let action1 = UIAlertAction(title: "Delete", style: .default) { (action) in
            
        }
        action1.setValue(UIColor.black, forKey: "titleTextColor")
        
        let action2 = UIAlertAction(title: "Cancel", style: .default) { (action) in
            
        }
        action2.setValue(UIColor.black, forKey: "titleTextColor")
        
        alertController.addAction(action0)
        alertController.addAction(action1)
        alertController.addAction(action2)
        self.present(alertController, animated: true, completion: nil)
    }
    
}

// MARK: - Load from storyboard with dependency
extension AddressBookVC {
    
    class func load(withDependency dependency: AddressBookDependency? = nil) -> AddressBookVC? {
        
        let storyboard = UIStoryboard(name: "AddressBook", bundle: nil)
        
        guard let vc = storyboard.instantiateViewController(withIdentifier: "AddressBookVC") as? AddressBookVC else {
            return nil
        }
        vc.dependency = dependency
        return vc
    }
}

// MARK: - AddressBookAPIResponseDelegate
extension AddressBookVC: AddressBookAPIResponseDelegate {
    func setDefaultAddressSuccess(withData: EmptyResponse?) {
        AppActivityIndicator.hideActivityIndicator()
        dataManager.getAddressListCall(skip: 0, limit: 10)
    }
    
    func addressListSuccess(withData: AddressBookResponseModel) {
        AppActivityIndicator.hideActivityIndicator()
        self.addressList = withData.addressList ?? []
        tableViewAddressBook.reloadData()
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

extension AddressBookVC: UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return addressList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "AddressBookTVC", for: indexPath) as! AddressBookTVC
        
        let addressData = addressList[indexPath.row]
        let address = addressData.address ?? ""
        let landmark = addressData.landmark ?? ""
        let city = addressData.city ?? ""
        let country = addressData.country ?? ""
        let zipcode = addressData.zipCode ?? ""
        
        cell.lblAddress.text = "\(address) \(landmark) \(city) \(country) \(zipcode)"
        
        if (addressData.isDefault == "1"){
            cell.btnSelect.isSelected = true
        } else{
            cell.btnSelect.isSelected = false
        }
    
        return cell
    }
    
}

extension AddressBookVC: UITableViewDelegate{
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cell = tableView.cellForRow(at: indexPath) as! AddressBookTVC
        selectedIndexPath = indexPath
        openActionSheet(index: indexPath.row)
    }
}
