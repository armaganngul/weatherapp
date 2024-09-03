//
//  MapView.swift
//  ASISProject2
//
//  Created by Armağan Gül on 21.08.2024.
//

import Foundation
import UIKit
import MapKit


class MapViewController: UIViewController, MKMapViewDelegate{
    
    public var onLocationSelected: ((CLLocation) -> Void)?
    public var clickedLocation: CLLocation?
    public var weatherView = CurrentWeatherView()
    public var weatherViewController = WeatherViewController()
    
    let mapView: MKMapView = {
        let map = MKMapView()
        map.overrideUserInterfaceStyle = .dark
        map.translatesAutoresizingMaskIntoConstraints = false
        return map
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(mapView)
        setMapView()

        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(handleMapTap(_:)))
        mapView.addGestureRecognizer(tapGesture)
    }
    
    func locationToDouble(location: CLLocation) -> [Double]{
        return [location.coordinate.latitude, location.coordinate.longitude]
    }
    
    func switchToWeatherTabWithAnimation() {
        guard let tabBarController = self.tabBarController as? TabViewController else { return }
        
        let previousIndex = tabBarController.selectedIndex
        
        let newIndex = 0 // Index for the Weather tab
        
        let snapshot = tabBarController.view.snapshotView(afterScreenUpdates: true)
        snapshot?.frame = tabBarController.view.frame
        tabBarController.view.addSubview(snapshot!)
        
        tabBarController.selectedIndex = newIndex
        
        UIView.animate(withDuration: 0.3, animations: {
            snapshot?.alpha = 0
            tabBarController.view.alpha = 1
        }, completion: { _ in
            snapshot?.removeFromSuperview()
        })
    }
    
    func setMapView(){
        NSLayoutConstraint.activate([
            mapView.topAnchor.constraint(equalTo: view.topAnchor),
            mapView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            mapView.rightAnchor.constraint(equalTo: view.rightAnchor),
            mapView.leftAnchor.constraint(equalTo: view.leftAnchor),
        ])
    }
    
    @objc func handleMapTap(_ gestureRecognizer: UITapGestureRecognizer) {
            let location = gestureRecognizer.location(in: mapView)
            let coordinate = mapView.convert(location, toCoordinateFrom: mapView)
            
            clickedLocation = CLLocation(latitude: coordinate.latitude, longitude: coordinate.longitude)
            UserDefaults.standard.set(locationToDouble(location: clickedLocation!), forKey: "current-location")

            weatherViewController.afterClickLocation()
            switchToWeatherTabWithAnimation()

        print("Clicked location: \(String(describing: clickedLocation?.coordinate.latitude)), \(String(describing: clickedLocation?.coordinate.longitude))")
        }
}
