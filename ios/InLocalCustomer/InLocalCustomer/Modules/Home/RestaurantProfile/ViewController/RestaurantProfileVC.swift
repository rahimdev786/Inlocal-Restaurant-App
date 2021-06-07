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
        btnFollow.layer.cornerRadius = btnFollow.frame.height/2
        btnMenu.layer.cornerRadius = btnMenu.frame.height/2
        btnDelivery.layer.cornerRadius = btnDelivery.frame.height/2
        btnReservation.layer.cornerRadius = btnReservation.frame.height/2
        btnInfo.layer.cornerRadius = btnInfo.frame.height/2
        
        viewProfileBack.roundCorners([.layerMinXMinYCorner, .layerMaxXMinYCorner], radius: 20)
        
        let widthValue = ((UIScreen.main.bounds.width-44)/2)
        let heightValue = widthValue
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: widthValue, height: heightValue)
        self.collectionViewPost.setCollectionViewLayout(layout, animated: true)
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
