//
//  ReservationVC.swift
//  InLocalCustomer
//
//  Created by Sudipta Patel on 08/06/21.
//  Copyright © 2021 ___ORGANIZATIONNAME___. All rights reserved.
//
//

import UIKit

class ReservationVC: UIViewController {
    
    // MARK: Instance variables
	lazy var dataManager = ReservationDataManager()
    var dependency: ReservationDependency?
    
    @IBOutlet weak var viewSpecialIntructionBack: UIView!
    
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
    
    func setupView(){
        viewSpecialIntructionBack.layer.cornerRadius = 10
        viewSpecialIntructionBack.layer.borderWidth = 1
        viewSpecialIntructionBack.layer.borderColor = UIColor.lightGray.cgColor
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
