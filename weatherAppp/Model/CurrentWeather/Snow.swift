//
//  Snow.swift
//  weatherAppp
//
//  Created by Павел Снижко on 25.01.2021.
//

import Foundation

struct Snow: Codable {
    let lastHour: Float
    
    enum CodingKeys: String, CodingKey {
        case lastHour = "1h"
    }
}
