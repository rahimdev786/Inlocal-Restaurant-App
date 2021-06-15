//
//  MenuCustomisationVC.swift
//  InLocalCustomer
//
//  Created by Sudipta Patel on 11/06/21.
//  Copyright © 2021 ___ORGANIZATIONNAME___. All rights reserved.
//
//

import UIKit

class MenuCustomisationVC: UIViewController {
    
    // MARK: Instance variables
    lazy var dataManager = MenuCustomisationDataManager()
    var dependency: MenuCustomisationDependency?
    
    @IBOutlet weak var tableViewCustomisation: UITableView!
    @IBOutlet weak var tableViewCustomisation_Height: NSLayoutConstraint!
    
    
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
        self.tableViewCustomisation.addObserver(self, forKeyPath: "contentSize", options: .new, context: nil)
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.tableViewCustomisation.removeObserver(self, forKeyPath: "contentSize")
    }
    
    // MARK: Deinitialization
    deinit {
       debugPrint("\(self) deinitialized")
    }
    
    @IBAction func onClickBack(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        if keyPath == "contentSize"{
            if object is UITableView{
                if let newvalue = change?[.newKey]{
                    let newsize = newvalue as! CGSize
                    self.tableViewCustomisation_Height.constant = newsize.height
                }
            }
        }
    }
}

// MARK: - Load from storyboard with dependency
extension MenuCustomisationVC {
    
    class func load(withDependency dependency: MenuCustomisationDependency? = nil) -> MenuCustomisationVC? {
        
        let storyboard = UIStoryboard(name: "MenuCustomisation", bundle: nil)
        
        guard let vc = storyboard.instantiateViewController(withIdentifier: "MenuCustomisationVC") as? MenuCustomisationVC else {
            return nil
        }
        vc.dependency = dependency
        return vc
    }
}

// MARK: - MenuCustomisationAPIResponseDelegate
extension MenuCustomisationVC: MenuCustomisationAPIResponseDelegate {
    
}

extension MenuCustomisationVC: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MenuCustomisationTVC", for: indexPath) as! MenuCustomisationTVC
        return cell
    }
    
}
