//
//  OrderListVC.swift
//  InLocalCustomer
//
//  Created by Sajib Ghosh on 02/06/21.
//  Copyright © 2021 ___ORGANIZATIONNAME___. All rights reserved.
//
//

import UIKit

struct ApiDateFormat{
    static let apiFormat = "yyyy-MM-dd HH:mm:ss"
    static let reviewDateFormat = "dd MMM yyyy"
    static let filterDateFormat = "dd-MMM-yyyy"
}

class OrderListVC: UIViewController {
    // MARK: Instance variables
	lazy var dataManager = OrderListDataManager()
    var dependency: OrderListDependency?
    
    var orderListingData : OrderListing?
    
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
        
        self.dataManager.getOrderList(skip: 0, startDate: Utility.getDateStringFromFormat(formatString: "yyyy-MM-dd", date: Date()), endDate: Utility.getDateStringFromFormat(formatString: "yyyy-MM-dd", date: Date()))
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
    
    @IBAction func didTapOnCalendar(_ sender: UIButton) {
        
        showCalendar()
    }
    
    func showCalendar() {
        let dateRangeCalendar = DateSelectionHelper.shared
        
        dateRangeCalendar.showCalendar(with: Calendar.current.date(byAdding: .year, value: -1, to: Date())!, maxDate:  Date(), target: self) { (checkInDate, checkoutDate,isCancelled) in
              if isCancelled{
              } else{
                  let dateFormatter = DateFormatter()
                  dateFormatter.dateFormat = ApiDateFormat.filterDateFormat
//                  let fromDate = dateFormatter.string(from: checkInDate!)
//                  let toDate = dateFormatter.string(from: checkoutDate!)
                
                self.dataManager.getOrderList(skip: 0, startDate: Utility.getDateStringFromFormat(formatString: "yyyy-MM-dd", date: checkInDate!), endDate: Utility.getDateStringFromFormat(formatString: "yyyy-MM-dd", date: checkoutDate!))
                
                /*
                  self.lblStartDate.text = fromDate
                  self.startDate = checkInDate
                  self.lblEndDate.text = toDate
                  self.endDate = checkoutDate
                
                  self.dateFilterStk.isHidden = false
                
                if self.isCurrentOrders {
                    self.viewModel.currentPageForCurrentTask = 1
                    self.tableviewCurrentOrders.loadData(refresh: true)
                }else{
                    self.viewModel.currentPageForPastTask = 1
                    self.tableviewPastOrders.loadData(refresh: true)
                }
                */
              }
          }
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
    func orderListfetched(orderList: OrderListing?) {
        self.orderListingData = orderList
        self.tableView.reloadData()
    }
    
    func apiError(_ error: APIError) {
        AppActivityIndicator.hideActivityIndicator()
        self.view.makeToast(error.errorDescription)
    }
    
    func networkError(_ error: Error) {
        AppActivityIndicator.hideActivityIndicator()
        self.view.makeToast(error.localizedDescription)
        print(error.localizedDescription)
    }
    
    
}

//MARK: UITableViewDataSource
extension OrderListVC: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.orderListingData?.orderListing?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: OrderListTVC.identifier, for: indexPath) as! OrderListTVC
        let orderObject = self.orderListingData?.orderListing?[indexPath.row]
        
        cell.orderIdLabelOutlet.text = "Order Id : #\(orderObject?.id ?? 0)"
        cell.resturantDineInLabelOutlet.text = "\(orderObject?.order_type == "DELIVERY" ? "DELIVERY" : "Resturant Dine In")"
        cell.cusineNameOutlet.text = orderObject?.restaurant?.name ?? ""
        cell.priceLabelOutlet.text = "$ \(orderObject?.final_order_amount ?? 0.0)"
        cell.orderDateLabelOutlet.text =  Utility.getDateStringFromFormat(formatString: "hh:mm a, dd.MM.yyyy", date: Utility.getDateFromDateString(formatString: "yyyy-MM-dd'T'HH:mm:ss.SSSZ", dateString: orderObject?.order_date ?? ""))
        
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
