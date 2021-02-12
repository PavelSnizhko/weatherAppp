//
//  NetworkManager.swift
//  weatherAppp
//
//  Created by Павел Снижко on 23.01.2021.
//

import Foundation

enum RequestsConstant: String {
    case schema = "https"
    case host = "api.openweathermap.org"
    case currentWeathersPathForOneCity = "/data/2.5/weather"
    case currentWeathersPathForGroupCities = "/data/2.5/group"
    case dailyForecastPath = "/data/2.5/onecall"
    case APIKey = "eb0db420f68bf3b425633d9d4070a0b4"
    
    enum Units: String {
        case standard, metric, imperial
    }
    
    enum Exclude: String {
        case minutely, hourly, daily, alerts, current
    }
        
}

enum NetworkingErrors: String, Error {
    case cityByNameError = "Something wrong with city data"
    case serverError = " The server has problem.Or posible you write wrong city name"
    case badUrl = "Bad url"
}


class NetworkManager {
    
    private enum httpMethods: String {
        case get = "GET"
        case post = "POST"
        case put = "PUT"
        case delete = "DELETE"
    }
    
    private var urlComponents: URLComponents {
        var urlComponents = URLComponents()
        urlComponents.scheme = RequestsConstant.schema.rawValue
        urlComponents.host = RequestsConstant.host.rawValue
        return urlComponents
        
    }
    private let urlSession = URLSession.shared
    

    private func loadData<T: Codable>(pathToResources: RequestsConstant, parameters: [String: String], completion: @escaping (Result<T, NetworkingErrors>) -> ()) {
        var urlComponents = self.urlComponents
        urlComponents.path = pathToResources.rawValue
        urlComponents.setQueryItems(with: parameters)
        
        guard let url = urlComponents.url else { return completion(.failure(.badUrl)) }
        var request = URLRequest(url: url)
        request.httpMethod = httpMethods.get.rawValue
        URLSession.shared.dataTask(with: request) {(data, response, error) in
            if error == nil {
                let decoder = JSONDecoder()
                if let data = data {
                    do {
                        let currentWeather = try decoder.decode(T.self, from: data)
                        DispatchQueue.main.async {
                            completion(.success(currentWeather))
                        }
                    } catch {
                        DispatchQueue.main.async {
                            completion(.failure(.serverError))
                        }
                    }
                }
            }
            else {
                DispatchQueue.main.async {
                    completion(.failure(.serverError))
                }
            }
        }.resume()
    }
}



extension NetworkManager {
    
    func getCurrentWeather(by cityName: String, unit: RequestsConstant.Units, completion: @escaping (Result<CurrentWeather, NetworkingErrors>) -> ()) {
        
        let parameters = ["q": cityName, "units": unit.rawValue, "appid": RequestsConstant.APIKey.rawValue]
        loadData(pathToResources: .currentWeathersPathForOneCity, parameters: parameters, completion: completion)
    }
    
}



extension NetworkManager {
    
    func getCurrentWeathers(by citiesId: [Int], unit: RequestsConstant.Units, completion: @escaping (Result<CurrentWeatherList, NetworkingErrors>) -> ()) {
        let citiesIdString = citiesId.map{"\($0)"}.joined(separator: ",")
        let parameters = ["id": citiesIdString, "units": unit.rawValue, "appid": RequestsConstant.APIKey.rawValue]
        loadData(pathToResources: .currentWeathersPathForGroupCities, parameters: parameters, completion: completion)
    }
}


extension NetworkManager {
    
    func getDailyForecast(by coord: (Double, Double), unit: RequestsConstant.Units, excludes: [RequestsConstant.Exclude], completion: @escaping (Result<Forecast, NetworkingErrors>) -> ()) {

        let excludeString = excludes.map( { $0.rawValue }).joined(separator: ",")
        let parameters = ["lon": "\(coord.0)", "lat": "\(coord.1)", "exclude": excludeString, "units": unit.rawValue, "appid": RequestsConstant.APIKey.rawValue]
        loadData(pathToResources: .dailyForecastPath, parameters: parameters, completion: completion)
    }
}
