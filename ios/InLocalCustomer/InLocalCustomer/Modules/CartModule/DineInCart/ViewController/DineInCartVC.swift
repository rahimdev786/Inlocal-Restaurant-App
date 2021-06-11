//
//  DineInCartVC.swift
//  InLocalCustomer
//
//  Created by Sudipta Patel on 10/06/21.
//  Copyright © 2021 ___ORGANIZATIONNAME___. All rights reserved.
//
//

import UIKit

class DineInCartVC: UIViewController {
    
    // MARK: Instance variables
	lazy var dataManager = DineInCartDataManager()
    var dependency: DineInCartDependency?
    
    @IBOutlet weak var tableViewItems: UITableView!
    @IBOutlet weak var tableViewItems_Height: NSLayoutConstraint!
    
    @IBOutlet weak var viewTxtFieldBack: UIView!
    @IBOutlet weak var viewOrderAllItemBack: UIView!
    @IBOutlet weak var viewGrantTotalBack: UIView!
    @IBOutlet weak var viewItemTotalBack: UIView!
    @IBOutlet weak var btnPay: UIButton!
    
    // MARK: - View Life Cycle Methods
	override func viewDidLoad() {
        super.viewDidLoad()
        
        dataManager.apiResponseDelegate = self
        setupView()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.tableViewItems.addObserver(self, forKeyPath: "contentSize", options: .new, context: nil)
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.tableViewItems.removeObserver(self, forKeyPath: "contentSize")
    }
    
    // MARK: Deinitialization
    deinit {
       debugPrint("\(self) deinitialized")
    }
    
    @IBAction func onClickBack(_ sender: Any) {

    }
    
    func setupView(){
        
        viewTxtFieldBack.layer.cornerRadius = 10
        viewTxtFieldBack.layer.borderWidth = 1
        viewTxtFieldBack.layer.borderColor = UIColor.lightGray.cgColor
        
        viewItemTotalBack.layer.borderWidth = 1
        viewItemTotalBack.layer.borderColor = UIColor.lightGray.cgColor
        
        viewOrderAllItemBack.roundCorners([.layerMaxXMaxYCorner, .layerMaxXMinYCorner, .layerMinXMaxYCorner, .layerMinXMinYCorner], radius: 10)
        viewGrantTotalBack.roundCorners([.layerMaxXMaxYCorner, .layerMaxXMinYCorner, .layerMinXMaxYCorner, .layerMinXMinYCorner], radius: 5)
        
        btnPay.roundCorners([.layerMaxXMaxYCorner, .layerMaxXMinYCorner, .layerMinXMaxYCorner, .layerMinXMinYCorner], radius: 5)
    }
    
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        if keyPath == "contentSize"{
            if object is UITableView{
                if let newvalue = change?[.newKey]{
                    let newsize = newvalue as! CGSize
                    self.tableViewItems_Height.constant = newsize.height
                }
            }
        }
    }
}

// MARK: - Load from storyboard with dependency
extension DineInCartVC {
    
    class func load(withDependency dependency: DineInCartDependency? = nil) -> DineInCartVC? {
        
        let storyboard = UIStoryboard(name: "DineInCart", bundle: nil)
        
        guard let vc = storyboard.instantiateViewController(withIdentifier: "DineInCartVC") as? DineInCartVC else {
            return nil
        }
        vc.dependency = dependency
        return vc
    }
}

// MARK: - DineInCartAPIResponseDelegate
extension DineInCartVC: DineInCartAPIResponseDelegate {
    
}
extension DineInCartVC: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "DineInCartItemTVC", for: indexPath) as! DineInCartItemTVC
        return cell
    }
    
}
