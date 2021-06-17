//
//  BookingListVC.swift
//  InLocalCustomer
//
//  Created by Sajib Ghosh on 02/06/21.
//  Copyright © 2021 ___ORGANIZATIONNAME___. All rights reserved.
//
//

import UIKit

class BookingListVC: UIViewController {
    // MARK: Instance variables
	lazy var dataManager = BookingListDataManager()
    var dependency: BookingListDependency?
    
    @IBOutlet weak var tableView: UITableView!
    
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
                  let fromDate = dateFormatter.string(from: checkInDate!)
                  let toDate = dateFormatter.string(from: checkoutDate!)
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
extension BookingListVC {
    class func loadFromXIB(withDependency dependency: BookingListDependency? = nil) -> BookingListVC? {
        let storyboard = UIStoryboard(name: "BookingList", bundle: nil)
        guard let viewController = storyboard.instantiateViewController(withIdentifier: "BookingListVC") as? BookingListVC else {
            return nil
        }
        viewController.dependency = dependency
        return viewController
    }
}

// MARK: - BookingListAPIResponseDelegate
extension BookingListVC: BookingListAPIResponseDelegate {
}

//MARK: UITableViewDataSource
extension BookingListVC: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: BookingListTVC.identifier, for: indexPath) as! BookingListTVC
        return cell
    }
    
}

extension BookingListVC: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 108.0
    }
}
