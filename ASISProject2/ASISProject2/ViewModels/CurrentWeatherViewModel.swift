//
//  CurrentWeatherViewModel.swift
//  ASISProject2
//
//  Created by Armağan Gül on 20.08.2024.
//

import Foundation

enum WeatherViewModel{
    case current(viewModel: CurrentWeatherCollectionViewCellViewModel)
    case hourly(viewModels: [HourlyWeatherCollectionViewCellViewModel])
    case daily(viewModels: [DailyWeatherCollectionViewCellViewModel])
}
