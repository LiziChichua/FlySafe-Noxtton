//
//  Forecast.swift
//  FlySafe
//
//  Created by LiziChichua on 16.01.22.
//

import Foundation

struct Forecast: Codable {
    var forecastDay: [ForecastDay]?
    
    enum CodingKeys: String, CodingKey {
        case forecastDay = "forecastday"
    }
}
