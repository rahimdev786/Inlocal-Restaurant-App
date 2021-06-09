//
//  OrderDetailsVC.swift
//  InLocalCustomer
//
//  Created by Sajib Ghosh on 02/06/21.
//  Copyright © 2021 ___ORGANIZATIONNAME___. All rights reserved.
//
//

import UIKit

class OrderDetailsVC: UIViewController {
    // MARK: Instance variables
	lazy var dataManager = OrderDetailsDataManager()
    var dependency: OrderDetailsDependency?
    
    @IBOutlet weak var placeholderView: UIView!
    
    @IBOutlet weak var dateView: UIView!
    
    var previousSelectedCell: BookingDetailsTVC?
    
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
    
    func setupUI() {
        
        placeholderView.layer.borderWidth = 1.0
        placeholderView.layer.borderColor = UIColor(hexString: "f2f2f2").cgColor
        
        dateView.layer.borderWidth = 1.0
        dateView.layer.borderColor = UIColor(hexString: "333333").cgColor
    }
    
    @IBAction func didTapOnUploadStatus(_ sender: UIButton) {
        
    }
    
    @IBAction func didTapOnBack(_ sender: UIButton) {
        navigationController?.popViewController(animated: true)
    }
    
    
}

// MARK: - Load from storyboard with dependency
extension OrderDetailsVC {
    class func loadFromXIB(withDependency dependency: OrderDetailsDependency? = nil) -> OrderDetailsVC? {
        let storyboard = UIStoryboard(name: "OrderDetails", bundle: nil)
        guard let viewController = storyboard.instantiateViewController(withIdentifier: "OrderDetailsVC") as? OrderDetailsVC else {
            return nil
        }
        viewController.dependency = dependency
        return viewController
    }
}

// MARK: - OrderDetailsAPIResponseDelegate
extension OrderDetailsVC: OrderDetailsAPIResponseDelegate {
}

extension OrderDetailsVC: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: BookingDetailsTVC.identifier, for: indexPath) as! BookingDetailsTVC
        cell.btnSelect.isSelected = false
        return cell
    }
    
}

extension OrderDetailsVC: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 145.0
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if previousSelectedCell != nil {
            previousSelectedCell?.btnSelect.isSelected = false
        }
        let cell = tableView.cellForRow(at: indexPath) as! BookingDetailsTVC
        cell.btnSelect.isSelected = true
        previousSelectedCell = cell
    }
}
