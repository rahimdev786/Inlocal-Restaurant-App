//
//  ReservationVC.swift
//  InLocalCustomer
//
//  Created by Sudipta Patel on 08/06/21.
//  Copyright © 2021 ___ORGANIZATIONNAME___. All rights reserved.
//
//

import UIKit
import DatePickerDialog
import DateTimePicker

class ReservationVC: UIViewController, DateTimePickerDelegate {
    
    // MARK: Instance variables
	lazy var dataManager = ReservationDataManager()
    var dependency: ReservationDependency?
    
    @IBOutlet weak var viewSpecialIntructionBack: UIView!
    @IBOutlet weak var lblNoOfGuest: UILabel!
    @IBOutlet weak var lblTime: UILabel!
    @IBOutlet weak var lblDate: UILabel!
    
    let guestCountView = NoOfGuestView.instanceFromNib()
    var timePicker: DateTimePicker?
    
    
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
    
    @IBAction func onClickDate(_ sender: Any) {
        DatePickerDialog().show("DatePicker", doneButtonTitle: "Done", cancelButtonTitle: "Cancel", datePickerMode: .date) { date in
            if let dt = date {
                let formatter = DateFormatter()
                formatter.dateFormat = "dd MMM, yyyy"
                self.lblDate.text = formatter.string(from: dt)
            }
        }
    }
    
    @IBAction func onClickTime(_ sender: Any) {
        let timePicker = DateTimePicker.create(minimumDate: nil, maximumDate: nil)
        timePicker.timeInterval = DateTimePicker.MinuteInterval.default
        timePicker.highlightColor = UIColor.black
        timePicker.darkColor = UIColor.darkGray
        timePicker.doneButtonTitle = "Done"
        timePicker.doneBackgroundColor = UIColor.init(hexString: "#1DA1F2")
        timePicker.todayButtonTitle = ""
        timePicker.is12HourFormat = false
        timePicker.dateFormat = "HH:mm"
        timePicker.isTimePickerOnly = true
        timePicker.includesMonth = false
        timePicker.completionHandler = { date in
            let formatter = DateFormatter()
            formatter.dateFormat = "HH:mm"
            let timeString = formatter.string(from: date)
            self.lblTime.text = timeString
        }
        timePicker.delegate = self
        self.timePicker = timePicker
        self.timePicker?.show()
    }
    
    func dateTimePicker(_ picker: DateTimePicker, didSelectDate: Date) {
        
    }
    
    @IBAction func onClickGuest(_ sender: Any) {
        self.view.addSubview(guestCountView)
    }
    
    func setupView(){
        viewSpecialIntructionBack.layer.cornerRadius = 10
        viewSpecialIntructionBack.layer.borderWidth = 1
        viewSpecialIntructionBack.layer.borderColor = UIColor.lightGray.cgColor
        
        guestCountView.frame = UIScreen.main.bounds
        guestCountView.delegate = self
        guestCountView.imgViewBackground.backgroundColor = .black
        guestCountView.imgViewBackground.alpha = 0.6
    }
}

// MARK: - Load from storyboard with dependency
extension ReservationVC {
    
    class func load(withDependency dependency: ReservationDependency? = nil) -> ReservationVC? {
        
        let storyboard = UIStoryboard(name: "Reservation", bundle: nil)
        
        guard let vc = storyboard.instantiateViewController(withIdentifier: "ReservationVC") as? ReservationVC else {
            return nil
        }
        vc.dependency = dependency
        return vc
    }
}

// MARK: - ReservationAPIResponseDelegate
extension ReservationVC: ReservationAPIResponseDelegate {
    
}

extension ReservationVC: NoOfGuestDelegate {
    func onClickCancel() {
        
    }
    
    func onClickDone(guestCount: String) {
        lblNoOfGuest.text = guestCount
    }
}
