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
    
    @IBAction func onClickBack(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func onClickAddNew(_ sender: Any) {
        guard let vc = AddAddressVC.load() else{
            return
        }
        navigationController?.pushViewController(vc, animated: true)
    }
    
    func openActionSheet(){
        let alertController = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
    
        let action0 = UIAlertAction(title: "Set Default", style: .default) { (action) in
            
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
    
}

extension AddressBookVC: UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "AddressBookTVC", for: indexPath) as! AddressBookTVC
        return cell
    }
}

extension AddressBookVC: UITableViewDelegate{
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        openActionSheet()
    }
}
