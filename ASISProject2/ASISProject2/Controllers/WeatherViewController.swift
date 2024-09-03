//
//  ViewController.swift
//  ASISProject2
//
//  Created by Armağan Gül on 8.08.2024.
//

import UIKit
import CoreLocation

class WeatherViewController: UIViewController {
    
    private let primaryView = CurrentWeatherView()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        setUpView()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        print(UserDefaults.standard.bool(forKey: "clickHappened"))
              
        if UserDefaults.standard.bool(forKey: "clickHappened"){
            afterClickLocation()
        }
        else{
            getLocation()
        }
    }
    
    func doubleToLocation(coordinates: [Double]) -> CLLocation{
        return CLLocation(latitude: coordinates[0], longitude: coordinates[1])
    }
    
    private func getLocation(){
        LocationManager.shared.getLocation{location in
            
            print(String(describing: location))
            print("OLMAZ")
            
            WeatherManager.shared.getWeather(for: location){ [weak self] in
                
                DispatchQueue.main.async {
                    guard let currentWeather = WeatherManager.shared.currentWeather else {return}

                    self?.primaryView.configure(with: [
                        .current(viewModel: .init(model: currentWeather)),
                        .hourly(viewModels: WeatherManager.shared.hourlyWeather.compactMap({.init(model: $0)})),
                        .daily(viewModels: WeatherManager.shared.dailyWeather.compactMap({.init(model: $0)}))
                    ])
                }
            }
        }
    }
    
    public func afterClickLocation(){
            
            if let coordinates = UserDefaults.standard.array(forKey: "current-location") as? [Double] {
            print("OLUR")

            let location = doubleToLocation(coordinates: coordinates)
            WeatherManager.shared.getWeather(for: location){ [weak self] in
                
                DispatchQueue.main.async {
                    guard let currentWeather = WeatherManager.shared.currentWeather else {return}
                    
                    self?.primaryView.configure(with: [
                        .current(viewModel: .init(model: currentWeather)),
                        .hourly(viewModels: WeatherManager.shared.hourlyWeather.compactMap({.init(model: $0)})),
                        .daily(viewModels: WeatherManager.shared.dailyWeather.compactMap({.init(model: $0)}))
                    ])
                }
            }
                UserDefaults.standard.set(true, forKey: "clickHappened")

        } else {
            print("Failed to retrieve coordinates as [Double]")
        }
    }
    
    func setUpView(){
        
        view.addSubview(primaryView)
        view.backgroundColor = .systemBackground
        NSLayoutConstraint.activate([primaryView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
                                     primaryView.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor),
                                     primaryView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
                                     primaryView.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor)])
    }
}
    

    


