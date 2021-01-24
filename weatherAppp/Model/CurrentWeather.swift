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


struct Clouds: Codable {
    let all: Int
    
}

struct Coordinates: Codable {
    let lon: Float
    let lat: Float
}


struct Sys: Codable {
    let country: String
    let timezone: Int
    let sunrise: Int
    let sunset: Int
}


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

struct Wind: Codable {
    let speed: Int
    let deg: Int
}


struct City: Codable {
    let id: Int
    let coordinates: Coordinates
    let name: String

    init(id: Int, coordinates: Coordinates, name: String) {
        self.id = id
        self.coordinates = coordinates
        self.name = name
    }
    
    init(from currentWeather: CurrentWeather) {
        self.id = currentWeather.cityId
        self.coordinates = currentWeather.coord
        self.name = currentWeather.cityName
    }

}


struct CurrentWeatherList: Codable {
    var currentWeathers: [CurrentWeather]
    
    enum CodingKeys: String, CodingKey {
        case currentWeathers = "list"
    }
}
