//
//  FetchNationalities.swift
//  FlySafe
//
//  Created by Nika Topuria on 19.12.21.
//

import Foundation


struct FetchNationalities: Codable {
    let success: Bool
    let nationalities: [String]
    
    enum CodingKeys: String, CodingKey {
        case success
        case nationalities = "nacionalities"
    }
}
