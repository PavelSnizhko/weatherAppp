//
//  CurrentWeatherList.swift
//  weatherAppp
//
//  Created by Павел Снижко on 25.01.2021.
//

import Foundation

struct CurrentWeatherList: Codable {
    var currentWeathers: [CurrentWeather]
    
    enum CodingKeys: String, CodingKey {
        case currentWeathers = "list"
    }
}
