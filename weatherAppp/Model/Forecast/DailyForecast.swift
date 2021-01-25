//
//  DailyForecast.swift
//  weatherAppp
//
//  Created by Павел Снижко on 25.01.2021.
//

import Foundation


struct DailyForecast: Codable {
    let temperature: DailyTemperature
    let feelsLikeTemperature: FeelsLikeTemperature
    let pressure: Int
    let humidity: Int
    let dewPoint: Float
    let windSpeed: Float
    let windDeg: Float
    let additionalWeather: [AdditionalWeather]
    let clouds: Int
    let pop: Int
    let rain: Float
    let uvi: Float
    
    enum CodingKeys: String, CodingKey {
        case temperature = "temp"
        case feelsLikeTemperature = "feels_like"
        case dewPoint = "dew_point"
        case windSpeed = "wind_speed"
        case windDeg = "wind_deg"
        case additionalWeather = "weather"
        case pressure, humidity, clouds, pop, rain, uvi

    }
}
