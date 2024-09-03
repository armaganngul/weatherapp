//
//  LocationManager.swift
//  ASISProject2
//
//  Created by Armağan Gül on 8.08.2024.
//

import CoreLocation
import Foundation
import CoreLocation

final class LocationManager: NSObject, CLLocationManagerDelegate {
    
    private let manager = CLLocationManager()
    static let shared = LocationManager()
    private var location : CLLocation?{
        didSet{
            guard let location else {
                return
            }
            locationFetchCompletion?(location)
        }
    }
    
    private var locationFetchCompletion: ((CLLocation) -> Void)?
        
    public func getLocation(completion: @escaping(CLLocation) -> Void){
        
        self.locationFetchCompletion = completion
        manager.requestWhenInUseAuthorization()
        manager.delegate = self
        manager.startUpdatingLocation()
        
    }
    
    func getCityName(from location: CLLocation, completion: @escaping (String?) -> Void) {
        
        let geocoder = CLGeocoder()
        
        geocoder.reverseGeocodeLocation(location) { placemarks, error in
            if let error = error {
                print("Reverse geocoding failed: \(error.localizedDescription)")
                completion(nil)
                return
            }
            
            guard let placemark = placemarks?.first else {
                print("No placemark found")
                completion(nil)
                return
            }
            
            let city = placemark.locality
            completion(city)
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = locations.first else {
            return
        }
        self.location = location
        manager.stopUpdatingLocation()
    }
}
