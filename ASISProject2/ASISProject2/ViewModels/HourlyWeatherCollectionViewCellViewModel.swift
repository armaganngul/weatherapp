//
//  HourlyWeatherCollectionViewCellViewModel.swift
//  ASISProject2
//
//  Created by Armağan Gül on 20.08.2024.
//

import Foundation
import WeatherKit

struct HourlyWeatherCollectionViewCellViewModel{
    private let model: HourWeather
    
    init(model: HourWeather){
        self.model = model
    }
    
    public var iconname: String{
        return model.symbolName
    }
    
    public var temperature: String{
        return model.temperature.description
    }
    
    public var hour: String{
        let hour = Calendar.current.component(.hour, from: model.date)
        return "\(hour):00"
    }
}
