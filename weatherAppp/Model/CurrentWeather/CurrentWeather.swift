//
//  CurrentWeather.swift
//  weatherAppp
//
//  Created by Павел Снижко on 24.01.2021.
//

import Foundation


struct CurrentWeather: Codable {
    let coord: Coordinates
    let additionalWeather: [AdditionalWeather]
    let mainWeather: MainWeather
    let visibility: Int
    let wind: Wind
    let clouds: Clouds
    var rain: Rain?
    var snow: Snow?
    let dt: Int
    let cityId: Int
    let cityName: String
    
    
    enum CodingKeys: String, CodingKey {
        case coord, rain, snow, visibility, wind, clouds, dt
        case additionalWeather = "weather"
        case mainWeather = "main"
        case cityId = "id"
        case cityName = "name"
    }
}




struct Wind: Codable {
    let speed: Float
    let deg: Float
    var gust: Float?
}



