//
//  Condition.swift
//  FlySafe
//
//  Created by LiziChichua on 16.01.22.
//

import Foundation

struct Condition: Codable {
    var condition: String?
    var conditionImage: String?
    
    enum CodingKeys: String, CodingKey {
        case condition = "text"
        case conditionImage = "icon"
    }
}
