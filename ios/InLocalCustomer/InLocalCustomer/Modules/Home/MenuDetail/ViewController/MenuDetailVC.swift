//
//  MenuDetailVC.swift
//  InLocalCustomer
//
//  Created by Sudipta Patel on 07/06/21.
//  Copyright © 2021 ___ORGANIZATIONNAME___. All rights reserved.
//
//

import UIKit

class MenuDetailVC: UIViewController {
    
    // MARK: Instance variables
	lazy var dataManager = MenuDetailDataManager()
    var dependency: MenuDetailDependency?
    
    @IBOutlet weak var collectionViewMenuImage: UICollectionView!
    
    @IBOutlet weak var collectionViewMenuImage_height: NSLayoutConstraint!
    
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
        self.collectionViewMenuImage.addObserver(self, forKeyPath: "contentSize", options: .new, context: nil)
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.collectionViewMenuImage.removeObserver(self, forKeyPath: "contentSize")
    }
    
    // MARK: Deinitialization
    deinit {
       debugPrint("\(self) deinitialized")
    }
    
    @IBAction func onClickBack(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func onClickCustomizable(_ sender: Any) {
        guard let vc = MenuCustomisationVC.load(withDependency: nil) else{
            return
        }
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    func setupView(){
        
        let widthValue = ((UIScreen.main.bounds.width-36)/2)
        let heightValue = widthValue
        let layout = UICollectionViewFlowLayout()
        layout.minimumInteritemSpacing = 2
        layout.minimumLineSpacing = 2
        layout.itemSize = CGSize(width: widthValue, height: heightValue)
        self.collectionViewMenuImage.setCollectionViewLayout(layout, animated: true)
    }
    
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        if keyPath == "contentSize"{
            if object is UICollectionView{
                if let newvalue = change?[.newKey]{
                    let newsize = newvalue as! CGSize
                    self.collectionViewMenuImage_height.constant = newsize.height
                }
            }
        }
    }
}

// MARK: - Load from storyboard with dependency
extension MenuDetailVC {
    
    class func load(withDependency dependency: MenuDetailDependency? = nil) -> MenuDetailVC? {
        
        let storyboard = UIStoryboard(name: "MenuDetail", bundle: nil)
        
        guard let vc = storyboard.instantiateViewController(withIdentifier: "MenuDetailVC") as? MenuDetailVC else {
            return nil
        }
        vc.dependency = dependency
        return vc
    }
}

// MARK: - MenuDetailAPIResponseDelegate
extension MenuDetailVC: MenuDetailAPIResponseDelegate {
    
}

extension MenuDetailVC: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 6
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "SearchPostCVC", for: indexPath) as! SearchPostCVC
        return cell
    }
}
