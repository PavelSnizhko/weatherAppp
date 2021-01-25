//
//  DailyTemperature.swift
//  weatherAppp
//
//  Created by Павел Снижко on 25.01.2021.
//

import Foundation

struct DailyTemperature: Codable {
    let day: Float
    let min: Float
    let max: Float
    let night: Float
    let evening: Float
    let morning: Float
    
    enum CodingKeys: String, CodingKey {
        case day, min, max, night
        case evening = "eve"
        case morning = "morn"
    }
}

