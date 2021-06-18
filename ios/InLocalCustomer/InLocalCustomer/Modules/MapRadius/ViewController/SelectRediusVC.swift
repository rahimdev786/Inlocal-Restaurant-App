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

    @IBOutlet weak var btnFirstRadius: UIButton!
    @IBOutlet weak var btnSecondRadius: UIButton!
    @IBOutlet weak var btnThirdRadius: UIButton!
    
    var locationManager = CLLocationManager()
    var circ1 = GMSCircle()
    var camera = GMSCameraPosition()
    var lat = 0.0
    var long = 0.0
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
        btnFirstRadius.backgroundColor = UIColor.init(hexString: "#1DA1F2")
        btnSecondRadius.backgroundColor = UIColor.init(hexString: "#333333")
        btnThirdRadius.backgroundColor = UIColor.init(hexString: "#333333")
        self.setMapCamera(lat: self.lat, lang: self.long, zoom: 11.0)
        self.setRadius(lat: self.lat, lang: self.long, radiusValue: 5)
    }
    
    @IBAction func onClickSecondRadiusButton(_ sender: Any) {
        sliderRadius.value = 15
        btnFirstRadius.backgroundColor = UIColor.init(hexString: "#333333")
        btnSecondRadius.backgroundColor = UIColor.init(hexString: "#1DA1F2")
        btnThirdRadius.backgroundColor = UIColor.init(hexString: "#333333")
        self.setMapCamera(lat: self.lat, lang: self.long, zoom: 10.0)
        self.setRadius(lat: self.lat, lang: self.long, radiusValue: 15)
    }
    
    @IBAction func onClickThirdRadiusButton(_ sender: Any) {
        sliderRadius.value = 30
        btnFirstRadius.backgroundColor = UIColor.init(hexString: "#333333")
        btnSecondRadius.backgroundColor = UIColor.init(hexString: "#333333")
        btnThirdRadius.backgroundColor = UIColor.init(hexString: "#1DA1F2")
        self.setMapCamera(lat: self.lat, lang: self.long, zoom: 9.0)
        self.setRadius(lat: self.lat, lang: self.long, radiusValue: 30)
    }
    
    @IBAction func onMoveSlider(_ sender: UISlider) {
        let currentValue = Int(sender.value)
        DispatchQueue.main.async {
            self.btnFirstRadius.backgroundColor = UIColor.init(hexString: "#333333")
            self.btnSecondRadius.backgroundColor = UIColor.init(hexString: "#333333")
            self.btnThirdRadius.backgroundColor = UIColor.init(hexString: "#333333")
            if currentValue < 6{
                self.setMapCamera(lat: self.lat, lang: self.long, zoom: 12.0)
            } else if currentValue >= 6 && currentValue < 15{
                self.setMapCamera(lat: self.lat, lang: self.long, zoom: 11.0)
            } else if currentValue >= 15 && currentValue < 25{
                self.setMapCamera(lat: self.lat, lang: self.long, zoom: 10.0)
            } else{
                self.setMapCamera(lat: self.lat, lang: self.long, zoom: 9.0)
            }
            self.setRadius(lat: self.lat, lang: self.long, radiusValue: currentValue)
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
        
    }
}

extension SelectRediusVC: CLLocationManagerDelegate {
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let location = locations.last
        self.lat = location?.coordinate.latitude ?? 0.0
        self.long = location?.coordinate.longitude ?? 0.0
        
        DispatchQueue.main.async {
            self.setMapCamera(lat: self.lat, lang: self.long, zoom: 10.0)
            self.setRadius(lat: self.lat, lang: self.long, radiusValue: 15)
        }
        self.locationManager.stopUpdatingLocation()
    }
    
    func setMapCamera(lat: Double, lang: Double, zoom: Float){
        camera = .camera(withLatitude: lat, longitude: lang, zoom: zoom)
        self.mapView.animate(to: camera)
    }
    
    func setRadius(lat: Double, lang: Double, radiusValue: Int){
        let circleCenter : CLLocationCoordinate2D  = CLLocationCoordinate2DMake(lat, lang);
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
