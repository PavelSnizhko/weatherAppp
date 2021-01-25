//
//  Forecast.swift
//  weatherAppp
//
//  Created by Павел Снижко on 25.01.2021.
//

import Foundation

struct Forecast: Codable {
    let daily: [DailyForecast]
}
