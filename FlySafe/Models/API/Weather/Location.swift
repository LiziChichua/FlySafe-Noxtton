//
//  Location.swift
//  FlySafe
//
//  Created by LiziChichua on 16.01.22.
//

import Foundation

struct Location: Codable {
    var name: String?
    var region: String?
    var country: String?
    
    enum CodingKeys: String, CodingKey {
        case name = "name"
        case region = "region"
        case country = "country"
    }
}
