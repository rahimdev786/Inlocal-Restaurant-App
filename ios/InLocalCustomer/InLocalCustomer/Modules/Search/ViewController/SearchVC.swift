//
//  SearchVC.swift
//  InLocalCustomer
//
//  Created by Sudipta Patel on 02/06/21.
//  Copyright © 2021 ___ORGANIZATIONNAME___. All rights reserved.
//
//

import UIKit

class SearchVC: UIViewController {
    
    // MARK: Instance variables
	lazy var dataManager = SearchDataManager()
    var dependency: SearchDependency?
    
    @IBOutlet weak var viewSearchContainer: UIView!
    
    @IBOutlet weak var collectionViewCategory: UICollectionView!
    @IBOutlet weak var collectionViewPost: UICollectionView!
    
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
    
    func setupView(){
        viewSearchContainer.layer.cornerRadius = 10
        viewSearchContainer.layer.borderWidth = 1
        viewSearchContainer.layer.borderColor = UIColor.lightGray.cgColor
        
        let widthValue = ((UIScreen.main.bounds.width-30)/2)
        let heightValue = widthValue
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: widthValue, height: heightValue)
        self.collectionViewPost.setCollectionViewLayout(layout, animated: true)
    }
}

// MARK: - Load from storyboard with dependency
extension SearchVC {
    
    class func load(withDependency dependency: SearchDependency? = nil) -> SearchVC? {
        
        let storyboard = UIStoryboard(name: "Search", bundle: nil)
        
        guard let vc = storyboard.instantiateViewController(withIdentifier: "SearchVC") as? SearchVC else {
            return nil
        }
        vc.dependency = dependency
        return vc
    }
}

// MARK: - SearchAPIResponseDelegate
extension SearchVC: SearchAPIResponseDelegate {
    
}

extension SearchVC: UICollectionViewDelegate {
    
}

extension SearchVC: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 6
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == collectionViewCategory{
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CategoryCVC", for: indexPath) as! CategoryCVC
            return cell
        } else{
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "SearchPostCVC", for: indexPath) as! SearchPostCVC
            return cell
        }
        
        
    }
    
    
}
