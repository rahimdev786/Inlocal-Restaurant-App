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
    @IBOutlet weak var btnUploadStatus: UIButton!
    @IBOutlet weak var restaurantName_Lbl: UILabel!
    
    @IBOutlet weak var orderItem_Tbl: UITableView!
    @IBOutlet weak var orderId_Lbl: UILabel!
    @IBOutlet weak var dateTime_Lbl: UILabel!
    
    @IBOutlet weak var tableNo_Lbl: UILabel!
    @IBOutlet weak var itemTotal_Lbl: UILabel!
    @IBOutlet weak var tax_Lbl: UILabel!
    @IBOutlet weak var deliveryCharge_Lbl: UILabel!
    @IBOutlet weak var tip_Lbl: UILabel!
    @IBOutlet weak var grandTotal_Lbl: UILabel!
    
    
    var id = Int()
    var orderDetails : OrderDetailsDataClass?
    
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
        
        dataManager.orderDetail(orderId: id)
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
    
    func orderDetails(withData: OrderDetailsDataClass) {
        
        orderDetails = withData
        restaurantName_Lbl.text = orderDetails?.orderDetail?.restaurant?.name
        orderItem_Tbl.reloadData()
        
        
        orderId_Lbl.text = "Order Id: \(id)"
        dateTime_Lbl.text = ""
        tableNo_Lbl.text = "\(orderDetails?.orderDetail?.tableNo ?? 0)"
        itemTotal_Lbl.text = "\(orderDetails?.orderDetail?.orderSubtotal ?? 0)"
        tax_Lbl.text = "\(orderDetails?.orderDetail?.tax ?? 0)"
        deliveryCharge_Lbl.text = "\(orderDetails?.orderDetail?.deliveryCharge ?? 0)"
        tip_Lbl.text = orderDetails?.orderDetail?.percentageTipValue ?? ""
        grandTotal_Lbl.text = "\(orderDetails?.orderDetail?.finalOrderAmount ?? 0)"
        
        
    }
    
}

extension OrderDetailsVC: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return orderDetails?.orderDetail?.orderItems?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: BookingDetailsTVC.identifier, for: indexPath) as! BookingDetailsTVC
        cell.btnSelect.isSelected = false
        let orderItems = orderDetails?.orderDetail?.orderItems?[indexPath.row]
        
        cell.name_Lbl.text = orderItems?.menuItemName
        cell.orderTotal_Lbl.text = "$\(orderItems?.price ?? 0)"
        cell.finalOrderAmt_Lbl.text = "$\((orderItems?.price ?? 0) * (orderItems?.qty ?? 0))"
        cell.quantity_Lbl.text = "\(orderItems?.qty ?? 0)x"
        cell.details_Lbl.text = orderItems?.orderItemDescription
        
        if orderItems?.orderitemssubaddon?.count ?? 0 > 0 {
            cell.customization_Lbl.text = "Customization: \(orderItems?.orderitemssubaddon?[0].addonName ?? "")"
        } else {
            cell.customization_Lbl.text = ""
        }
        
        return cell
    }
    
}

extension OrderDetailsVC: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 145.0
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if let previousSelectedCell = previousSelectedCell {
            previousSelectedCell.btnSelect.isSelected = false
        }
        let cell = tableView.cellForRow(at: indexPath) as! BookingDetailsTVC
        cell.btnSelect.isSelected = !cell.btnSelect.isSelected
        previousSelectedCell = cell
        
        btnUploadStatus.backgroundColor = UIColor(hexString: "1DA1F2")
        btnUploadStatus.titleLabel?.textColor = .white
    }
}
