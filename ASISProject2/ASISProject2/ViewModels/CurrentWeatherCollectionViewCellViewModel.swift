//
//  CurrentWeatherCollectionViewCellViewModel.swift
//  ASISProject2
//
//  Created by Armağan Gül on 20.08.2024.
//

import Foundation
import WeatherKit
import CoreLocation

struct CurrentWeatherCollectionViewCellViewModel{
    
    private let model: CurrentWeather
    
    init(model: CurrentWeather){
        self.model = model
    }
    
    public var condition: String {
        return model.condition.description
    }
    
    public var temperature: String {
        return model.temperature.description
    }
    
    public var iconname: String {
        return model.symbolName
    }
    
    public var cityLocation: CLLocation{
        model.metadata.location
    }
}
