//
//  TagedPhotosVC.swift
//  InLocalCustomer
//
//  Created by Sudipta Patel on 04/06/21.
//  Copyright © 2021 ___ORGANIZATIONNAME___. All rights reserved.
//
//

import UIKit

class TagedPhotosVC: UIViewController {
    
    // MARK: Instance variables
	lazy var dataManager = TagedPhotosDataManager()
    var dependency: TagedPhotosDependency?
    
    @IBOutlet weak var tableViewPosts: UITableView!
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var tableViewPostHeight: NSLayoutConstraint!
    
    var headerTitle = "Taged photos"
    
    // MARK: - View Life Cycle Methods
	override func viewDidLoad() {
        super.viewDidLoad()
        
        dataManager.apiResponseDelegate = self
        setView()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.tableViewPosts.addObserver(self, forKeyPath: "contentSize", options: .new, context: nil)
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.tableViewPosts.removeObserver(self, forKeyPath: "contentSize")
    }
    
    // MARK: Deinitialization
    deinit {
       debugPrint("\(self) deinitialized")
    }
    
    @IBAction func onClickBack(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func didTapOnMore(_ sender: UIButton) {
        
        openActionSheet()
    }
    
    func openActionSheet(){
        let alertController = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
    
        let action0 = UIAlertAction(title: "Report", style: .default) { (action) in
            
        }
        action0.setValue(UIColor.black, forKey: "titleTextColor")
        
        let action1 = UIAlertAction(title: "Share", style: .default) { (action) in
            
        }
        action1.setValue(UIColor.black, forKey: "titleTextColor")
        
        let action2 = UIAlertAction(title: "Cancel", style: .default) { (action) in
            
        }
        action2.setValue(UIColor.black, forKey: "titleTextColor")
        
        alertController.addAction(action0)
        alertController.addAction(action1)
        alertController.addAction(action2)
        self.present(alertController, animated: true, completion: nil)
    }
    
    func setView(){
        lblTitle.text = headerTitle
    }
    
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        if keyPath == "contentSize"{
            if object is UITableView{
                if let newvalue = change?[.newKey]{
                    let newsize = newvalue as! CGSize
                    self.tableViewPostHeight.constant = newsize.height
                }
            }
        }
    }

}

// MARK: - Load from storyboard with dependency
extension TagedPhotosVC {
    
    class func load(withDependency dependency: TagedPhotosDependency? = nil) -> TagedPhotosVC? {
        
        let storyboard = UIStoryboard(name: "TagedPhotos", bundle: nil)
        
        guard let vc = storyboard.instantiateViewController(withIdentifier: "TagedPhotosVC") as? TagedPhotosVC else {
            return nil
        }
        vc.dependency = dependency
        return vc
    }
}

// MARK: - TagedPhotosAPIResponseDelegate
extension TagedPhotosVC: TagedPhotosAPIResponseDelegate {
    
}
//TagedPhotoTVC
extension TagedPhotosVC: UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TagedPhotoTVC", for: indexPath) as! TagedPhotoTVC
        cell.btnRestaurent.addTarget(self, action: #selector(onClickRestaurent(sender:)), for: .touchUpInside)
        cell.btnRestaurent.tag = indexPath.row
        
        cell.btnMenu.addTarget(self, action: #selector(onClickMenu(sender:)), for: .touchUpInside)
        cell.btnMenu.tag = indexPath.row
        
        cell.btnSavedPost.addTarget(self, action: #selector(onClickSavedPost(sender:)), for: .touchUpInside)
        cell.btnSavedPost.tag = indexPath.row
        
        cell.btnComment.addTarget(self, action: #selector(onClickComment(sender:)), for: .touchUpInside)
        cell.btnComment.tag = indexPath.row
        return cell
    }

}

extension TagedPhotosVC {
    
    @objc func onClickRestaurent(sender: UIButton){
        let buttonTag = sender.tag
        guard let vc = RestaurantProfileVC.load(withDependency: nil) else{
            return
        }
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    @objc func onClickMenu(sender: UIButton){
        let buttonTag = sender.tag
        guard let vc = RestaurantMenuVC.load(withDependency: nil) else{
            return
        }
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    @objc func onClickSavedPost(sender: UIButton){
        let buttonTag = sender.tag
        guard let vc = SavedPostsVC.loadFromXIB() else{
            return
        }
        navigationController?.pushViewController(vc, animated: true)
    }
    
    @objc func onClickComment(sender: UIButton){
        let buttonTag = sender.tag
        guard let viewStoryController = CommentVC.load(withDependency: nil) else{
            return
        }
        self.navigationController?.pushViewController(viewStoryController, animated: true)
    }
}
