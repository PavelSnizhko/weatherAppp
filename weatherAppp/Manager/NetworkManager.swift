//
//  NetworkManager.swift
//  weatherAppp
//
//  Created by Павел Снижко on 23.01.2021.
//

import Foundation

enum NetworkingErrors: String, Error {
    case CityByNameError = "Something wrong with city data"
    case ServerError = " The server has problem.Or posible you write wrong city name"
}




class NetworkManager {
    enum Units: String {
        case standard, metric, imperial
    }
    
    enum Exclude: String {
        case minutely, hourly, daily, alerts, current
    }
    
    private let schema = "https"
    private let host = "api.openweathermap.org"
    private let unit = Units.metric
    
    
    func getCurrentWeather(by cityName: String, completion: @escaping (Result<CurrentWeather, NetworkingErrors>) -> ()) {
        var components = URLComponents()
        components.scheme = self.schema
        components.host = self.host
        components.path = "/data/2.5/weather"
        components.queryItems = [
            URLQueryItem(name: "q", value: cityName),
            URLQueryItem(name: "units", value: unit.rawValue),
            URLQueryItem(name: "appid", value: "eb0db420f68bf3b425633d9d4070a0b4")
        ]
        
        var request = URLRequest(url: components.url!)
        request.httpMethod = "GET"
        
        URLSession.shared.dataTask(with: request) {(data, response, error) in
            if error == nil {
                let decoder = JSONDecoder()
                if let data = data {
                    print(data)
                    do {
                        let currentWeather = try decoder.decode(CurrentWeather.self, from: data)
                        DispatchQueue.main.async {
                            completion(.success(currentWeather))
                        }
                    } catch {
                        DispatchQueue.main.async {
                            completion(.failure(.ServerError))
                        }
                    }
                }
            }
            else {
                DispatchQueue.main.async {
                    completion(.failure(.ServerError))
                }
            }
        }.resume()
    }
    
    func getCurrentWeathers(by citiesId: [Int], completion: @escaping (Result<CurrentWeatherList, NetworkingErrors>) -> ()) {
        var components = URLComponents()
        let citiesIdString = citiesId.map{"\($0)"}.joined(separator: ",")
        components.scheme = self.schema
        components.host = self.host
        components.path = "/data/2.5/group"
        components.queryItems = [
            URLQueryItem(name: "id", value: citiesIdString),
            URLQueryItem(name: "units", value: unit.rawValue),
            URLQueryItem(name: "appid", value: "eb0db420f68bf3b425633d9d4070a0b4")
        ]
        
        var request = URLRequest(url: components.url!)
        request.httpMethod = "GET"
        URLSession.shared.dataTask(with: request) {(data, response, error) in
            if error == nil {
                let decoder = JSONDecoder()
                if let data = data {
                    do {
                        let currentWeathers = try decoder.decode(CurrentWeatherList.self, from: data)
                        DispatchQueue.main.async {
                            completion(.success(currentWeathers))
                        }
                    } catch {
                        DispatchQueue.main.async {
                            completion(.failure(.ServerError))
                        }
                    }
                }
            }
            else {
                DispatchQueue.main.async {
                    completion(.failure(.ServerError))
                }
            }
        }.resume()
        
    func getDailyForecast(by coord: (Float, Float), completion: @escaping (Result<Forecast, NetworkingErrors>) -> ()) {
            var components = URLComponents()
            let citiesIdString = citiesId.map{"\($0)"}.joined(separator: ",")
            components.scheme = self.schema
            components.host = self.host
            components.path = "/data/2.5/onecall"
            components.queryItems = [
                URLQueryItem(name: "lat", value: "\(coord.0)"),
                URLQueryItem(name: "lon", value: "\(coord.1)"),
                URLQueryItem(name: "exclude", value: "\(Exclude.minutely), \(Exclude.hourly), \(Exclude.current), \(Exclude.alerts)"),
                URLQueryItem(name: "units", value: unit.rawValue),
                URLQueryItem(name: "appid", value: "eb0db420f68bf3b425633d9d4070a0b4")
            ]
            
            var request = URLRequest(url: components.url!)
            
            request.httpMethod = "GET"
            URLSession.shared.dataTask(with: request) {(data, response, error) in
                if error == nil {
                    let decoder = JSONDecoder()
                    if let data = data {
                        do {
                            let currentWeathers = try decoder.decode(Forecast.self, from: data)
                            DispatchQueue.main.async {
                                completion(.success(currentWeathers))
                            }
                        } catch {
                            DispatchQueue.main.async {
                                completion(.failure(.ServerError))
                            }
                        }
                    }
                }
                else {
                    DispatchQueue.main.async {
                        completion(.failure(.ServerError))
                    }
                }
            }.resume()
            
        }
    }
    
}
