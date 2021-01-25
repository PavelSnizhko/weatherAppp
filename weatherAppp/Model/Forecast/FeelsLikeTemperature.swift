//
//  FeelsLikeTemperature.swift
//  weatherAppp
//
//  Created by Павел Снижко on 25.01.2021.
//

import Foundation


struct FeelsLikeTemperature: Codable {
    let day: Float
    let night: Float
    let evening: Float
    let morning: Float
    
    enum CodingKeys: String, CodingKey {
        case night, day
        case evening = "eve"
        case morning = "morn"
    }
}
