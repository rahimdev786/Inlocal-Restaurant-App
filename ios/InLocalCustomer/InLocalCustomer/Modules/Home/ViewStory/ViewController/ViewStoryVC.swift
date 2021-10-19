//
//  ViewStoryVC.swift
//  InLocalCustomer
//
//  Created by Sudipta Patel on 03/06/21.
//  Copyright © 2021 ___ORGANIZATIONNAME___. All rights reserved.
//
//

import UIKit

class ViewStoryVC: UIViewController {
    
    @IBOutlet weak var imageViewStory: UIImageView!
    @IBOutlet weak var lblUserName: UILabel!
    @IBOutlet weak var lblRestaurantName: UILabel!
    @IBOutlet weak var buttonThreeDot: UIButton!
    @IBOutlet weak var buttonUserImage: UIButton!
    @IBOutlet weak var buttonRestaurantImage: UIButton!
    @IBOutlet weak var sliderView: UISlider!
    
    // MARK: Instance variables
	lazy var dataManager = ViewStoryDataManager()
    var dependency: ViewStoryDependency?

    var myFeedWallStories : MyFeedWallStories?
    
    var  mytimer : Timer?
    var  reversing : Bool?
    
    // MARK: - View Life Cycle Methods
	override func viewDidLoad() {
        super.viewDidLoad()
        
        dataManager.apiResponseDelegate = self
        
        buttonThreeDot.isHidden = true
        buttonRestaurantImage.isHidden = true
        lblRestaurantName.text = " "
        
        reversing = false
        mytimer =  Timer.scheduledTimer(timeInterval: 0.1, target: self, selector: #selector(timerAction), userInfo: nil, repeats: true)
        
        setData()
    }
    
    @objc func timerAction(){
        var sliderrange =  sliderView.maximumValue - sliderView.minimumValue;
        var increment = sliderrange/100;
        var newval = sliderView.value;
        
        newval = (sliderView.value + increment);
        if(newval >= sliderView.maximumValue){
            if mytimer != nil {
                mytimer!.invalidate()
                mytimer = nil
            }
            self.navigationController?.popViewController(animated: true)
        }
        /*
        if(newval >= sliderView.maximumValue)
        {
          reversing = true;
           newval = newval - 2*increment;

        }
        else  if(newval <= 0)
        {
          reversing = false;
        }
        */
        sliderView.setValue(newval, animated: true)
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
        if mytimer != nil {
            mytimer!.invalidate()
            mytimer = nil
        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
    }
    
    // MARK: Deinitialization
    deinit {
       debugPrint("\(self) deinitialized")
    }
    
    @IBAction func onClickBackButton(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func onClickOptios(_ sender: Any) {
        
        let alertController = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        
        let action1 = UIAlertAction(title: "Report", style: .default) { (action) in
            
        }
        action1.setValue(UIColor.black, forKey: "titleTextColor")
        
        let action2 = UIAlertAction(title: "Share", style: .default) { (action) in
            
        }
        action2.setValue(UIColor.black, forKey: "titleTextColor")
        
        let action3 = UIAlertAction(title: "Cancel", style: .default) { (action) in
            
        }
        action3.setValue(UIColor.black, forKey: "titleTextColor")
        
        alertController.addAction(action1)
        alertController.addAction(action2)
        alertController.addAction(action3)
        self.present(alertController, animated: true, completion: nil)
        
    }
    
    @IBAction func onClickClose(_ sender: Any) {
        
    }
    
    @IBAction func onClickUserPhoto(_ sender: Any) {
        guard let vc = UserProfileVC.load(withDependency: nil) else{
            return
        }
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    @IBAction func onClickRestaurentPhoto(_ sender: Any) {
        guard let vc = RestaurantProfileVC.load(withDependency: nil) else{
            return
        }
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    func setData(){
        lblUserName.text = myFeedWallStories?.name
        if let storyImageUrl = myFeedWallStories?.storyImage{
            imageViewStory.sd_setImage(with:  URL(string: storyImageUrl), placeholderImage: nil)
        }
        
        UIView.animate(withDuration: 5, animations: {
          self.sliderView.setValue(0, animated:true)
        })
    }
}

// MARK: - Load from storyboard with dependency
extension ViewStoryVC {
    
    class func load(withDependency dependency: ViewStoryDependency? = nil) -> ViewStoryVC? {
        
        let storyboard = UIStoryboard(name: "ViewStory", bundle: nil)
        
        guard let vc = storyboard.instantiateViewController(withIdentifier: "ViewStoryVC") as? ViewStoryVC else {
            return nil
        }
        vc.dependency = dependency
        return vc
    }
}

// MARK: - ViewStoryAPIResponseDelegate
extension ViewStoryVC: ViewStoryAPIResponseDelegate {
    
}
