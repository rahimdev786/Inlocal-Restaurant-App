//
//  LocationManager.swift
//  Bedcoin
//
//  Created by Sudipta Patel on 18/03/20.
//  Copyright © 2020 Sudipta Patel. All rights reserved.
//

import UIKit
import CoreLocation
import GoogleMaps
import GooglePlaces
import Alamofire

typealias LocationCompletionHandler = (_ location: CLLocation?) -> ()

class LocationManager: NSObject {

    static let sharedInstance = LocationManager()
    let locationManager = CLLocationManager()
    var currentLocation = CLLocation()
    var locCompletion: LocationCompletionHandler?

    func currentAuthorizationStatus() -> CLAuthorizationStatus {
        
        if CLLocationManager.locationServicesEnabled() {
           
            switch CLLocationManager.authorizationStatus() {
                
            case .notDetermined:
                return .notDetermined
                   
            case .restricted:
                return .restricted
 
             case .denied:
                return .denied
                   
            case .authorizedAlways:
                return .authorizedAlways
                    
             case .authorizedWhenInUse:
                return .authorizedWhenInUse
            }
            
        } else {
            print("Location services are not enabled")
            return .notDetermined
        }
    }
    
    func setUpLocationManger() {
        locationManager.requestWhenInUseAuthorization()
        locationManager.delegate = self
        locationManager.distanceFilter = 100
        locationManager.requestLocation()
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
    }
    
   func getLocation(completion:@escaping LocationCompletionHandler) {
        locationManager.delegate = self

        locationManager.startUpdatingLocation()
        
       locCompletion = completion
    }
    
    func stopUpdatingLocation(){
        locationManager.stopUpdatingLocation()
        locationManager.delegate = nil
    }
    
    func startUpdatingLocation(){
       locationManager.startUpdatingLocation()
        locationManager.delegate = self
    }
    
    func getAddressFromCoordinates(lat:Double,long:Double,completion:@escaping(_ address: String?, _ error: Error?, _ stateShortName: String?) -> ()){
        
        let url = "https://maps.googleapis.com/maps/api/geocode/json?latlng=\(lat),\(long)&key=AppConstants.GoogleApiKey.key"

        AF.request(url).validate().responseJSON { response in
        switch response.result {
        case .success(let responseData):

            let responseJson = responseData as? [String:Any]
            var stateCode = ""
            if let results = responseJson?["results"] as? [[String: Any]] {
                if results.count > 0 {
                    if let addressComponents = results[0]["address_components"] as? [[String:Any]] {
                        let address = results[0]["formatted_address"] as? String
                        print("^^^^^^^^^^^^^^^^^^^^^^^^^^^^^\(address)")
                        for component in addressComponents {
                            if let type = component["types"] as? [String] {
                                if (type[0] == "administrative_area_level_1") {
                                    print("****************************** \(component["short_name"] ?? "")")
                                    stateCode = (component["short_name"] ?? "") as! String
                                    break
                                }
                            }
                        }
                        completion(address,nil,stateCode)
                    }
                } else {
                    completion(nil,nil,nil)
                }
            } else {
                completion(nil,nil,nil)
            }
            
        case .failure(let error):
            print(error)
            completion(nil,error,nil)

        }
            
        /*   let geocoder = GMSGeocoder()

             let position = CLLocationCoordinate2DMake(lat, long)
        geocoder.reverseGeocodeCoordinate(position) { response , error in
            if error != nil {
                print("GMSReverseGeocode Error: \(String(describing: error?.localizedDescription))")
            }else {
                guard let address = response?.firstResult(), let lines = address.lines else {
                     return
                   }
                //let result = response?.results()?.first
                let address1 = lines.joined(separator: "\n")//result?.lines?.reduce("") { $0 == "" ? $1 : $0 + ", " + $1 }
                completion(address1)
            }
        }*/
            
        }
    }
    
    func getPlaceFromPlaceId(placeId: String,completion: @escaping (_ place:GMSPlace? , _ error:Error?) ->()){
        let placeClient = GMSPlacesClient()
        placeClient.lookUpPlaceID(placeId) { (place, error) in
            if error != nil{
                completion(nil,error!)
            } else{
                if let myPlace = place{
                    completion(myPlace,nil)
                }
            }
        }
    }

}
 
extension LocationManager: CLLocationManagerDelegate{
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
      
         if let location = locations.last {
                currentLocation = location
            print("Current location: \(currentLocation.coordinate.latitude) logitude: \(currentLocation.coordinate.longitude)")
            locCompletion?(currentLocation)
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print(error)
    }
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
       // if locCompletion == nil {
            NotificationCenter.default.post(name: Notification.Name(rawValue: "StatusChanged"), object: nil)
       // }
    }
}
