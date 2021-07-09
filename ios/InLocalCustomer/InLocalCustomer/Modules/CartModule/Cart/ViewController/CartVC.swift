//
//  CartVC.swift
//  InLocalCustomer
//
//  Created by Sudipta Patel on 09/06/21.
//  Copyright © 2021 ___ORGANIZATIONNAME___. All rights reserved.
//
//

import UIKit

class CartVC: UIViewController {
    
    // MARK: Instance variables
	lazy var dataManager = CartDataManager()
    var dependency: CartDependency?
    
    @IBOutlet weak var tableViewItems: UITableView!
    @IBOutlet weak var tableViewItems_Height: NSLayoutConstraint!
    
    @IBOutlet weak var viewTxtFieldBack: UIView!
    @IBOutlet weak var viewOrderAllItemBack: UIView!
    @IBOutlet weak var viewGrantTotalBack: UIView!
    @IBOutlet weak var viewItemTotalBack: UIView!
    @IBOutlet weak var btnPay: UIButton!
    
    @IBOutlet weak var btnFive: UIButton!
    @IBOutlet weak var btnTen: UIButton!
    @IBOutlet weak var btnFifteen: UIButton!
    
    @IBOutlet weak var lblTipPercent: UILabel!
    @IBOutlet weak var tipSlider: UISlider!
    @IBOutlet weak var lblTipAmount: UILabel!
    @IBOutlet weak var lblGrandTotalAmount: UILabel!
    
    @IBOutlet weak var containerView: UIView!
    
    
    var orderAllItem = false
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
    
    
    @IBAction func onClickOrderAllCheckBox(_ sender: UIButton) {
        if orderAllItem{
            orderAllItem = false
            sender.setImage(#imageLiteral(resourceName: "empty_checkbox_gray"), for: .normal)
        } else{
            orderAllItem = true
            sender.setImage(#imageLiteral(resourceName: "checked_checkbox"), for: .normal)
        }
    }
    
    
    @IBAction func onClickFive(_ sender: Any) {
        btnFive.backgroundColor = UIColor.init(hexString: "#1DA1F2")
        btnFive.setTitleColor(UIColor.white, for: .normal)
        btnTen.backgroundColor = UIColor.init(hexString: "#EDF7FE")
        btnTen.setTitleColor(UIColor.init(hexString: "#1DA1F2"), for: .normal)
        btnFifteen.backgroundColor = UIColor.init(hexString: "#EDF7FE")
        btnFifteen.setTitleColor(UIColor.init(hexString: "#1DA1F2"), for: .normal)
        
        lblTipPercent.text = "5 %"
        tipSlider.value = 5
        calculateTipAmount(tipPer: 5)
    }
    
    @IBAction func onClickTen(_ sender: Any) {
        btnFive.backgroundColor = UIColor.init(hexString: "#EDF7FE")
        btnFive.setTitleColor(UIColor.init(hexString: "#1DA1F2"), for: .normal)
        btnTen.backgroundColor = UIColor.init(hexString: "#1DA1F2")
        btnTen.setTitleColor(UIColor.white, for: .normal)
        btnFifteen.backgroundColor = UIColor.init(hexString: "#EDF7FE")
        btnFifteen.setTitleColor(UIColor.init(hexString: "#1DA1F2"), for: .normal)
        
        lblTipPercent.text = "10 %"
        tipSlider.value = 10
        calculateTipAmount(tipPer: 10)
    }
    
    @IBAction func onClickFiften(_ sender: Any) {
        
        btnFive.backgroundColor = UIColor.init(hexString: "#EDF7FE")
        btnFive.setTitleColor(UIColor.init(hexString: "#1DA1F2"), for: .normal)
        btnTen.backgroundColor = UIColor.init(hexString: "#EDF7FE")
        btnTen.setTitleColor(UIColor.init(hexString: "#1DA1F2"), for: .normal)
        btnFifteen.backgroundColor = UIColor.init(hexString: "#1DA1F2")
        btnFifteen.setTitleColor(UIColor.white, for: .normal)
        
        lblTipPercent.text = "15 %"
        tipSlider.value = 15
        calculateTipAmount(tipPer: 15)
    }
    
    
    @IBAction func onMoveTripSlider(_ sender: UISlider) {
        let currentValue = Int(sender.value)
        lblTipPercent.text = "\(currentValue) %"

        btnFive.backgroundColor = UIColor.init(hexString: "#EDF7FE")
        btnFive.setTitleColor(UIColor.init(hexString: "#1DA1F2"), for: .normal)
        btnTen.backgroundColor = UIColor.init(hexString: "#EDF7FE")
        btnTen.setTitleColor(UIColor.init(hexString: "#1DA1F2"), for: .normal)
        btnFifteen.backgroundColor = UIColor.init(hexString: "#EDF7FE")
        btnFifteen.setTitleColor(UIColor.init(hexString: "#1DA1F2"), for: .normal)
        
        calculateTipAmount(tipPer: currentValue)
        
    }
    
    @IBAction func onClickPay(_ sender: Any) {
        guard let vc = PaymentTypeVC.load(withDependency: nil) else {
            return
        }
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    func setupView(){
        tipSlider.value = 15
        
        viewTxtFieldBack.layer.cornerRadius = 10
        viewTxtFieldBack.layer.borderWidth = 1
        viewTxtFieldBack.layer.borderColor = UIColor.lightGray.cgColor
        
        viewItemTotalBack.layer.borderWidth = 1
        viewItemTotalBack.layer.borderColor = UIColor.lightGray.cgColor
        
        viewOrderAllItemBack.roundCorners([.layerMaxXMaxYCorner, .layerMaxXMinYCorner, .layerMinXMaxYCorner, .layerMinXMinYCorner], radius: 10)
        viewGrantTotalBack.roundCorners([.layerMaxXMaxYCorner, .layerMaxXMinYCorner, .layerMinXMaxYCorner, .layerMinXMinYCorner], radius: 5)
        
        btnPay.roundCorners([.layerMaxXMaxYCorner, .layerMaxXMinYCorner, .layerMinXMaxYCorner, .layerMinXMinYCorner], radius: 5)
        
        calculateTipAmount(tipPer: 15)
        
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
    
    func calculateTipAmount(tipPer: Int){
        let multi = Double(tipPer * 170)
        let tipValue = Double(multi / 100)
        lblTipAmount.text = "€ \(tipValue)"
        let grandTotal = Double(tipValue + 170 + 20)
        lblGrandTotalAmount.text = "€ \(grandTotal)"
    }
    
}

// MARK: - Load from storyboard with dependency
extension CartVC {
    
    class func load(withDependency dependency: CartDependency? = nil) -> CartVC? {
        
        let storyboard = UIStoryboard(name: "Cart", bundle: nil)
        
        guard let vc = storyboard.instantiateViewController(withIdentifier: "CartVC") as? CartVC else {
            return nil
        }
        vc.dependency = dependency
        return vc
    }
}

// MARK: - CartAPIResponseDelegate
extension CartVC: CartAPIResponseDelegate {
    
}

extension CartVC: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "DeliveryCartItemTVC", for: indexPath) as! DeliveryCartItemTVC
        return cell
    }
    
}
