//
//  RestaurantProfileVC.swift
//  InLocalCustomer
//
//  Created by Sudipta Patel on 04/06/21.
//  Copyright © 2021 ___ORGANIZATIONNAME___. All rights reserved.
//
//

import UIKit

class RestaurantProfileVC: UIViewController {
    
    // MARK: Instance variables
	lazy var dataManager = RestaurantProfileDataManager()
    var dependency: RestaurantProfileDependency?
    
    @IBOutlet weak var viewProfileBack: UIView!
    @IBOutlet weak var collectionViewPost: UICollectionView!
    
    @IBOutlet weak var collectionViewPost_height: NSLayoutConstraint!
    
    @IBOutlet weak var btnFollow: UIButton!
    @IBOutlet weak var btnMenu: UIButton!
    @IBOutlet weak var btnDelivery: UIButton!
    @IBOutlet weak var btnReservation: UIButton!
    @IBOutlet weak var btnInfo: UIButton!
    
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
        self.collectionViewPost.addObserver(self, forKeyPath: "contentSize", options: .new, context: nil)
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.collectionViewPost.removeObserver(self, forKeyPath: "contentSize")
    }
    
    // MARK: Deinitialization
    deinit {
       debugPrint("\(self) deinitialized")
    }
    
    @IBAction func onClickBack(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func onClickFollowers(_ sender: Any) {
        guard let vc = FollowerVC.loadFromXIB(withDependency: nil) else{
            return
        }
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    @IBAction func onClickFollowing(_ sender: Any) {
        guard let vc = FollowerVC.loadFromXIB(withDependency: nil) else{
            return
        }
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    @IBAction func onClickOptions(_ sender: Any) {
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
    
    @IBAction func onClickMenu(_ sender: Any) {
        guard let vc = RestaurantMenuVC.load(withDependency: nil) else{
            return
        }
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    @IBAction func onClickDelivery(_ sender: Any) {
        guard let vc = DeliveryVC.load(withDependency: nil) else{
            return
        }
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    @IBAction func onClickFollow(_ sender: Any) {
        
    }
    
    @IBAction func onClickReservation(_ sender: Any) {
    //ReservationVC
        guard let vc = ReservationVC.load(withDependency: nil) else{
            return
        }
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    @IBAction func onClickInfo(_ sender: Any) {
        //RestaurantInfoVC
        guard let vc = RestaurantInfoVC.load(withDependency: nil) else{
            return
        }
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    func setupView(){
        btnFollow.layer.cornerRadius = btnFollow.frame.height/2
        btnMenu.layer.cornerRadius = btnMenu.frame.height/2
        btnDelivery.layer.cornerRadius = btnDelivery.frame.height/2
        btnReservation.layer.cornerRadius = btnReservation.frame.height/2
        btnInfo.layer.cornerRadius = btnInfo.frame.height/2
        
        viewProfileBack.roundCorners([.layerMinXMinYCorner, .layerMaxXMinYCorner], radius: 20)
        
        let widthValue = ((UIScreen.main.bounds.width-36)/2)
        let heightValue = widthValue
        let layout = UICollectionViewFlowLayout()
        layout.minimumInteritemSpacing = 2
        layout.minimumLineSpacing = 2
        layout.itemSize = CGSize(width: widthValue, height: heightValue)
        self.collectionViewPost.setCollectionViewLayout(layout, animated: true)
    }
    
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        if keyPath == "contentSize"{
            if object is UICollectionView{
                if let newvalue = change?[.newKey]{
                    let newsize = newvalue as! CGSize
                    self.collectionViewPost_height.constant = newsize.height
                }
            }
        }
    }
}

// MARK: - Load from storyboard with dependency
extension RestaurantProfileVC {
    
    class func load(withDependency dependency: RestaurantProfileDependency? = nil) -> RestaurantProfileVC? {
        
        let storyboard = UIStoryboard(name: "RestaurantProfile", bundle: nil)
        
        guard let vc = storyboard.instantiateViewController(withIdentifier: "RestaurantProfileVC") as? RestaurantProfileVC else {
            return nil
        }
        vc.dependency = dependency
        return vc
    }
}

// MARK: - RestaurantProfileAPIResponseDelegate
extension RestaurantProfileVC: RestaurantProfileAPIResponseDelegate {
    
}

extension RestaurantProfileVC: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 6
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "SearchPostCVC", for: indexPath) as! SearchPostCVC
        return cell
    }
}
