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
    let pop: Float
    var rain: Float?
    var snow: Float?
    var windGust: Float?
    let uvi: Float
    
    enum CodingKeys: String, CodingKey {
        case temperature = "temp"
        case feelsLikeTemperature = "feels_like"
        case dewPoint = "dew_point"
        case windSpeed = "wind_speed"
        case windDeg = "wind_deg"
        case additionalWeather = "weather"
        case windGust = "wind_gust"
        case pressure, humidity, clouds, pop, rain, uvi, snow

    }
}
