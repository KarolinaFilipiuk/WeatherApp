//
//  WeatherModel.swift
//  WeatherApp
//
//  Created by Kaffoux on 23/05/2021.
//

import Foundation

struct WeatherModel {
    
    var records: Array<WeatherRecord> = []
    
    init(cities: Array<String>) {
        records = Array<WeatherRecord>()
        for city in cities {
            records.append(WeatherRecord(cityName: city))
        }
        
    }
    
    enum WeatherState: String, CaseIterable {
        case Snow = "Snow"
        case Thunderstrom = "Thunderstorm"
        case HeavyRain = "Heavy Rain"
        case Showers = "Showers"
        case HeavyCloud = "Heavy Clound"
        case LightCloud = "Light Cloud"
        case Clear = "Clear"
    }
    
    struct WeatherRecord: Identifiable {
        var id: UUID = UUID()
        var cityName: String
        var weatherState: WeatherState = WeatherState
            .allCases
            .randomElement() ?? WeatherState.Clear
        var temperature: Float = Float.random(in: -10.0 ... 30.0)
        var humidity: Float = Float.random(in: 0 ... 100)
        var windSpeed: Float = Float.random(in: 0 ... 20)
        var windDirection: Float = Float.random(in: 0 ..< 360)
    }
    
    mutating func refresh(record: WeatherRecord) {
        let idx = records.firstIndex(where: {$0.id == record.id} )
        records[idx!].temperature = Float.random(in: -10.0 ... 30.0)
        records[idx!].humidity = Float.random(in: 0 ... 100)
        records[idx!].windSpeed = Float.random(in: 0 ... 20)
        records[idx!].windDirection = Float.random(in: 0 ..< 360)
    }
}
