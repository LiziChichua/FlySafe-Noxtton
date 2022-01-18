//
//  Astro.swift
//  FlySafe
//
//  Created by LiziChichua on 16.01.22.
//

import Foundation

struct Astro: Codable{
    var sunrise: String?
    var sunset: String?
    
    enum CodingKeys: String, CodingKey {
        case sunrise = "sunrise"
        case sunset = "sunset"
    }
}
