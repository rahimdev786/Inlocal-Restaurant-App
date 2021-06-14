//
//  OrderListVC.swift
//  InLocalCustomer
//
//  Created by Sajib Ghosh on 02/06/21.
//  Copyright © 2021 ___ORGANIZATIONNAME___. All rights reserved.
//
//

import UIKit

class OrderListVC: UIViewController {
    // MARK: Instance variables
	lazy var dataManager = OrderListDataManager()
    var dependency: OrderListDependency?
    // MARK: - View Life Cycle Methods
    
    @IBOutlet weak var tableView: UITableView!
    
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
extension OrderListVC {
    class func loadFromXIB(withDependency dependency: OrderListDependency? = nil) -> OrderListVC? {
        let storyboard = UIStoryboard(name: "OrderList", bundle: nil)
        guard let viewController = storyboard.instantiateViewController(withIdentifier: "OrderListVC") as? OrderListVC else {
            return nil
        }
        viewController.dependency = dependency
        return viewController
    }
}

// MARK: - OrderListAPIResponseDelegate
extension OrderListVC: OrderListAPIResponseDelegate {
}

//MARK: UITableViewDataSource
extension OrderListVC: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: OrderListTVC.identifier, for: indexPath) as! OrderListTVC
        return cell
    }
    
}

extension OrderListVC: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 108.0
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if let dependency = dependency {
            if dependency.isComingFromUpload {
                navigationController?.popViewController(animated: true)
            }else{
                guard let vc = OrderDetailsVC.loadFromXIB() else{
                    return
                }
                navigationController?.pushViewController(vc, animated: true)
            }
        }else{
            guard let vc = OrderDetailsVC.loadFromXIB() else{
                return
            }
            navigationController?.pushViewController(vc, animated: true)
        }
        
        
    }
}
