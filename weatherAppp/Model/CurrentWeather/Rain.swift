//
//  Rain.swift
//  weatherAppp
//
//  Created by Павел Снижко on 25.01.2021.
//

import Foundation

struct Rain: Codable {
   var lastHour: Float?
    
    enum CodingKeys: String, CodingKey {
        case lastHour = "1h"
    }
}
