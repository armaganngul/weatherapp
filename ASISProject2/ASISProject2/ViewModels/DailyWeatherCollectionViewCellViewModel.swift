//
//  DailyWeatherCollectionViewCellViewModel.swift
//  ASISProject2
//
//  Created by Armağan Gül on 20.08.2024.
//

import Foundation
import WeatherKit

struct DailyWeatherCollectionViewCellViewModel{
    
    private let currWeather = CurrentWeatherCollectionViewCell()
    private let model: DayWeather
    init(model: DayWeather){
        self.model = model
    }
    
    static let dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        return formatter
    }()
    
    public var iconname: String{
        return model.symbolName
    }
    
    public var temperature: String{
        let lowHigh = "L: \(String(model.lowTemperature.description.prefix(2))+"°") - H: \(String(model.highTemperature.description.prefix(2))+"°")"
        print(lowHigh)
        
        let lines = lowHigh.split(separator: "\n")
        let firstLine = lines.first!
        UserDefaults.standard.set(String(firstLine), forKey: "dailyweather")
        return lowHigh
    }
    
    public var date: String{
        let day = Calendar.current.component(.weekday, from: model.date)
        return string(from: day)
    }
    
    public func string(from day: Int) -> String {
        switch (day){
        case 1:
            return "Monday"
        case 2:
            return "Tuesday"
        case 3:
            return "Wednesday"
        case 4:
            return "Thursday"
        case 5:
            return "Friday"
        case 6:
            return "Saturday"
        case 7:
            return "Sunday"
        default:
            return "-"
        }
    }
}


