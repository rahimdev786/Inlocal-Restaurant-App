//
//  SelectRediusVC.swift
//  InLocalCustomer
//
//  Created by Sudipta Patel on 09/06/21.
//  Copyright © 2021 ___ORGANIZATIONNAME___. All rights reserved.
//
//

import UIKit
import GoogleMaps

class SelectRediusVC: UIViewController {
    
    // MARK: Instance variables
	lazy var dataManager = SelectRediusDataManager()
    var dependency: SelectRediusDependency?
    
    @IBOutlet weak var mapView: GMSMapView!
    @IBOutlet weak var viewSliderBack: UIView!
    
    @IBOutlet weak var sliderRadius: UISlider!
    
    var locationManager = CLLocationManager()
    var circ1 = GMSCircle()
    
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
    
    @IBAction func onClickFirstRadiusButton(_ sender: Any) {
        sliderRadius.value = 5
        setRadius(radiusValue: 5)
    }
    
    @IBAction func onClickSecondRadiusButton(_ sender: Any) {
        sliderRadius.value = 15
        setRadius(radiusValue: 15)
    }
    
    @IBAction func onClickThirdRadiusButton(_ sender: Any) {
        sliderRadius.value = 30
        setRadius(radiusValue: 30)
    }
    
    @IBAction func onMoveSlider(_ sender: UISlider) {
        let currentValue = Int(sender.value)
        DispatchQueue.main.async {
            self.setRadius(radiusValue: currentValue)
            print(currentValue)
        }
    }
    
    func setupView(){
        viewSliderBack.applyLightShadow()
        
        mapView.settings.compassButton = true
        mapView.isMyLocationEnabled = true
        mapView.settings.myLocationButton = true
        
        self.locationManager.delegate = self
        self.locationManager.startUpdatingLocation()
        
        sliderRadius.value = 15
        setRadius(radiusValue: 15)
    }
}

extension SelectRediusVC: CLLocationManagerDelegate {
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        //let location = locations.last
        let camera = GMSCameraPosition.camera(withLatitude: 18.5204, longitude: 73.8567, zoom: 10)
        self.mapView.animate(to: camera)
        self.locationManager.stopUpdatingLocation()
    }
    
    
    func setRadius(radiusValue: Int){
        let circleCenter : CLLocationCoordinate2D  = CLLocationCoordinate2DMake(18.5204, 73.8567);
        //let circ = GMSCircle(position: circleCenter, radius: CLLocationDistance(radiusValue * 1000))
        circ1.position = circleCenter
        circ1.radius = CLLocationDistance(radiusValue * 1000)
        circ1.fillColor = UIColor(red: 0.0, green: 0.0, blue: 0.7, alpha: 0.1)
        circ1.strokeColor = UIColor.init(hexString: "#1DA1F2")
        circ1.strokeWidth = 0.5;
        circ1.map = self.mapView;
    }
}
// MARK: - Load from storyboard with dependency
extension SelectRediusVC {
    
    class func load(withDependency dependency: SelectRediusDependency? = nil) -> SelectRediusVC? {
        
        let storyboard = UIStoryboard(name: "SelectRedius", bundle: nil)
        
        guard let vc = storyboard.instantiateViewController(withIdentifier: "SelectRediusVC") as? SelectRediusVC else {
            return nil
        }
        vc.dependency = dependency
        return vc
    }
}

// MARK: - SelectRediusAPIResponseDelegate
extension SelectRediusVC: SelectRediusAPIResponseDelegate {
    
}
