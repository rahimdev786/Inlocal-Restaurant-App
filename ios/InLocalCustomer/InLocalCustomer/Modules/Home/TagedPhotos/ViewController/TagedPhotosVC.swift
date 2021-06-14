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
    
    @IBAction func onClickBack(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
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
        return cell
    }

}
