//
//  WeatherViewModel.swift
//  WeatherApp
//
//  Created by Kaffoux on 23/05/2021.
//

import Foundation

class WeatherViewModel: ObservableObject {
    
    @Published private(set) var model: WeatherModel = WeatherModel(cities: ["Venice", "Pekin", "Paris", "Warsaw", "Dubai", "Berlin", "Barcelona", "Tokyo", "Białystok", "London", "Prague"])
    
    var records: Array<WeatherModel.WeatherRecord> {
        model.records
    }
    
    func getWeatherIcon(record: WeatherModel.WeatherRecord) -> String {
        switch record.weatherState {
            case WeatherModel.WeatherState.Snow:
                return "🌨"
            case WeatherModel.WeatherState.Thunderstrom:
                return "⛈"
            case WeatherModel.WeatherState.HeavyRain:
                return "🌧"
            case WeatherModel.WeatherState.Showers:
                return "🚿"
            case WeatherModel.WeatherState.HeavyCloud:
                return "🌥"
            case WeatherModel.WeatherState.LightCloud:
                return "🌤"
            case WeatherModel.WeatherState.Clear:
                return "☀️"
        }
    }
    
    func refresh(record: WeatherModel.WeatherRecord) {
//        objectWillChange.send()
        model.refresh(record: record)
    }
}
