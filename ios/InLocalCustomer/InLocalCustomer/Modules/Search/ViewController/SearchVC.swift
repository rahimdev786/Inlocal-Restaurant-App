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
    @IBOutlet weak var collectionview_height: NSLayoutConstraint!
    
    @IBOutlet weak var tableViewPostList_Height: NSLayoutConstraint!
    @IBOutlet weak var tableViewPostList: UITableView!
    
    @IBOutlet weak var txtFieldSearch: UITextField!
    
    var categoryArray = ["Indian", "German", "Italian", "French", "American"]
    
    var isGridViewEnable = true
    var selectedCategory = -1
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
        //self.collectionViewPost.addObserver(self, forKeyPath: "contentSize", options: .new, context: nil)
        //self.tableViewPostList.addObserver(self, forKeyPath: "contentSizeTable", options: .new, context: nil)
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        //self.collectionViewPost.removeObserver(self, forKeyPath: "contentSize")
        //self.tableViewPostList.removeObserver(self, forKeyPath: "contentSizeTable")
    }
    
    // MARK: Deinitialization
    deinit {
       debugPrint("\(self) deinitialized")
    }
    
    @IBAction func onClickLocation(_ sender: Any) {
        guard let vc = SelectRediusVC.load(withDependency: nil) else{
            return
        }
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    @IBAction func onClickChangeView(_ sender: UIButton) {
        if isGridViewEnable{
            isGridViewEnable = false
            sender.setImage(#imageLiteral(resourceName: "search_grid"), for: .normal)
            collectionViewPost.isHidden = true
            tableViewPostList.isHidden = false
        } else{
            isGridViewEnable = true
            sender.setImage(#imageLiteral(resourceName: "search_list"), for: .normal)
            collectionViewPost.isHidden = false
            tableViewPostList.isHidden = true
        }
    }
    
    func setupView(){
        viewSearchContainer.layer.cornerRadius = 10
        viewSearchContainer.layer.borderWidth = 1
        viewSearchContainer.layer.borderColor = UIColor.lightGray.cgColor
        
        txtFieldSearch.delegate = self
        
        let widthValue = ((UIScreen.main.bounds.width-22)/2)
        let heightValue = widthValue
        let layout = UICollectionViewFlowLayout()
        layout.minimumInteritemSpacing = 2
        layout.minimumLineSpacing = 2
        layout.itemSize = CGSize(width: widthValue, height: heightValue)
        self.collectionViewPost.setCollectionViewLayout(layout, animated: true)
        
        if isGridViewEnable{
            collectionViewPost.isHidden = false
            tableViewPostList.isHidden = true
        } else{
            collectionViewPost.isHidden = true
            tableViewPostList.isHidden = false
        }
    }
    /*
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        if keyPath == "contentSize"{
            if object is UICollectionView{
                if let newvalue = change?[.newKey]{
                    let newsize = newvalue as! CGSize
                    self.collectionview_height.constant = newsize.height
                }
            }
        }
        //contentSizeTable
        if keyPath == "contentSizeTable"{
            if object is UITableView{
                if let newvalue = change?[.newKey]{
                    let newsize = newvalue as! CGSize
                    self.tableViewPostList_Height.constant = newsize.height
                }
            }
        }
    }
    */
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

extension SearchVC: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == collectionViewCategory{
            return categoryArray.count
        } else{
            return 10
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == collectionViewCategory{
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CategoryCVC", for: indexPath) as! CategoryCVC
            cell.lblCategoryName.text = categoryArray[indexPath.row]
            if selectedCategory == indexPath.row{
                cell.viewCategoryLblBack.backgroundColor = UIColor.init(hexString: "#1DA1F2")
            } else{
                cell.viewCategoryLblBack.backgroundColor = UIColor.init(hexString: "#333333")
            }
            
            return cell
        } else{
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "SearchPostCVC", for: indexPath) as! SearchPostCVC
            return cell
        }
    }
}

extension SearchVC : UICollectionViewDelegate{
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if collectionView == collectionViewCategory{
            selectedCategory = indexPath.row
            collectionViewCategory.reloadData()
        }
    }
}

extension SearchVC: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        //SearchPostListTVC
        let cell = tableView.dequeueReusableCell(withIdentifier: "SearchPostListTVC", for: indexPath) as! SearchPostListTVC
        return cell
    }
}

extension SearchVC: UITextFieldDelegate{
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}
