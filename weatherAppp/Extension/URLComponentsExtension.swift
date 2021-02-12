//
//  URLComponentsExtension.swift
//  weatherAppp
//
//  Created by Павел Снижко on 12.02.2021.
//

import Foundation

extension URLComponents {
    
    mutating func setQueryItems(with parameters: [String: String]) {
        self.queryItems = parameters.map { URLQueryItem(name: $0.key, value: $0.value) }
    }
    
}
