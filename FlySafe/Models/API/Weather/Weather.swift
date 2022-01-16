//
//  Weather.swift
//  FlySafe
//
//  Created by LiziChichua on 16.01.22.
//

import Foundation

struct Weather: Codable {
    var location: Location?
    var currentInfo: CurrentInfo?
    var forecast: Forecast?
    
    enum CodingKeys: String, CodingKey {
        case location = "location"
        case currentInfo = "current"
        case forecast = "forecast"
        
    }
}
