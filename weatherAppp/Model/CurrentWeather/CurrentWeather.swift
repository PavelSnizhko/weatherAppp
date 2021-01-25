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
    let dt: Int
    let cityId: Int
    let cityName: String
    
    
    enum CodingKeys: String, CodingKey {
        case coord
        case additionalWeather = "weather"
        case mainWeather = "main"
        case visibility
        case wind
        case clouds
        case dt
        case cityId = "id"
        case cityName = "name"
    }
}




struct Wind: Codable {
    let speed: Int
    let deg: Int
}



