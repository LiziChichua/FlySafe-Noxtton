//
//  CurrentInfo.swift
//  FlySafe
//
//  Created by LiziChichua on 16.01.22.
//

import Foundation

struct CurrentInfo: Codable {
    var condition: Condition?
    var celsius: Double?
    var fahrenheit: Double?
    var windSpeedkm: Double?
    var windSpeedmiles: Double?
    var humidity: Int?
    var pressure: Double?
    
    enum CodingKeys: String, CodingKey {
        case condition = "condition"
        case celsius = "temp_c"
        case fahrenheit = "temp_f"
        case windSpeedkm = "vis_km"
        case windSpeedmiles = "vis_miles"
        case humidity = "humidity"
        case pressure = "pressure_mb"
    }
}
