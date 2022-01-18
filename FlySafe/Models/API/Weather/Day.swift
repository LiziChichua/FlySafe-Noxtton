//
//  Day.swift
//  FlySafe
//
//  Created by LiziChichua on 16.01.22.
//

import Foundation

struct Day: Codable {
    var maxTempCelsius: Double?
    var maxTempFahrenheit: Double?
    var minTempCelsius: Double?
    var minTempFahrenheit: Double?
    var condition: Condition?
    
    enum CodingKeys: String, CodingKey {
        case maxTempCelsius = "maxtemp_c"
        case maxTempFahrenheit = "maxtemp_f"
        case minTempCelsius = "mintemp_c"
        case minTempFahrenheit = "mintemp_f"
        case condition = "condition"
    }
}
