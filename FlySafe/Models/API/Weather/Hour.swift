//
//  Hour.swift
//  FlySafe
//
//  Created by LiziChichua on 16.01.22.
//

import Foundation

struct Hour: Codable {
    var time: String?
    var celsius: Double?
    var fahrenheit: Double?
    var condition: Condition?
    
    enum CodingKeys: String, CodingKey {
        case time = "time"
        case celsius = "temp_c"
        case fahrenheit = "temp_f"
        case condition = "condition"
    }
}
