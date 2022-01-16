//
//  ForecastDay.swift
//  FlySafe
//
//  Created by LiziChichua on 16.01.22.
//

import Foundation

struct ForecastDay: Codable {
    var date : String?
    var day: Day?
    var astro: Astro?
    var hour: [Hour]?
    
    enum CodingKeys: String, CodingKey {
        case date = "date"
        case day = "day"
        case astro = "astro"
        case hour = "hour"
    }
    
}
