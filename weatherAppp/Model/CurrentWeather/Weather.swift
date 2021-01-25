//
//  Weather.swift
//  weatherAppp
//
//  Created by Павел Снижко on 25.01.2021.
//

import Foundation


struct AdditionalWeather: Codable {
    let id: Int
    let main: String
    let description: String
    let icon: String
}

struct MainWeather: Codable {
    let temp: Float
    let feelsLikeTemp: Float
    let tempMin: Float
    let tempMax: Float
    let pressure: Int
    let humidity: Int
    
    enum CodingKeys: String, CodingKey {
        case temp
        case feelsLikeTemp = "feels_like"
        case tempMin = "temp_min"
        case tempMax = "temp_max"
        case pressure
        case humidity
    }
}
