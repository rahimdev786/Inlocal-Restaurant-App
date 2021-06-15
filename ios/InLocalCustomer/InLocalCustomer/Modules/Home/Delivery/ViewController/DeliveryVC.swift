//
//  DeliveryVC.swift
//  InLocalCustomer
//
//  Created by Sudipta Patel on 07/06/21.
//  Copyright © 2021 ___ORGANIZATIONNAME___. All rights reserved.
//
//

import UIKit

class DeliveryVC: UIViewController {
    
    // MARK: Instance variables
	lazy var dataManager = DeliveryDataManager()
    var dependency: DeliveryDependency?
    
    @IBOutlet weak var collectionViewMenuCategory: UICollectionView!
    @IBOutlet weak var tableViewDeliveryMenu: UITableView!
    
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
    
    @IBAction func onClickOption(_ sender: Any) {
        let alertController = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        let action0 = UIAlertAction(title: "Block", style: .default) { (action) in
            
        }
        action0.setValue(UIColor.black, forKey: "titleTextColor")
        
        let action1 = UIAlertAction(title: "Report", style: .default) { (action) in
            
        }
        action1.setValue(UIColor.black, forKey: "titleTextColor")
        
        let action2 = UIAlertAction(title: "Share", style: .default) { (action) in
            
        }
        action2.setValue(UIColor.black, forKey: "titleTextColor")
        
        let action3 = UIAlertAction(title: "Cancel", style: .default) { (action) in
            
        }
        action3.setValue(UIColor.black, forKey: "titleTextColor")
        
        alertController.addAction(action0)
        alertController.addAction(action1)
        alertController.addAction(action2)
        alertController.addAction(action3)
        self.present(alertController, animated: true, completion: nil)
    }
}

// MARK: - Load from storyboard with dependency
extension DeliveryVC {
    
    class func load(withDependency dependency: DeliveryDependency? = nil) -> DeliveryVC? {
        
        let storyboard = UIStoryboard(name: "Delivery", bundle: nil)
        
        guard let vc = storyboard.instantiateViewController(withIdentifier: "DeliveryVC") as? DeliveryVC else {
            return nil
        }
        vc.dependency = dependency
        return vc
    }
}

// MARK: - DeliveryAPIResponseDelegate
extension DeliveryVC: DeliveryAPIResponseDelegate {
    
}
//DeliveryMenuTVC
extension DeliveryVC: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 6
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MenuCategoryCVC", for: indexPath) as! MenuCategoryCVC
        return cell
    }
}

extension DeliveryVC: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 6
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "DeliveryMenuTVC", for: indexPath) as! DeliveryMenuTVC
        cell.btnCustomizable.addTarget(self, action: #selector(onClickCustomizable(sender:)), for: .touchUpInside)
        cell.btnCustomizable.tag = indexPath.row
        return cell
    }
    
}

extension DeliveryVC{
    @objc func onClickCustomizable(sender: UIButton){
        let buttonTag = sender.tag
        guard let vc = MenuCustomisationVC.load(withDependency: nil) else{
            return
        }
        self.navigationController?.pushViewController(vc, animated: true)
    }
}
