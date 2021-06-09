//
//  CommentVC.swift
//  InLocalCustomer
//
//  Created by Sudipta Patel on 08/06/21.
//  Copyright © 2021 ___ORGANIZATIONNAME___. All rights reserved.
//
//

import UIKit

class CommentVC: UIViewController {
    
    // MARK: Instance variables
	lazy var dataManager = CommentDataManager()
    var dependency: CommentDependency?
    
    @IBOutlet weak var tableViewComment: UITableView!
    @IBOutlet weak var viewMenuBack: UIView!
    @IBOutlet weak var lblLike: UILabel!
    
    @IBOutlet weak var tableViewComment_Height: NSLayoutConstraint!
    
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
        self.tableViewComment.addObserver(self, forKeyPath: "contentSize", options: .new, context: nil)
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.tableViewComment.removeObserver(self, forKeyPath: "contentSize")
    }
    
    // MARK: Deinitialization
    deinit {
       debugPrint("\(self) deinitialized")
    }
    
    @IBAction func onClickBack(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    func setupView(){
        viewMenuBack.roundCorners([.layerMinXMinYCorner, .layerMinXMaxYCorner], radius: 20.0)
        //lblLike.roundCorners([.layerMinXMinYCorner, .layerMinXMaxYCorner, .layerMaxXMinYCorner, .layerMinXMinYCorner], radius: lblLike.frame.height/2)
        lblLike.layer.cornerRadius = lblLike.frame.height / 2
        lblLike.layer.masksToBounds = true
    }
    
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        if keyPath == "contentSize"{
            if object is UITableView{
                if let newvalue = change?[.newKey]{
                    let newsize = newvalue as! CGSize
                    self.tableViewComment_Height.constant = newsize.height
                }
            }
        }
    }
}

// MARK: - Load from storyboard with dependency
extension CommentVC {
    
    class func load(withDependency dependency: CommentDependency? = nil) -> CommentVC? {
        
        let storyboard = UIStoryboard(name: "Comment", bundle: nil)
        
        guard let vc = storyboard.instantiateViewController(withIdentifier: "CommentVC") as? CommentVC else {
            return nil
        }
        vc.dependency = dependency
        return vc
    }
}

// MARK: - CommentAPIResponseDelegate
extension CommentVC: CommentAPIResponseDelegate {
    
}

extension CommentVC: UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CommentTVC", for: indexPath) as! CommentTVC
        return cell
    }

}
